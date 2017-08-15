RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  DatabaseCleaner.strategy = :truncation

  config.before(:suite) do
    begin
      DatabaseCleaner.start
    ensure
      DatabaseCleaner.clean
    end
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
