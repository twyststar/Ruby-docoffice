require('pry')
class Doctor
  attr_reader(:name, :id, :specialty_id)

  def initialize (attributes)
    @name = attributes[:name]
    @specialty_id = attributes[:specialty_id]
    @id = attributes[:id]
  end

  def self.all
    returned_doctors = DB.exec('SELECT * FROM doctors;')
    doctors = []
    returned_doctors.each() do |doctor|
      name = doctor.fetch('name')
      specialty_id = doctor.fetch("specialty_id").to_i()
      id = doctor.fetch('id').to_i()
      doctors.push(Doctor.new({:id => id, :name => name, :specialty_id => specialty_id}))
    end
    doctors
  end

  def save
     result = DB.exec("INSERT INTO doctors (name, specialty_id) VALUES ('#{@name}', #{@specialty_id})  RETURNING id;")
     @id = result.first().fetch("id").to_i()
  end

  def == (another_doctor)
    self.name().==(another_doctor.name()).&(self.specialty_id().==(another_doctor.specialty_id()))
  end


def self.find (id)
  found_doctor = nil
  Doctor.all().each() do |doctor|
    if doctor.id().==(id)
     found_doctor = doctor
    end
  end
  found_doctor
end
end
