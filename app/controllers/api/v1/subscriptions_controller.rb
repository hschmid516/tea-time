class Api::V1::SubscriptionsController < ApplicationController
  def index
    render json: SubscriptionSerializer.new(set_customer.subscriptions)
  end

  def create
    render json: Subscriber.call(subscription_params)
  end

  def update
    render json: Activator.call(params)
  end

  private

  def subscription_params
    params.permit(:customer_id, :tea_id, :title, :price, :status, :frequency)
  end

  def set_customer
    Customer.find(params[:customer_id])
  end
end
