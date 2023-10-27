require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:user) { User.create(name: 'Author') }
  let(:transaction) { Transaction.new(user:, name: 'Transaction Name', amount: 100) }

  it 'should be valid with a name, an amount, and an associated user' do
    expect(transaction).to be_valid
  end

  it 'should not be valid without a name' do
    transaction.name = nil
    expect(transaction).not_to be_valid
  end

  it 'should not be valid with a name longer than 255 characters' do
    transaction.name = 'a' * 256
    expect(transaction).not_to be_valid
  end

  it 'should not be valid without an amount' do
    transaction.amount = nil
    expect(transaction).not_to be_valid
  end

  it 'should not be valid with a non-integer amount' do
    transaction.amount = 12.34
    expect(transaction).not_to be_valid
  end

  it 'should not be valid with a non-positive amount' do
    transaction.amount = -10
    expect(transaction).not_to be_valid
  end

  it 'should belong to a user' do
    association = Transaction.reflect_on_association(:user)
    expect(association.macro).to eq(:belongs_to)
    expect(association.class_name).to eq('User')
    expect(association.foreign_key).to eq('author_id')
  end

  it 'should have many transaction categories' do
    association = Transaction.reflect_on_association(:transaction_categories)
    expect(association.macro).to eq(:has_many)
  end

  it 'should have many categories through transaction categories' do
    association = Transaction.reflect_on_association(:categories)
    expect(association.macro).to eq(:has_many)
  end
end
