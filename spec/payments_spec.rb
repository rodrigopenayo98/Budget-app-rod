require 'rails_helper'

RSpec.describe Payment, type: :model do
  let(:user) { User.create(name: 'Author') }
  let(:payment) { Payment.new(user:, name: 'Payment Name', amount: 100) }

  it 'should be valid with a name, an amount, and an associated user' do
    expect(payment).to be_valid
  end

  it 'should not be valid without a name' do
    payment.name = nil
    expect(payment).not_to be_valid
  end

  it 'should not be valid with a name longer than 255 characters' do
    payment.name = 'a' * 256
    expect(payment).not_to be_valid
  end

  it 'should not be valid without an amount' do
    payment.amount = nil
    expect(payment).not_to be_valid
  end

  it 'should not be valid with a non-integer amount' do
    payment.amount = 12.34
    expect(payment).not_to be_valid
  end

  it 'should not be valid with a non-positive amount' do
    payment.amount = -10
    expect(payment).not_to be_valid
  end

  it 'should belong to a user' do
    association = Payment.reflect_on_association(:user)
    expect(association.macro).to eq(:belongs_to)
    expect(association.class_name).to eq('User')
    expect(association.foreign_key).to eq('author_id')
  end

  it 'should have many payment categories' do
    association = Payment.reflect_on_association(:payment_categories)
    expect(association.macro).to eq(:has_many)
  end

  it 'should have many categories through payment categories' do
    association = Payment.reflect_on_association(:categories)
    expect(association.macro).to eq(:has_many)
  end
end
