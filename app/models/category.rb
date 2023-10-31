class Category < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  has_many :related_payments, through: :payment_categories, source: :related_payment
  has_many :payment_categories
  has_many :payments

  validates :icon, presence: true
  validates :name, presence: true

  def total_amount
    total = 0
    payments.each do |payment|
      total += payment.amount.to_i
    end
    total
  end
end
