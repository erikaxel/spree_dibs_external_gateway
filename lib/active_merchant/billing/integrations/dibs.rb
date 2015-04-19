require File.dirname(__FILE__) + '/dibs/helper.rb'
require File.dirname(__FILE__) + '/dibs/notification.rb'

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Dibs
        mattr_accessor :service_url
        self.service_url = 'https://sat1.dibspayment.com/dibspaymentwindow/entrypoint'

        def payment_url(opts)
          post = PostData.new
          post.merge! opts
          "#{service_url}?#{post.to_s}"
        end

        def self.notification(post, options = {})
          Notification.new(post, options)
        end

        def self.return(post, options = {})
          Return.new(post, options)
        end
      end
    end
  end
end
