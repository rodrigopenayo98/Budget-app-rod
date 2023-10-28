class PaymentCategory < ApplicationRecord
  belongs_to :related_payment, class_name: 'Payment', foreign_key: 'payment_id'
  belongs_to :category
end
