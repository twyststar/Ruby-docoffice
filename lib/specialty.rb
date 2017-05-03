class Specialty
  attr_reader(:name, :id)

  def initialize (attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def save
    result= DB.exec("INSERT INTO specialtys (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i
  end

  def self.all
    returned_specialtys = DB.exec('SELECT * FROM specialtys;')
    specialtys=[]
    returned_specialtys.each() do |specialty|
      name= specialty.fetch('name')
      id= specialty.fetch('id').to_i()
      specialtys.push(Specialty.new({:name => name, :id => id}))
  end
  specialtys
  end

  def == (another_specialty)
    self.name() == another_specialty.name()
  end

  def self.find (id)
    found_specialty = nil
    Specialty.all().each() do |specialty|
      if specialty.id() == id
       found_specialty = specialty
      end
    end
    found_specialty
  end

  define_method(:doctors) do
      specialty_doctors = []
      docs = DB.exec("SELECT * FROM doctors WHERE specialty_id = #{self.id()};")
      doctors.each() do |doc|
        description = doc.fetch("name")
        specialty_id = doc.fetch("specialty_id").to_i()
        specialty_doctors.push(Doctor.new({:name => name, :specialty_id => specialty_id}))
      end
      specialty_doctors
    end

end
