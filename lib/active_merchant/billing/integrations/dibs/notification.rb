require 'net/http'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Dibs
        class Notification < ActiveMerchant::Billing::Integrations::Notification
          def complete?
            status == "ACCEPTED"
          end

          def item_id
            params['orderId']
          end

          def transaction_id
            params['transaction']
          end

          # the money amount we received in X.2 decimal.
          def gross
            "%.2f" % (gross_cents / 100.0)
          end

          def gross_cents
            params['amount'].to_i
          end

          def currency
            params['currency']
          end

          # Was this a test transaction?
          def test?
            params['test'] == '1'
          end

          def status
            params['status']
          end

          def security_key
            params['MAC']
          end

          # Provide access to raw fields from quickpay
          %w(
            billingFirstName
            billingLastName
            billingEmail
            billingMobile
            billingPostalPlace
            cardTypeName
            expMonth
            expYear
            cardNumberMasked

          ).each do |attr|
            define_method(attr) do
              params[attr]
            end
          end

 private
          # Take the posted data and move the relevant data into a hash
          def parse(post)
            @raw = post
            for line in post.split('&')
              key, value = *line.scan( %r{^(\w+)\=(.*)$} ).flatten
              params[key] = value
            end
          end
        end
      end
    end
  end
end
