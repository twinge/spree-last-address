require 'find_address'

Spree::CheckoutController.class_eval do

  private

  def before_address
    #puts "BEFORE ADDRESS2 called user= #{@order}  #{@order.email}"
    @order.bill_address , @order.ship_address = FindAddressHelper.find_address(@order.email)
    # in case none found
    @order.bill_address ||= current_user.bill_address if current_user
    @order.ship_address ||= current_user.ship_address if current_user
    @order.bill_address ||= Address.new(:country_id => Spree::Config[:default_country_id])
    @order.ship_address ||= Address.new(:country_id => Spree::Config[:default_country_id])
  end


end
