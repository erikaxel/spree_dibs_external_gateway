class CreateSpreeDibsPaymentSources < ActiveRecord::Migration
  def change
    create_table :spree_dibs_payment_sources do |t|
      t.string  :exp_month
      t.string  :exp_year
      t.string  :card_type
      t.string  :card_number_masked
      t.string  :dibs_transaction_number

      t.timestamps
    end
  end
end
