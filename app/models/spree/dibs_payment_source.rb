class Spree::DibsPaymentSource < ActiveRecord::Base
  has_one :payment, :as => :source

  attr_accessible :dibs_transaction_number, :exp_month, :exp_year, :card_type, :card_number_masked
end
