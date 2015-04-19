class Spree::BillingIntegration::Dibs < Spree::BillingIntegration
  preference :merchant, :string
  preference :currency, :string
  preference :language, :string

  def provider_class
    ActiveMerchant::Billing::Integrations::Dibs
  end

  def self.current
    Spree::BillingIntegration::Dibs.where(active: true).where(environment: Rails.env.to_s).first
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
    ActiveMerchant::Billing::Response.new(true, '', {}, {})
  end

  def can_capture?(payment)
    #%w(checkout pending).include?(payment.state)
    true
  end

  def capture(*args)
    ActiveMerchant::Billing::Response.new(true, "", {}, {})
  end

  def payment_profiles_supported?
    false
  end
end

