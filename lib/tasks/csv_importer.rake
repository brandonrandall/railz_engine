require 'csv'

namespace :csv_importer do
  desc "imports all of the CSV's and creates corresponding records"
  task import_customers: :environment do
    customers = CSV.open "./lib/data/customers.csv",
                headers: true,
                header_converters: :symbol
    customers.each do |row|
      row = row.to_h
      Customer.create!(row)
    end
  end

  task import_items: :environment do
    items = CSV.open "./lib/data/items.csv",
                headers: true,
                header_converters: :symbol
    items.each do |row|
      row = row.to_h
      Item.create!(row)
    end
  end

  task import_invoices: :environment do
    invoices = CSV.open "./lib/data/invoices.csv",
                headers: true,
                header_converters: :symbol
    invoices.each do |row|
      row = row.to_h
      Invoice.create!(row)
    end
  end

  task import_invoice_items: :environment do
    invoice_items = CSV.open "./lib/data/invoice_items.csv",
                headers: true,
                header_converters: :symbol
    invoice_items.each do |row|
      row = row.to_h
      InvoiceItem.create!(row)
    end
  end

  task import_merchants: :environment do
    merchants = CSV.open "./lib/data/merchants.csv",
                headers: true,
                header_converters: :symbol

    merchants.each do |row|
      Merchant.create!(row.to_h)
    end
  end
end
