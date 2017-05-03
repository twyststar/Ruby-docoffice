class Doctor
  attr_reader(:name,:specialty_id)

  def initialize (attributes)
    @name = attributes[:name]
    @specialty_id = attributes[:specialty_id]
  end

  def self.all
    returned_doctors = DB.exec('SELECT * FROM doctors;')
    doctors = []
    returned_doctors.each() do |doctor|
      name = doctor.fetch('name')
      specialty_id = doctor.fetch("specialty_id").to_i()
      doctors.push(Doctor.new({:name => name, :specialty_id => specialty_id}))
    end
    doctors
  end

  def save
     DB.exec("INSERT INTO doctors (name, specialty_id) VALUES ('#{@name}', #{@specialty_id});")
  end

  def == (another_doctor)
    self.name().==(another_doctor.name()).&(self.specialty_id().==(another_doctor.specialty_id()))
  end
end
