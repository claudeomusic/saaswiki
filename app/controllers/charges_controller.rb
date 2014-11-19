class ChargesController < ApplicationController
  def new
   @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "BigMoney Membership - #{current_user.username}",
     #amount: Amount.default
     amount: 0_00
   }
 end

  def create
   
     # Creates a Stripe Customer object, for associating
     # with the charge
     customer = Stripe::Customer.create(
       email: current_user.email,
       card: params[:stripeToken]
     )
   
     # Where the real magic happens
     charge = Stripe::Charge.create(
       customer: customer.id, # Note -- this is NOT the user_id in your app
       #amount: Amount.default,
       amount: 10_00,
       description: "BigMoney Membership - #{current_user.email}",
       currency: 'usd'
     )
   
     flash[:success] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
     redirect_to user_path(current_user) # or wherever
   
   # Stripe will send back CardErrors, with friendly messages
   # when something goes wrong.
   # This `rescue block` catches and displays those errors.
   rescue Stripe::CardError => e
     flash[:error] = e.message
     redirect_to new_charge_path
   end
end
