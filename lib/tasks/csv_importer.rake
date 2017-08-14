require 'csv'

namespace :csv_importer do
  desc "imports all of the CSV's and creates corresponding records"
  task import: :environment do
    puts "Hello"
    customers = CSV.open "./lib/data/customers.csv",
                headers: true,
                header_converters: :symbol
    customers.each do |row|
      row = row.to_h
      # Customer.create!(row)
      puts "#{row}"
    end
  end
end
