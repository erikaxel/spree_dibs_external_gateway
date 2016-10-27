class Spree::DibsController < ActionController::Base
  skip_before_action :verify_authenticity_token, only: [:dibs_test_post]

  def dibs_test_post
    render template: 'spree/checkout/dibs_test_post', layout: false
  end


  # Parameters: {
  #   "acceptReturnUrl"=>"http://localhost:3000/checkout/dibs_return",
  #   "acquirer"=>"test",
  #   "actionCode"=>"d100",
  #   "amount"=>"818100",
  #   "billingAddress"=>"asdf",
  #   "billingAddress2"=>"",
  #   "billingEmail"=>"FIXME@FIXME.com",
  #   "billingFirstName"=>"asdf",
  #   "billingLastName"=>"asdf",
  #   "billingMobile"=>"1234579",
  #   "billingPostalCode"=>"1182",
  #   "billingPostalPlace"=>"Oslo",
  #   "cancelReturnUrl"=>"http://localhost:3000/checkout/dibs_cancel",
  #   "cardNumberMasked"=>"[FILTERED]",
  #   "cardTypeName"=>"VISA",
  #   "currency"=>"NOK",
  #   "expMonth"=>"06",
  #   "expYear"=>"24",
  #   "language"=>"nb_NO",
  #   "merchant"=>"90150856",
  #   "orderId"=>"R062662248",
  #   "payType"=>"VISA,MC",
  #   "status"=>"ACCEPTED",
  #   "test"=>"1",
  #   "transaction"=>"704219038"}

  def dibs_return
    retrieve_details

    @notification = ActiveMerchant::Billing::Integrations::Dibs::Notification.new(request.raw_post)

    if @notification.complete? && @notification.gross_cents / 100 >= @order.total # cents
      source = Spree::DibsPaymentSource.create(
          card_type: @notification.cardTypeName,
          dibs_transaction_number: @notification.transaction_id,
          exp_month: @notification.expMonth,
          exp_year: @notification.expYear,
          card_number_masked: @notification.cardNumberMasked
      )

      payment = @order.payments.create(
          amount: @notification.gross_cents / 100,
          payment_method_id: Spree::PaymentMethod.find_by_environment_and_active_and_type(Rails.env, true, "Spree::BillingIntegration::Dibs").id,
          source: source,
          source_type: 'Spree::DibsPaymentSource'
      )

      payment.authorize!
      payment.save

      @order.update_attributes({state: 'complete', completed_at: Time.now}, :without_protection => true)
      @order.finalize!

      # Unset the order id as it's completed.
      session[:order_id] = nil

      respond_with(@order, location: order_path(@order))
    else
      respond_with(@order, location: checkout_state_path(@order.state))
    end
  end


end