class Spree::BillingIntegration::Dibs < Spree::BillingIntegration
  #preference :merchant, :string
  #preference :return_url, :string
  #preference :cancel_return_url, :string

  #attr_accessible :preferred_merchant_id, preferred_return_url, preferred_cancel_return_url

  def provider_class
    self.class
  end


  def actions
    %w(authorize, capture)
  end

  def initialize(options = {})
    #requires!(options, :merchant, :return_url, :cancel_return_url)
    super
  end

  def can_authorize?(payment)
      true
  end

  def source_required?
    false
  end

  def payment_source_class
    nil
  end


  def authorize(payment, options = {})
    ActiveMerchant::Billing::Response.new(true, "", {}, {})
    #
    #ActiveMerchant::Billing::Response.new(true, 'DIBS: Forced success', {}, :test => true, :authorization => '12345', :avs_result => { :code => 'A' })

    #profile_id = credit_card.gateway_customer_profile_id
    #if VALID_CCS.include? credit_card.number or (profile_id and profile_id.starts_with? 'BGS-')

    #else
    #  ActiveMerchant::Billing::Response.new(false, 'Bogus Gateway: Forced failure', { :message => 'Bogus Gateway: Forced failure' }, :test => true)
    #end
  end

  def can_capture?(payment)
    %w(checkout pending).include?(payment.state)
  end


  def capture(payment, options = {})
    ActiveMerchant::Billing::Response.new(true, "", {}, {})
      #ActiveMerchant::Billing::Response.new(true, 'DIBS: Forced success', {}, :test => true, :authorization => '67890')
  end

  #def purchase(money, credit_card, options = {})
  #  profile_id = credit_card.gateway_customer_profile_id
  #  if VALID_CCS.include? credit_card.number  or (profile_id and profile_id.starts_with? 'BGS-')
  #    ActiveMerchant::Billing::Response.new(true, 'Bogus Gateway: Forced success', {}, :test => true, :authorization => '12345', :avs_result => { :code => 'A' })
  #  else
  #    ActiveMerchant::Billing::Response.new(false, 'Bogus Gateway: Forced failure', :message => 'Bogus Gateway: Forced failure', :test => true)
  #  end
  #end

  #def credit(money, credit_card, response_code, options = {})
  #  ActiveMerchant::Billing::Response.new(true, 'Bogus Gateway: Forced success', {}, :test => true, :authorization => '12345')
  #end

  #def capture(authorization, credit_card, gateway_options)
  #  if authorization.response_code == '12345'
  #    ActiveMerchant::Billing::Response.new(true, 'Bogus Gateway: Forced success', {}, :test => true, :authorization => '67890')
  #  else
  #    ActiveMerchant::Billing::Response.new(false, 'Bogus Gateway: Forced failure', :error => 'Bogus Gateway: Forced failure', :test => true)
  #  end
  #
  #end

  #def void(response_code, credit_card, options = {})
  #  ActiveMerchant::Billing::Response.new(true, 'Bogus Gateway: Forced success', {}, :test => true, :authorization => '12345')
  #end

  def payment_profiles_supported?
    false
  end


  private
  #def generate_profile_id(success)
  #  record = true
  #  prefix = success ? 'BGS' : 'FAIL'
  #  while record
  #    random = "#{prefix}-#{Array.new(6){rand(6)}.join}"
  #    record = CreditCard.where(:gateway_customer_profile_id => random).first
  #  end
  #  random
  #end
end

