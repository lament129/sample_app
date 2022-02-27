module ItemsHelper
  def points(item)
    part = Part.find_by(part_number: item[:part_number])

    return 0 unless part
    return part.half + part.thr_eth + part.qtr + part.eth
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

  def remarks(item)
    text = ""

    text += "Tigあり/ " if tig?(item)
    text += "追加工あり/ " if add?(item) && !out?(item)
    text += "曲げあり/ " if bend?(item) && points(item) != 0 && !out?(item)
    text += "曲げのみ/ " if bend?(item) && points(item) == 0 && !out?(item)
    text += "レーザー/ " if laser?(item) && !out?(item)
    text += "バルブ/ " if valve?(item)
    text += "EBW/ " if ebw?(item)
    text += "長尺/ " if long?(item)
    text += "外注/ " if out?(item) && !ebw?(item) && !long?(item)

    text.slice!(-2, 1)
    
    return text.to_s
  end
end
