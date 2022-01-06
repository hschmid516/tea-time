class Activator < ApplicationService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    subscription = Subscription.find(params[:id])

    if params[:status]
      subscription.update(status: params[:status].to_i)
      SubscriptionSerializer.new(subscription)
    else
      raise ActionController::BadRequest.new(), ('Please provide a status param').to_json
    end
  end
end
