class CustomersController < ApplicationController
  def index

  end

  def show

  end

  def new

  end

  def create
    customer = Customer.new(customer_params)
    if customer.save
      flash[:success] = "Welcome, #{customer.full_name}!"
      redirect_to customer_path(customer)
    else
      flash[:error] = 'Oops!'
      redirect_to new_customer_path
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :address)
  end
end