require 'rails_helper'

RSpec.describe CurrencyExchangePairsController, type: :controller do
  let(:valid_attributes) do
    { base_currency: 'EUR',
      target_currency: 'USD',
      amount: 5,
      number_of_weeks: 2 }
  end

  let(:invalid_attributes) do
    { base_currency: 'XYZ',
      target_currency: 'USD',
      amount: 5,
      number_of_weeks: -2 }
  end

  describe 'GET #index' do
    it 'returns a success response' do
      CurrencyExchangePair.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      exchange_pair = FactoryBot.create(:currency_exchange_pair, base_currency: 'INR')
      get :show, params: { id: exchange_pair.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      exchange_pair = FactoryBot.create(:currency_exchange_pair)
      get :edit, params: { id: exchange_pair.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new currency_exchange_pair' do
        expect do
          post :create, params: { currency_exchange_pair: valid_attributes }
        end.to change(CurrencyExchangePair, :count).by(1)
      end

      it 'redirects to the created currency_exchange_pair' do
        post :create, params: { currency_exchange_pair: valid_attributes }
        expect(response).to redirect_to(CurrencyExchangePair.last)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { currency_exchange_pair: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        { number_of_weeks: 11 }
      end

      it 'updates the requested color' do
        exchange_pair = FactoryBot.create(:currency_exchange_pair)
        put :update, params: { id: exchange_pair.to_param, currency_exchange_pair: new_attributes }
        exchange_pair.reload
        expect(exchange_pair.number_of_weeks).to eq(new_attributes[:number_of_weeks])
      end

      it 'redirects to the color' do
        exchange_pair = FactoryBot.create(:currency_exchange_pair)
        put :update, params: { id: exchange_pair.to_param, currency_exchange_pair: new_attributes }
        expect(response).to redirect_to(exchange_pair)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        exchange_pair = FactoryBot.create(:currency_exchange_pair)
        put :update, params: { id: exchange_pair.to_param, currency_exchange_pair: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested color' do
      exchange_pair = FactoryBot.create(:currency_exchange_pair)
      expect do
        delete :destroy, params: { id: exchange_pair.to_param }
      end.to change(CurrencyExchangePair, :count).by(-1)
    end

    it 'redirects to the colors list' do
      exchange_pair = FactoryBot.create(:currency_exchange_pair)
      delete :destroy, params: { id: exchange_pair.to_param }
      expect(response).to redirect_to(currency_exchange_pairs_url)
    end
  end
end
