require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require('./lib/specialty')
require('./lib/doctor')
require('pg')
require('pry')
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
  @specialty = Specialty.find(params[:id].to_i())
  @doctors= Doctor.all()
  erb(:one_specialty)
end

post("/one_specialty") do
  doctor = params.fetch("doctor")
  specialty_id = params.fetch('specialty_id').to_i()
  doctors = Doctor.new ({:name => doctor, :id => nil, :specialty_id => specialty_id})
  doctors.save()
  @doctors = Doctor.all()
  @specialty = Specialty.find(specialty_id)
  erb(:one_specialty)
 end

 get('/one_doctor/:id') do
  @doctor = Doctor.find(params[:id].to_i())
  @patients= Patient.all()
  erb(:one_doctor)
 end

 post("/one_doctor")do
   first_name= params.fetch("first_name")
   last_name = params.fetch("last_name")
   dob= params.fetch("dob")
   doctor_id = params.fetch("doctor_id").to_i()
   patients = Patient.new ({:first_name=>first_name, :last_name=>last_name, :dob=>dob,:doctor_id=> doctor_id, :id => nil})
   patients.save()
   @patients = Patient.all()
   @doctor = Doctor.find(doctor_id)
   erb(:one_doctor)
 end

 get('/patient_info/:id') do
   @patient = Patient.find(params[:id].to_i())
   doc_id = @patient.doctor_id()
   @doctor = Doctor.find(doc_id)
   erb(:patient_info)
 end
