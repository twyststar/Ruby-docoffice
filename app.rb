require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require('./lib/specialty')
require('./lib/doctor')
require('pg')
DB = PG.connect({:dbname => 'office'})

get('/')do
   @specialtys = Specialty.all()
  erb(:index)
end

post("/index") do
  name = params.fetch("name")
  specialty = Specialty.new({:name => name, :id => nil})
  specialty.save()
  @specialtys = Specialty.all()
  erb(:index)
 end

 get('/one_specialty/:id') do
  @doctors = Specialty.find(params[:id].to_i())
  erb(:one_specialty)
end
