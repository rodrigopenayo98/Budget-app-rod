require 'rails_helper'

RSpec.describe 'payments/index.html.erb', type: :view do
  before(:each) do
    @category = Category.create(name: 'Category1', icon: 'Icon1', user: User.create(name: 'User', email: 'user@user.com', password: 'password'))
    @payments = [
      @category.payments.create(name: 'Payment1', amount: 100),
      @category.payments.create(name: 'Payment2', amount: 200)
    ]

    assign(:category, @category)
    assign(:payments, @payments)
  end


  it 'displays the payments for a category and provides a link to add a new payment' do
    render

    expect(rendered).to have_selector('.header-payments')
    expect(rendered).to have_selector('.title-payments', text: 'Payments')

    expect(rendered).to have_selector('.individual-category-container') do
      have_selector '.category-name-individual', text: @category.name
      have_selector '.category-amount-individual', text: "$#{'%.2f' % @category.total_amount}"
    end

    expect(rendered).to have_selector('.categories')

    @payments.each do |payment|
      expect(rendered).to have_selector('.container-category') do
        have_selector '.payment-name', text: payment.name
        have_selector '.payment-amount', text: "$#{'%.2f' % payment.amount}"
      end
    end

    expect(rendered).to have_selector('.add-payment-btn-cont') do
      have_selector 'a.add-payment-a[href=?]', new_category_payment_path(@category)
      have_selector 'button.add-payment-btn', text: 'Add a New Payment'
    end
  end
end
