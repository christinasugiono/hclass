class ItemsController < ApplicationController
  def index
    if params[:query].present?
      @results = Item.search_by(params[:query])
    elsif params[:category].present?
      @results = Item.where(category: params[:category])
    else
      @results = Item.all
    end

    @markers = @results.geocoded.map do |item|
      {
        lat: item.latitude,
        lng: item.longitude,
        info_window: render_to_string(partial: "info_window", locals: { item: item }),
        image_url: helpers.cl_image_path(item.photo.key)
      }
    end
  end

  def show
    @item = Item.find(params[:id])
    @booking = Booking.new
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(params[:item])
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :brand, :category, :photo, :address)
  end

end
