class Category < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  has_many :related_transactions, through: :transaction_categories, source: :related_transaction
  has_many :transaction_categories

  validates :icon, presence: true
  validates :name, presence: true

  def total_amount
    related_transactions.sum(:amount)
  end
end
