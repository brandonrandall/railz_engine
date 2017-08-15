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
      puts "#{row}"
    end
  end

  task import_merchants: :environment do
    merchants = CSV.open "./lib/data/merchants.csv",
                headers: true,
                header_converters: :symbol

    merchants.each do |row|
      Merchant.create!(row.to_h)
      puts row
    end
  end
end
