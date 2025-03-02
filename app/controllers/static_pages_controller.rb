class StaticPagesController < ApplicationController
  def home
    @drinks = Product.where(category: "drink")
    @meals = Product.where(category: "meal")
  end

  def about
  end
end
