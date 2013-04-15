module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Dibs
        class Helper < ActiveMerchant::Billing::Integrations::Helper
          # Replace with the real mapping
          mapping :account, 'merchant'
          mapping :amount, 'amount'
          mapping :currency, 'currency'

          mapping :order, 'orderId'

          mapping :customer, :first_name => 'billingFirstName',
                             :last_name  => 'billingLastName',
                             :email      => 'billingEmail',
                             :phone      => 'billingMobile'

          mapping :billing_address, :city     => 'billingPostalPlace',
                                    :address1 => 'billingAddress',
                                    :address2 => 'billingAddress2',
                                    :zip      => 'billingPostalCode'

          mapping :return_url, 'acceptReturnUrl'
          mapping :cancel_url, 'cancelReturnUrl'
        end
      end
    end
  end
end
