class WelcomeController < ApplicationController
  def index
    @products = Product.all
    session[:cart] ||= {}
  end

  def add_to_cart
    session[:cart] ||= {}
    session[:cart][params[:id]] ||= 0
    session[:cart][params[:id]] += 1
    product = Product.find(params[:id])
    redirect_to root_path, notice: "#{product&.name} has added to your cart"
  end

  def remove_from_cart
    session[:cart] ||= {}
    session[:cart].delete(params[:id])
    product = Product.find(params[:id])
    redirect_to root_path, notice: "#{product&.name} removed from your cart"
  end

  def bucket; end

  def create_order 
    total_price = 0
    session[:cart].each do |product_id, quantity|
     product = Product.find(product_id) unless product_id.blank?
     total_price += quantity * product&.price
    end
    if Order.create(total_price: total_price)
      session[:cart].clear
      message = "Successfully created order"
    else
      message =  "Failed created order"
    end
    redirect_to root_path, notice: message 
  end
end
  