class Api::V1::SubscriptionsController < ApplicationController
  def create
    subscription = Subscription.create(subscription_params)

    render json: SubscriptionSerializer.new(subscription)
  end

  private

  def subscription_params
    params.permit(:customer_id, :tea_id, :title, :price, :status, :frequency)
  end
end
