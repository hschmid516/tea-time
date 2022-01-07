require 'rails_helper'

RSpec.describe '/api/v1/customers/:customer_id/subscriptions' do
  let(:response_hash) { JSON(response.body, symbolize_names: true) }

  describe 'POST /' do
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
        expect { post api_v1_customer_subscriptions_path(customer), params: params }.to change { Subscription.count }
      end

      it 'is successful' do
        post api_v1_customer_subscriptions_path(customer), params: params

        expect(response).to be_successful
      end

      it 'returns the created subscription' do
        post api_v1_customer_subscriptions_path(customer), params: params

        expect(response_hash[:data][:attributes]).to include(params)
      end

      it 'has correct data types' do
        post api_v1_customer_subscriptions_path(customer), params: params

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
        post api_v1_customer_subscriptions_path(customer), params: params
      end

      it 'returns an error if attributes are missing' do
        expect(response_hash).to eq({ errors: ["Title can't be blank"] })
      end

      it 'returns a 400 status' do
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'PATCH /' do
    let(:customer) { create(:customer) }
    let(:tea) { create(:tea) }
    let!(:subscription) { create(:subscription, customer: customer, tea: tea) }

    context 'when successful' do
      before :each do
        patch api_v1_customer_subscription_path(customer, subscription), params: { status: 1 }
      end

      it 'cancels a subscription' do
        expect(subscription.reload.cancelled?).to be true
      end

      it 'is successful' do
        expect(response).to be_successful
      end
    end

    context 'when unsuccessful' do
      context 'invalid subscription' do
        before :each do
          patch api_v1_customer_subscription_path(customer, -1), params: { status: 1 }
        end

        it 'returns error if invalid subscription id' do
          expect(response_hash).to eq({ errors: "Couldn't find Subscription with 'id'=-1" })
        end

        it 'returns a 404 status' do
          expect(response).to have_http_status(404)
        end
      end

      context 'missing param' do
        before :each do
          patch api_v1_customer_subscription_path(customer, subscription)
        end

        it 'returns error if missing param' do
          expect(response_hash).to eq({ errors: 'Please provide a valid status param' })
        end

        it 'returns a 400 status' do
          expect(response).to have_http_status(400)
        end
      end
    end
  end

  describe 'GET /' do
    context 'when successful' do
      let!(:customer1) { create(:customer) }
      let!(:customer2) { create(:customer) }
      let!(:tea1) { create(:tea) }
      let!(:tea2) { create(:tea) }
      let!(:subscription1) { create(:subscription, customer: customer1, tea: tea1) }
      let!(:subscription2) { create(:subscription, customer: customer1, tea: tea2) }
      let!(:subscription3) { create(:subscription, customer: customer2, tea: tea1) }

      before :each do
        get api_v1_customer_subscriptions_path(customer1.id)
      end

      it 'returns all subscriptions for a customer' do
        expect(response_hash[:data].length).to eq(2)
        expect(response_hash[:data][0][:id].to_i).to eq(subscription1.id)
        expect(response_hash[:data][1][:id].to_i).to eq(subscription2.id)
      end
    end

    context 'when unsuccessful' do
      before :each do
        get api_v1_customer_subscriptions_path(-1)
      end

      it 'returns error if invalid customer id' do
        expect(response_hash).to eq({ errors: "Couldn't find Customer with 'id'=-1" })
      end

      it 'returns a 404 status' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
