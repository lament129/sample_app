class PartsController < ApplicationController
  def index
    @parts = Part.all.order(part_number: "ASC")
    @part = Part.find_by(part_number: params[:part_number])

    unless @part
      @part = Part.new(part_number: params[:part_number])
    end
  end

  def destroy
    @part = Part.find_by(part_number: params[:part_number])
    @items = Item.where(part_number: @part.part_number)

    @part.destroy

    @items.each do |item|
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

      item.save
    end

    redirect_to("/parts")
  end

  def register
    @part = Part.find_by(part_number: params[:part_number])
    
    if @part
      @part.half = params[:half]
      @part.thr_eth = params[:thr_eth]
      @part.qtr = params[:qtr]
      @part.eth = params[:eth]
      @part.tig = params[:tig]
      @part.add = params[:add]
      @part.bend = params[:bend]
      @part.laser = params[:laser]
      @part.valve = params[:valve]
      @part.ebw = params[:ebw]
      @part.long = params[:long]
      @part.out = params[:out]

    else
      @part = Part.new(
        part_number: params[:part_number],
        half: params[:half],
        thr_eth: params[:thr_eth],
        qtr: params[:qtr],
        eth: params[:eth],
        tig: params[:tig],
        add: params[:add],
        bend: params[:bend],
        laser: params[:laser],
        valve: params[:valve],
        ebw: params[:ebw],
        long: params[:long],
        out: params[:out]
      )
    end

    @part.half = 0 unless @part.half
    @part.thr_eth = 0 unless @part.thr_eth
    @part.qtr = 0 unless @part.qtr
    @part.eth = 0 unless @part.eth

    @part.save
    
    @items = Item.where(part_number: @part.part_number)

    @items.each do |item|
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

      item.save
    end

    redirect_to("/parts")
  end
end
