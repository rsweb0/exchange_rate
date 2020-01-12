class CurrencyExchangePairsController < ApplicationController
  before_action :set_currency_exchange_pair, only: %i[show edit update destroy]

  # GET /currency_exchange_pairs
  def index
    @currency_exchange_pairs = CurrencyExchangePair.all
  end

  # GET /currency_exchange_pairs/1
  # GET /currency_exchange_pairs/1.json

  def show
    @current_exchange = @currency_exchange_pair.decorate
  end

  # GET /currency_exchange_pairs/new
  def new
    @currency_exchange_pair = CurrencyExchangePair.new
  end

  # GET /currency_exchange_pairs/1/edit
  def edit; end

  # POST /currency_exchange_pairs
  def create
    @currency_exchange_pair = CurrencyExchangePair.new(currency_exchange_pair_params)

    respond_to do |format|
      if @currency_exchange_pair.save
        format.html { redirect_to @currency_exchange_pair, notice: 'Currency exchange pair was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /currency_exchange_pairs/1
  def update
    respond_to do |format|
      if @currency_exchange_pair.update(currency_exchange_pair_params)
        format.html { redirect_to @currency_exchange_pair, notice: 'Currency exchange pair was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /currency_exchange_pairs/1
  def destroy
    @currency_exchange_pair.destroy
    respond_to do |format|
      format.html do
        redirect_to currency_exchange_pairs_url, notice: 'Currency exchange pair was successfully destroyed.'
      end
    end
  end

  private

  def set_currency_exchange_pair
    @currency_exchange_pair = CurrencyExchangePair.find(params[:id])
  end

  # white list exchange pair params .
  def currency_exchange_pair_params
    params.require(:currency_exchange_pair).permit(:base_currency, :target_currency, :number_of_weeks, :amount)
  end
end
