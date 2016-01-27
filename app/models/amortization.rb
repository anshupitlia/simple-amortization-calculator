require 'multi_parameter_attributes.rb'
class Amortization
  include Mongoid::Document
  field :loan_amount, type: Float
  field :rate_of_interest, type: Float
  field :tenure, type: Integer
  field :pre_payment, type: Float
  field :one_time_payment, type: Float, default: 0
  field :monthly_payment, type: Float, default: 0
  field :yearly_payment, type: Float, default: 0
  field :date_one_time_payment, type: DateTime, default: Time.now
  field :date_yearly_payment, type: DateTime, default: Time.now
  validates_numericality_of :loan_amount, :rate_of_interest, :tenure, :one_time_payment, :monthly_payment, :yearly_payment
  validates_presence_of :loan_amount, :rate_of_interest, :tenure
end
