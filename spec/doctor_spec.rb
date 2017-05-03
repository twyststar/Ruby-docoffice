require('spec_helper')

describe(Doctor) do

  describe("#name") do
    it("lets you give it a name") do
      test_doc = Doctor.new(:name => 'Hyde', :id => nil)
      expect(test_doc.name()).to(eq('Hyde'))
    end
  end
  describe ("#id") do
    it ("sets its id when saved") do
      doctor= Doctor.new({:name => 'Hyde', :id => nil, :specialty_id => 1})
      doctor.save()
      expect(doctor.id()).to(be_an_instance_of(Fixnum))
    end
  end
  describe("#save")do
    it('adds a specialty') do
      test_specialty = Specialty.new({:name => 'Cardiology', :id => nil})
      test_specialty.save()
      test_doc = Doctor.new(:name => 'Hyde',:id=>nil, :specialty_id => test_specialty.id())
      test_doc.save()
      expect(Doctor.all()).to(eq([test_doc]))
    end
  end




end
