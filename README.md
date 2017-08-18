# README

This is a simple Rails API used to serve up JSON records and some light business intelligence.

In order to run this on your local machine you must have the following installed:

  - Rails 5.1.2
  - PostgreSQL
  - Ruby 2.4.1

## To set up the API locally:

- Clone down this repo
- `cd railz_engine`
- `bundle install`
- Set up the database by running `rake db:{create,migrate}`
- Seed the database by running `rake csv_importer:all`

### Test Suite

This project uses an RSpec test suite. To run the entire suite, simply run the command `rspec` in the Terminal. To check test coverage, run `open coverage/index.hmtl`


### Record Endpoints

These endpoints return records associated with the six tables in our database.

  * merchants
    `GET /api/v1/merchants/` returns all merchants
    `GET /api/v1/merchants/1` returns individual merchant by id

  * customers
    `GET /api/v1/customers/` returns all customers
    `GET /api/v1/customers/1` returns individual customer by id

  * items
    `GET /api/v1/items/` returns all items
    `GET /api/v1/items/1` returns individual item by id

  * invoices
    `GET /api/v1/invoices/` returns all invoices
    `GET /api/v1/invoices/1` returns individual invoice by id

  * invoice_items
    `GET /api/v1/invoice_items/` returns all invoice_items
    `GET /api/v1/invoice_items/1` returns individual invoice_item by id

  * transactions
    `GET /api/v1/transactions/` returns all transactions
    `GET /api/v1/transactions/1` returns individual transaction by id

`find`, `find_all`, and `random` endpoints are also available for each tables. `find` and `find_all` allow you to search by record attributes.

Examples queries:
`GET /api/v1/merchants/find?name=Schroeder-Jerde`
`GET /api/v1/invoices/find_all?status=shipped`
`GET /api/v1/items/random`

#### Relationship Endpoints
These endpoints return the records associated with individual merchants, items, etc.

##### Merchants

`GET /api/v1/merchants/:id/items` returns a collection of items associated with that merchant

`GET /api/v1/merchants/:id/invoices` returns a collection of invoices associated with that merchant from their known orders

##### Invoices

`GET /api/v1/invoices/:id/transactions` returns a collection of associated transactions

`GET /api/v1/invoices/:id/invoice_items` returns a collection of associated invoice items

`GET /api/v1/invoices/:id/items` returns a collection of associated items

`GET /api/v1/invoices/:id/customer` returns the associated customer

`GET /api/v1/invoices/:id/merchant` returns the associated merchant

##### Invoice Items

`GET /api/v1/invoice_items/:id/invoice` returns the associated invoice

`GET /api/v1/invoice_items/:id/item` returns the associated item

##### Items

`GET /api/v1/items/:id/invoice_items` returns a collection of associated invoice items

`GET /api/v1/items/:id/merchant` returns the associated merchant

##### Transactions

`GET /api/v1/transactions/:id/invoice` returns the associated invoice

##### Customers

`GET /api/v1/customers/:id/invoices` returns a collection of associated invoices

`GET /api/v1/customers/:id/transactions` returns a collection of associated transactions

#### Business Intelligence Endpoints
These endpoints return some Business Intelligence data

##### All Merchants

`GET /api/v1/merchants/most_revenue?quantity=x` returns the top x merchants ranked by total revenue

`GET /api/v1/merchants/most_items?quantity=x` returns the top x merchants ranked by total number of items sold

`GET /api/v1/merchants/revenue?date=x` returns the total revenue for date x across all merchants

##### Single Merchant

`GET /api/v1/merchants/:id/revenue` returns the total revenue for that merchant across all transactions

`GET /api/v1/merchants/:id/revenue?date=x` returns the total revenue for that merchant for a specific invoice date x

`GET /api/v1/merchants/:id/favorite_customer` returns the customer who has conducted the most total number of successful transactions

`GET /api/v1/merchants/:id/customers_with_pending_invoices` returns a collection of customers which have pending (unpaid) invoices. A pending invoice has no transactions with a result of success

##### Items

`GET /api/v1/items/most_revenue?quantity=x` returns the top x items ranked by total revenue generated

`GET /api/v1/items/most_items?quantity=x` returns the top x item instances ranked by total number sold

`GET /api/v1/items/:id/best_day` returns the date with the most sales for the given item using the invoice date. If there are multiple days with equal number of sales, returns the most recent day.

##### Customers

`GET /api/v1/customers/:id/favorite_merchant` returns a merchant where the customer has conducted the most successful transactions
