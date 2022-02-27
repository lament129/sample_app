class ItemsController < ApplicationController
  def index
    @items = Item.where('supplier_reply > ?', Date.current).order(:supplier_reply).order(:order_number).order(:item_number)
    @part_numbers = Part.all.pluck(:part_number)
  end

  def import
    Item.import(params[:file])
    redirect_to("/")
  end

  def rescheduled
    @items = Item.where('supplier_reply > ?', Date.current).where(status: "Pull in").or(Item.where(status: "Push out")).order(:ex_reply).order(:supplier_reply).order(:order_number).order(:item_number)
    @part_numbers = Part.all.pluck(:part_number)
  end

  def date
    @items = Item.where(supplier_reply: params[:supplier_reply]).order(:supplier_reply).order(:order_number).order(:item_number)
    @supplier_reply = params[:supplier_reply].to_date
    @part_numbers = Part.all.pluck(:part_number)
  end

  def part
    @items = Item.where(part_number: params[:part_number]).where('supplier_reply > ?', Date.current).order(:supplier_reply).order(:order_number).order(:item_number)
    @part = Part.find_by(part_number: params[:part_number])
    @part_number = params[:part_number]
  end

  def work
    @items = Item.where(work_number: params[:work_number]).order(:item_number)
    @work_number = params[:work_number]
    @part_numbers = Part.all.pluck(:part_number)
  end

  def weld
    @items = Item.where('supplier_reply > ?', Date.current).where('points != ?', 0).order(:supplier_reply).order(:order_number).order(:item_number)
    @part_numbers = Part.all.pluck(:part_number)
  end

  def tig
    @part_numbers = Part.where(tig: true, out: nil).pluck(:part_number)
    @items = Item.where(part_number: @part_numbers).where('supplier_reply > ?', Date.current).order(:supplier_reply).order(:order_number).order(:item_number)
  end

  def add
    @part_numbers = Part.where(add: true, out: nil).pluck(:part_number)
    @items = Item.where(part_number: @part_numbers).where(out: nil).where('supplier_reply > ?', Date.current).order(:supplier_reply).order(:order_number).order(:item_number)
  end

  def bend
    @part_numbers = Part.where(bend: true, out: nil, laser: nil).pluck(:part_number)
    @items = Item.where(part_number: @part_numbers).where(out: nil).where('supplier_reply > ?', Date.current).order(:supplier_reply).order(:order_number).order(:item_number)
  end

  def laser
    @part_numbers = Part.where(laser: true,out: nil).pluck(:part_number)
    @items = Item.where(part_number: @part_numbers).where(out: nil).where('supplier_reply > ?', Date.current).order(:supplier_reply).order(:order_number).order(:item_number)
  end

  def valve
    @part_numbers = Part.where(valve: true, out: nil).pluck(:part_number)
    @items = Item.where(part_number: @part_numbers).where(out: nil).where('supplier_reply > ?', Date.current).order(:supplier_reply).order(:order_number).order(:item_number)
  end

  def ebw
    @part_numbers = Part.where(ebw: true).pluck(:part_number)
    @items = Item.where(part_number: @part_numbers).where('supplier_reply > ?', Date.current).order(:supplier_reply).order(:order_number).order(:item_number)
  end

  def long
    @part_numbers = Part.where(long: true).pluck(:part_number)
    @items = Item.where(part_number: @part_numbers).where('supplier_reply > ?', Date.current).order(:supplier_reply).order(:order_number).order(:item_number)
  end

  def out
    @part_numbers = Part.where(out: true, ebw: nil, long: nil).pluck(:part_number)
    @items = Item.where(part_number: @part_numbers).or(Item.where(out: true)).where('supplier_reply > ?', Date.current).order(:supplier_reply).order(:order_number).order(:item_number)
  end

  def laser_request_create
    @item = Item.find_by(id: params[:id])
    @item.las_req = true
    @item.save
  end

  def laser_request_cancel
    @item = Item.find_by(id: params[:id])
    @item.las_req = nil
    @item.save
  end

  def laser_receive_create
    @item = Item.find_by(id: params[:id])
    @item.las_rec = true
    @item.save
  end

  def laser_receive_cancel
    @item = Item.find_by(id: params[:id])
    @item.las_rec = nil
    @item.save
  end

  def part_search
    @parts = Part.where('part_number like ?',"%#{params[:part]}%").order(:part_number)
  end

  def work_search
    work = params[:work]
    redirect_to ("/items/work/#{work}")
  end
end