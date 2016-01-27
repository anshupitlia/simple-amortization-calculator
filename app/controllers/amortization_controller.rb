require 'calculator.rb'
class AmortizationController < ApplicationController
  def new
  	@amortization_detail= Amortization.new
  end	

   def create
  	@amortization_detail = Amortization.new(amortization_params)
  	if @amortization_detail.save
  	  redirect_to @amortization_detail
    else
      render 'new'
    end
  end

  def show
  	amortization_detail = Amortization.find(params[:id])
  	@payment_details = Calculator.calculate(amortization_detail)
  end

  private 
  def amortization_params
  	params.require(:amortization_detail).permit(:loan_amount, :rate_of_interest, :tenure, :one_time_payment, :monthly_payment, :yearly_payment, :date_yearly_payment, :date_one_time_payment)
  end
end
