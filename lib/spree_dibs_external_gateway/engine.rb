module SpreeDibsExternalGateway
  class Engine < ::Rails::Engine
    engine_name 'spree_dibs_external_gateway'

    config.autoload_paths += %W(#{config.root}/lib)

    initializer "spree_paypal_express.register.payment_methods" do |app|
      app.config.spree.payment_methods += [
          Spree::BillingIntegration::Dibs
      ]
    end
  end
end
