require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) { User.create(name: 'Author') }
  let(:category) { Category.new(user:, name: 'Name', icon: 'Icon') }

  it 'should be valid with a name, an icon, and an associated user' do
    expect(category).to be_valid
  end

  it 'should not be valid without a name' do
    category.name = nil
    expect(category).not_to be_valid
  end

  it 'should not be valid without an icon' do
    category.icon = nil
    expect(category).not_to be_valid
  end

  it 'should not be valid without an associated user' do
    category.user = nil
    expect(category).not_to be_valid
  end

  it 'should belong to a user' do
    association = Category.reflect_on_association(:user)
    expect(association.macro).to eq(:belongs_to)
    expect(association.class_name).to eq('User')
    expect(association.foreign_key).to eq('author_id')
  end

  it 'should have many related transactions through transaction categories' do
    association = Category.reflect_on_association(:related_transactions)
    expect(association.macro).to eq(:has_many)
  end

  it 'should have many transaction categories' do
    association = Category.reflect_on_association(:transaction_categories)
    expect(association.macro).to eq(:has_many)
  end

  it 'should have many transactions' do
    association = Category.reflect_on_association(:transactions)
    expect(association.macro).to eq(:has_many)
  end
end
