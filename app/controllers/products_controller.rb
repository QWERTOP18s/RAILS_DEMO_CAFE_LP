class ProductsController < ApplicationController
  layout 'products_base'
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  def index
    if params[:search].present?
      @current = Product.where("name LIKE ?", "%#{params[:search]}%")
      @category = "#{helpers.pluralize(@current.count, 'result')} found"
    else
      @category = params[:category] || 'drink'
      @current = Product.where(category: @category)
    end
  end
  

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)
    @product.uid ||= SecureRandom.uuid
    @product.ref.attach(params[:product][:ref])
    if @product.save
      redirect_to @product
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @product.ref.attach(params[:product][:ref])
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_url
  end

  private

  def product_params
    params.require(:product).permit(:name, :cost, :price, :category, :description, :ref)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
