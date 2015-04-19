class Spree::DibsPaymentSource < ActiveRecord::Base
  has_one :payment, as: :source

  def actions
    %w{capture void credit}
  end

  # Indicates whether its possible to capture the payment
  def can_capture?(payment)
    payment.state == 'pending' || payment.state == 'checkout'
  end

  # Indicates whether its possible to void the payment.
  def can_void?(payment)
    payment.state != 'void'
  end

  def can_credit?(payment)
    return false unless payment.state == 'completed'
    return false unless payment.order.payment_state == 'credit_owed'
    # At the moment not supported, but should be supported in the future
    false
    #payment.credit_allowed > 0
  end

  def has_payment_profile?
    false
  end

  def spree_cc_type
    card_type
  end

end
