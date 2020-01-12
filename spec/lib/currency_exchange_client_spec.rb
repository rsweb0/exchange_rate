require 'rails_helper'

RSpec.describe 'Currency Exchange Client' do
  it 'should return Fixer client if provider is not passed' do
    expect(CurrencyExchange.new.client).is_a?(Fixer::Client)
  end
end
