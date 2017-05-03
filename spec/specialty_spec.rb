require('spec_helper')

describe(Specialty) do

    describe("#name") do
    it("lets you give it a name") do
      test_specialty = Specialty.new(:name => 'Cardiology', :id => nil)
      expect(test_specialty.name()).to(eq('Cardiology'))
    end
  end
  describe ("#id") do
    it ("sets its id when saved") do
      specialty= Specialty.new({:name => 'Cardiology', :id => nil})
      specialty.save()
      expect(specialty.id()).to(be_an_instance_of(Fixnum))
    end
  end
  describe("#save")do
    it('adds a specialty') do
      test_specialty = Specialty.new({:name => 'Cardiology', :id => nil})
      test_specialty.save()
      expect(Specialty.all()).to(eq([test_specialty]))
    end
  end
  describe("#==") do
    it("is the same specialty if it has the same name") do
        specialty1 = Specialty.new({:name => "Cardiology", :id => nil})
        specialty2 = Specialty.new({:name => "Cardiology", :id => nil})
        expect(specialty1).to(eq(specialty2))
    end
  end

  describe(".find") do
    it("returns a specialty by its ID") do
      test_specialty = Specialty.new({:name => 'Cardiology', :id => nil})
      test_specialty.save()
      test_specialty2 = Specialty.new({:name => 'Optometry', :id => nil})
      test_specialty2.save()
      expect(Specialty.find(test_specialty2.id())).to(eq(test_specialty2))
    end
  end
  # describe("#doctors") do
  #    it("returns an array of doctors for that specialty") do
  #      test_specialty = Specialty.new({:name => "Cardiology", :id => nil})
  #      test_specialty.save()
  #      test_doc = Doctor.new({:name => "Hyde", :specialty_id => test_specialty.id()})
  #      test_doc.save()
  #      test_doc2 = Doctor.new({:name => "Ruby", :specialty_id => test_specialty.id()})
  #      test_doc2.save()
  #      expect(test_specialty.doctors()).to(eq([test_doc, test_doc2]))
  #    end
  #  end
end
