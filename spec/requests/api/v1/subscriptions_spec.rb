require 'rails_helper'

RSpec.describe '/api/v1/subscriptions' do
  let(:response_hash) { JSON(response.body, symbolize_names: true) }

  describe 'create a subscription' do
    context 'when successful' do
      let(:customer) { create(:customer) }
      let(:tea) { create(:tea) }
      let(:params) do
        {
          customer_id: customer.id,
          tea_id: tea.id,
          title: 'Throat Coat',
          price: 7.00,
          status: 'active',
          frequency: 'weekly'
        }
      end

      it 'creates a subscription' do
        expect { post api_v1_subscriptions_path, params: params }.to change { Subscription.count }
      end

      it 'is successful' do
        post api_v1_subscriptions_path, params: params

        expect(response).to be_successful
      end

      it 'returns the created subscription' do
        post api_v1_subscriptions_path, params: params

        expect(response_hash[:data][:attributes]).to include(params)
      end

      it 'has correct data types' do
        post api_v1_subscriptions_path, params: params

        expect(response_hash).to be_a(Hash)
        expect(response_hash[:data]).to be_a(Hash)
        expect(response_hash[:data][:id]).to be_a(String)
        expect(response_hash[:data][:type]).to be_a(String)
        expect(response_hash[:data][:type]).to eq('subscription')
        expect(response_hash[:data][:attributes]).to be_a(Hash)
        expect(response_hash[:data][:attributes][:tea_id]).to be_an(Integer)
        expect(response_hash[:data][:attributes][:customer_id]).to be_an(Integer)
        expect(response_hash[:data][:attributes][:title]).to be_an(String)
        expect(response_hash[:data][:attributes][:price]).to be_a(Float)
        expect(response_hash[:data][:attributes][:status]).to be_a(String)
        expect(response_hash[:data][:attributes][:frequency]).to be_a(String)
      end
    end

    context 'when unsuccessful' do
      let(:customer) { create(:customer) }
      let(:tea) { create(:tea) }
      let(:params) do
        {
          customer_id: customer.id,
          tea_id: tea.id,
          price: 7.00,
          status: 'active',
          frequency: 'weekly'
        }
      end

      before :each do
        post api_v1_subscriptions_path, params: params
      end

      it 'returns an error if attributes are missing' do
        expect(response_hash).to eq({ errors: ["Title can't be blank"] })
      end

      it 'returns a 400 status' do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'cancel a subscription' do
    context 'when successful' do
      let(:customer) { create(:customer) }
      let(:tea) { create(:tea) }
      let!(:subscription) { create(:subscription, customer: customer, tea: tea) }

      before :each do
        patch api_v1_subscription_path(subscription), params: { status: 'cancelled' }
      end

      it 'cancels a subscription' do
        expect(subscription.reload.cancelled?).to be true
      end

      it 'is successful' do
        expect(response).to be_successful
      end

      it 'returns a 204 status' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when unsuccessful' do
      before :each do
        patch api_v1_subscription_path(-1), params: { status: 'cancelled' }
      end

      it 'returns error if invalid subscription id' do
        expect(response_hash).to eq({ errors: "Couldn't find Subscription with 'id'=-1"})
      end

      it 'returns a 404 status' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
