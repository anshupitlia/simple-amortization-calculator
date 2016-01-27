module Calculator
	def self.calculate(amortization)
		monthly_interest_rate = (amortization.rate_of_interest / 12)/100
		total_number_of_months = amortization.tenure * 12
		
		factor = (1 + monthly_interest_rate) ** total_number_of_months
		emi = (amortization.loan_amount * monthly_interest_rate * factor) / (factor - 1)

		is_one_time_payment = 0
		is_yearly_payment = 0

		display_details = []
		display_details_hash = {}
		total_interest_paid = 0

		i = 1
		dateToday = Time.now

		if amortization.monthly_payment > 0.1
		  emi += amortization.monthly_payment
		end

		while amortization.loan_amount > 0.1
			dateToday = dateToday + 1.month
			monthly_interest_paid = amortization.loan_amount * monthly_interest_rate
			
			if ((amortization.date_one_time_payment).strftime("%b %Y").casecmp(dateToday.strftime("%b %Y")).zero?)
				is_one_time_payment = amortization.one_time_payment
			end

			if ((amortization.date_yearly_payment).strftime("%b %Y").casecmp(dateToday.strftime("%b %Y")).zero?)
				is_yearly_payment = amortization.yearly_payment
				amortization.date_yearly_payment += 1.year
			end

			
			if emi > (amortization.loan_amount + monthly_interest_paid)
				emi = (amortization.loan_amount + monthly_interest_paid)
			end

			principal_paid = emi - monthly_interest_paid + is_one_time_payment + is_yearly_payment
			new_balance = amortization.loan_amount - principal_paid

			if new_balance < 0.0
			  new_balance = 0.0
			end
			total_interest_paid = total_interest_paid + monthly_interest_paid
			display_details_hash.merge!({"total_number_of_months" => i, "emi" => (emi + is_yearly_payment + is_one_time_payment), "month_of_emi" => dateToday.strftime("%b %Y"), "loan_amount" => amortization.loan_amount, "monthly_interest_paid" => monthly_interest_paid, "total_interest_paid" => total_interest_paid, "principal_paid" => principal_paid, "new_balance" => new_balance})
			display_details.push(display_details_hash.clone)
			display_details_hash.clear
			amortization.loan_amount = new_balance
			is_one_time_payment = 0
			is_yearly_payment = 0
			i += 1
		end

		return display_details
	end
end
