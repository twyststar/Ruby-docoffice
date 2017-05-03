class Patient
  attr_reader(:first_name,:last_name,:dob,:doctor_id,:id)
  def initialize (attributes)
    @first_name= attributes[:first_name]
    @last_name = attributes[:last_name]
    @dob = attributes[:dob]
    @doctor_id = attributes[:doctor_id]
    @id = attributes[:id]
  end

  def self.all
    returned_patients = DB.exec('SELECT * FROM patients;')
    patients = []
    returned_patients.each() do |patient|
      first_name = patient.fetch('first_name')
      last_name = patient.fetch('last_name')
      dob = patient.fetch('dob')
      doctor_id = patient.fetch('doctor_id')
      id = patient.fetch('id').to_i()
      doctor_id = patient.fetch("doctor_id").to_i()
    patients.push(Patient.new({:first_name=>first_name,:last_name=>last_name,:dob=>dob,:doctor_id=>doctor_id,:id=>id}))
    end
    patients
  end

  def save
     result = DB.exec("INSERT INTO patients (first_name, last_name, DOB, doctor_id) VALUES ('#{@first_name}', '#{@last_name}', '#{@dob}', #{@doctor_id}) RETURNING id;")
     @id = result.first().fetch("id").to_i()
  end

  def == (another_patient)
    self.first_name().==(another_patient.first_name()).&self.last_name().==(another_patient.last_name()).&(self.doctor_id().==(another_patient.doctor_id()))
  end

  def self.find (id)
    found_patient = nil
    Patient.all().each() do |patient|
      if patient.id().==(id)
       found_patient = patient
      end
    end
    found_patient
  end

end
