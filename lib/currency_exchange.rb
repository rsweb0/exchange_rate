class CurrencyExchange
  attr_reader :provider

  def initialize(provider = 'fixer')
    @provider = provider
  end

  def client
    configurations[provider].new
  end

  def configurations
    {
      'fixer' => Fixer::Client
    }
  end
end
