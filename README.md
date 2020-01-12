# Currency Exchange
This Repository holds the code for the Currency Exchange rates.
It stores and analyzes historical data for currency exchange rates

# Supported currencies

```
AUD, BGN, BRL, CAD, CHF, CNY, CZK, DKK, EUR, GBP, HKD, HRK, HUF, IDR, ILS, INR,
JPY, KRW, MXN, MYR, NOK, NZD, PHP, PLN, RON, RUB, SEK, SGD, THB, TRY, USD, ZAR
```

## Object Domain
We have two models:

1) CurrencyExchangeRate
2) CurrencyExchangePair

CurrencyExchangeRate model is used to store exchange rates.
We seed DB with 1-year currency exchange rate data to avoid API calls.

Also, we have two rake tasks that sync and update currency exchange data frequently.

1) Every day one rake task is running at 00:10:00 UTC to
fetch 1-day old currency exchange record and update it in DB.

2) Another rake task is running every 60 mins and fetch current date record
and update it in the database.

We are using the Heroku scheduler for scheduling rake tasks.

FYI: Fixer.io update the currency record every 60min in the free plan
REF: https://fixer.io/documentation#latestrates

# Project Flow:
- Users can create a Currency Exchange Pair.
 - we show a tabular view and graph for the requested pair by fetching data from CurrencyExchangeRate table.
- If the base currency is not `EUR` then we calculate currency value by custom logic.

# Database:
I have choose postgresql as a DB layer.
I initially thought to choose Mongodb and store data as JSON format.
But the recent report of EnterpriseDB tells that Postgres Dominating Monogodb in Varied Workloads
REF: https://www.enterprisedb.com/news/new-benchmarks-show-postgres-dominating-mongodb-varied-workloads

Also, we are currently supporting 32 currencies it means we have a maximum of 32 entries for a day.
if we support more currencies in the future then also we don't have more than 180 entries for a day.

Based on the above facts I store data in Relational DB which also provides ACID property advantage if needed in the future.


# Environment Setup

## Prerequisites
To run this application in development you will either want to have
- Ruby 2.7.0
- Postgresql 9.6+ (work with the older version as well)
- Rails 6.0.2

You may need to change the credentials for Postgres according to your specific configuration.

###### To setup DB Run:
* `rake db:create`
* `rake db:migrate`

###### To seed last 1 yaer exchange_rate from `fixer.io`:
* `rake feed:import_fixer_records`

###### Run rails app using
* `rails s`

###### Run Test case using
* `rspec`


#### Test Coverage Report

visit http://currency-exchange-dev.herokuapp.com/coverage/index.html for coverage report


# Future Enhancements:

1) Currently, we are supporting 32 currencies, will support more currencies in the future.
when support more currency needs to update/sync old records.


2) Currently, rake job is running every 60 mins to sync the latest data from fixer.io
We need to update it to 10mins or 60sec if we choose PROFESSIONAL or PROFESSIONAL PLUS Fixer plan in the future.

3) Fixer.io always send 200 status
for wrong requests, they send `success: false` and `error` info in the body
https://fixer.io/documentation#errors
Currently I raise `Fixer::Error::BadRequest` when get `success: false` in response
In Future, we can Implement other errors for fixer.io

4) Will support other currency exchange providers in the future.

5) Currently, we are showing only one line chart for the whole historical duration,
We need to include a per week graph as well in the future.

6) Need to Highlight Low and High exchange rate when see data using the paginated tab in Tabular view.