require("rspec")
require("pg")
require("doctor")
require("patient")
require("specialty")

DB = PG.connect({:dbname => "office_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM specialtys *;")
    DB.exec("DELETE FROM doctors *;")
    DB.exec("DELETE FROM patients *;")
  end
end
