require 'rails_helper'

RSpec.describe 'transactions/index.html.erb', type: :view do
  before(:each) do
    @category = Category.create(name: 'Category1', icon: 'Icon1', user: User.create(name: 'User', email: 'user@user.com', password: 'password'))
    @transactions = [
      @category.transactions.create(name: 'Transaction1', amount: 100),
      @category.transactions.create(name: 'Transaction2', amount: 200)
    ]
  
    assign(:category, @category)
    assign(:transactions, @transactions)
  end
  

  it 'displays the transactions for a category and provides a link to add a new transaction' do
    render

    expect(rendered).to have_selector('.header-transactions')
    expect(rendered).to have_selector('.title-transactions', text: 'Transactions')

    expect(rendered).to have_selector('.individual-category-container') do
      have_selector '.category-name-individual', text: @category.name
      have_selector '.category-amount-individual', text: "$#{'%.2f' % @category.total_amount}"
    end

    expect(rendered).to have_selector('.categories')

    @transactions.each do |transaction|
      expect(rendered).to have_selector('.container-category') do
        have_selector '.transaction-name', text: transaction.name
        have_selector '.transaction-amount', text: "$#{'%.2f' % transaction.amount}"
      end
    end

    expect(rendered).to have_selector('.add-transaction-btn-cont') do
      have_selector 'a.add-transaction-a[href=?]', new_category_transaction_path(@category)
      have_selector 'button.add-transaction-btn', text: 'Add a New Transaction'
    end
  end
end
