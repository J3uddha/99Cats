class CatsController < ApplicationController

  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find_by_id(params[:id])
  end

  def new
    @cat = Cat.new(params[:id])
    if @cat.save

    else
      raise "couldn't save"
    end

    nil
  end

end
