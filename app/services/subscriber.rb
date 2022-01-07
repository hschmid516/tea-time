class Subscriber < ApplicationService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    subscription = Subscription.create(params)

    if subscription.save
      SubscriptionSerializer.new(subscription)
    else
      raise ActionController::BadRequest, subscription.errors.full_messages
    end
  end
end
