class Item < ApplicationRecord
  require 'active_support/core_ext/object/try'

  def point(item)
    part = Part.find_by(part_number: item[:part_number])

    return 0 unless part
    part.half + part.thr_eth + part.qtr + part.eth
  end

  def half?(item)
    part = Part.find_by(part_number: item[:part_number])

    return false unless part
    return true if part.half > 0

    false
  end

  def eth?(item)
    part = Part.find_by(part_number: item[:part_number])

    return false unless part
    return true if part.eth > 0

    false
  end

  def tig?(item)
    part = Part.find_by(part_number: item[:part_number])

    return false unless part
    return true if part.tig == true
    
    false
  end

  def add?(item)
    part = Part.find_by(part_number: item[:part_number])

    return false unless part
    return true if part.add == true
    
    false
  end

  def bend?(item)
    part = Part.find_by(part_number: item[:part_number])

    return false unless part
    return true if part.bend == true
    
    false
  end

  def laser?(item)
    part = Part.find_by(part_number: item[:part_number])

    return false unless part
    return true if part.laser == true
    
    false
  end

  def valve?(item)
    part = Part.find_by(part_number: item[:part_number])

    return false unless part
    return true if part.valve == true
    
    false
  end

  def ebw?(item)
    part = Part.find_by(part_number: item[:part_number])

    return false unless part
    return true if part.ebw == true
    
    false
  end

  def long?(item)
    part = Part.find_by(part_number: item[:part_number])

    return false unless part
    return true if part.long == true
    
    false
  end

  def out?(item)
    part = Part.find_by(part_number: item[:part_number])

    return false unless part
    return true if item[:out] == true
    return true if part.out == true
    
    false
  end

  def add_remarks(item)
    text = ""

    text += "1/2″溶接あり/ " if half?(item) && !out?(item)
    text += "1/8″溶接あり/ " if eth?(item) && !out?(item)
    text += "Tigあり/ " if tig?(item)
    text += "追加工あり/ " if add?(item) && !out?(item)
    text += "曲げあり/ " if bend?(item) && point(item) != 0 && !out?(item)
    text += "曲げのみ/ " if bend?(item) && point(item) == 0 && !out?(item)
    text += "レーザー/ " if laser?(item) && !out?(item)
    text += "バルブ/ " if valve?(item)
    text += "EBW/ " if ebw?(item)
    text += "長尺/ " if long?(item)
    text += "外注/ " if out?(item) && !ebw?(item) && !long?(item)

    text.slice!(-2, 1)
    
    text.to_s
  end

  def self.import(file)
    xlsx = Roo::Excelx.new(file.tempfile)

    ord = xlsx.row(2).index("Order Nr") + 1
    itm = xlsx.row(2).index("Item") + 1
    par = xlsx.row(2).index("Material") + 1
    qty = xlsx.row(2).index {|v| v == "Qty" || v == "QTY"} + 1
    sup = xlsx.row(2).index("Supplier Reply") + 1
    wor = sup + 2
    rem = wor + 2

    xlsx.each_row_streaming(offset: 2, pad_cells: true) do |row|
      next unless row[ord]

      item = self.new(
        order_number: row[ord].value,
        item_number: row[itm].value,
        part_number: row[par].value.to_s.sub(/Rev.*/m, "").strip,
        qty: row[qty].value,
        supplier_reply: row[sup].value,
        work_number: row[wor].value.to_s.delete("^0-9").slice(0, 5),
        remarks: row[rem].value.to_s
      )

      next unless item.supplier_reply

      if $bloom.any? {|i| item.remarks.include?(i)}
        item.out = true
      else
        item.out = nil
      end

      item.note = item.add_remarks(item) + item.remarks
      
      if item.out?(item)
        item.points = 0
      else
        item.points = item.point(item) * item.qty
      end

      item_exist = Item.find_by(order_number: item.order_number, item_number: item.item_number)

      if item_exist
        item_exist.part_number = item.part_number
        item_exist.qty = item.qty
        item_exist.ex_reply = item_exist.supplier_reply
        item_exist.supplier_reply = item.supplier_reply
        item_exist.out = item.out
        item_exist.note = item.note
        item_exist.points = item.points

        if item_exist.supplier_reply < item_exist.ex_reply
          item_exist.status = "Pull in"
        elsif item_exist.supplier_reply > item_exist.ex_reply
          item_exist.status = "Push out"
        else
          item_exist.status = "Remain"
        end

        item_exist.save

      else
        item.status = "New"
        item.save
      end
    end
    
    past_items = Item.where('supplier_reply < ?', Date.current)
    
    past_items.each do |past|
      past.status = "Remain"
      past.save
    end
  end
end
