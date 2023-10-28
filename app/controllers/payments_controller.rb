class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @category = Category.find(params[:category_id])
    @payments = @category.payments.where(author_id: current_user.id).order(created_at: :desc)
  end

  def create
    @payment = current_user.payments.new(payment_params)
    @payment.user_id = current_user.id

    if @payment.save
      redirect_to category_payments_path(category_id: payment_params[:category_id]), notice: 'Payment was successfully saved.'
    else
      render :new
    end
  end

  def new
    @category = Category.find(params[:category_id])
    @payment = Payment.new
  end

  private

  def payment_params
    params.require(:payment).permit(:name, :amount, :category_id, :user_id)
  end
end
