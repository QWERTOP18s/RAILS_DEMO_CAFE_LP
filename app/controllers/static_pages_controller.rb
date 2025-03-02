class StaticPagesController < ApplicationController
  def home
    @drinks = Product.where(category: 'drink')
    @meals = Product.where(category: 'meal')
    @etc = Product.where(category: 'etc')
  end

  def about
  end
end
