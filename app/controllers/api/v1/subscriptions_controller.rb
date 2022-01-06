class Api::V1::SubscriptionsController < ApplicationController
  def index
    customer = Customer.find(params[:customer_id])

    render json: SubscriptionSerializer.new(customer.subscriptions)
  end

  def create
    subscription = Subscription.create(subscription_params)

    if subscription.save
      render json: SubscriptionSerializer.new(subscription)
    else
      render json: { errors: subscription.errors.full_messages }, status: 400
    end
  end

  def update
    subscription = Subscription.find(params[:id])
    subscription.update(subscription_params)
    render status: 204
  end

  private

  def subscription_params
    params.permit(:customer_id, :tea_id, :title, :price, :status, :frequency)
  end
end
