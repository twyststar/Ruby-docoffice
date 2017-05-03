class Doctor
  attr_reader(:name, :id, :specialty_id)

  def initialize (attributes)
    @name = attributes[:name]
    @id = attributes[:id]
    @specialty_id = attributes[:specialty_id]
  end

  def self.all
    returned_docs = DB.exec('SELECT * FROM doctors;')
    docs = []
    returned_docs.each() do |doc|
      name = doc.fetch('name')
      specialty_id = doc.fetch("specialty_id").to_i()
      docs.push(Doctor.new({:name => name, :specialty_id => specialty_id}))
    end
    docs
  end

  def save
    result= DB.exec("INSERT INTO doctors (name, specialty_id) VALUES ('#{@name}', #{@specialty_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  def == (another_doctor)
    self.name() == (another_doctor.name()) 
  end
end
