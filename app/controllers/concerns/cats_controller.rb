class CatsController < ApplicationController

  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find_by_id(params[:id])
  end

  def new
    render :new
  end

  def edit
    @cat = Cat.find_by_id(params[:id])
    @cat.
    render :edit
  end

  def create
    @cat = Cat.new(cat_params)
      if @cat.save
        render :show
      else
        raise error "couldn't make cat"
      end

  end

  private

def cat_params
  params.require(:cat).permit(:name, :birth_date, :color, :sex, :description)
end
