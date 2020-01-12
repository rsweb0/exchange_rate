require 'rails_helper'

RSpec.describe 'Fixer Interaction' do
  let(:client) { Fixer::Client.new('a1a3b1133a6eda6ba1742b4a1089c0d1') }

  it 'should fetch latest currency exchange data' do
    VCR.use_cassette('latest') do
      data = client.latest
      expect(data['success']).to be_truthy
    end
  end

  it 'should fetch historical data by date' do
    VCR.use_cassette('historical') do
      data = client.historical('2020-01-01')
      expect(data['success']).to be_truthy
    end
  end

  it 'should raise error if date is wrong' do
    VCR.use_cassette('historical') do
      expect { client.historical('20-01-01') }.to raise_error(Fixer::Error::BadRequest)
    end
  end

  it 'should raise error if fixer.io server is down' do
    allow(RestClient).to receive(:get).and_raise(RestClient::NotFound.new)
    expect { client.historical('2010-01-01') }.to raise_error(Fixer::Error::Unknown)
  end
end
