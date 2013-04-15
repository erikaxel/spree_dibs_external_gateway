class Spree::BillingIntegration::Dibs < Spree::BillingIntegration
#class Spree::BillingIntegration::Dibs < Spree::PaymentMethod
  preference :merchant_id, :string
  #preference :test_mode, :boolean, :default => true

  #attr_accessible :preferred_test_mode, :preferred_merchant_id
  attr_accessible :preferred_merchant_id

  def provider_class
    ActiveMerchant::Billing::Integrations::Dibs
  end

  def self.current
    Spree::BillingIntegration::Dibs.where(:active => true).where(:environment => Rails.env.to_s).first
  end

  def actions
    %w(authorize capture)
  end

  def initialize(options = {})
    #requires!(options, :merchant, :return_url, :cancel_return_url)
    super
  end

  def can_authorize?(payment)
      true
  end

  def source_required?
    true
  end

  def payment_source_class
    Spree::DibsPaymentSource
  end

  # * <tt>authorize(money, creditcard, options = {})</tt>
  def authorize(*args)
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
    #%w(checkout pending).include?(payment.state)
    true
  end


  def capture(*args)
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

