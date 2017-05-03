require('spec_helper')

describe(Patient) do

  describe("#name") do
    it("lets you give it a name") do
      test_patient = Patient.new({:first_name=>'Mary',:last_name=>'Scary',:dob=>'1963-06-06',:id=>nil, :doctor_id => nil})
      expect(test_patient.first_name()).to(eq('Mary'))
    end
  end
  describe ("#id") do
    it ("sets its id when saved") do
      patient= Patient.new({:first_name=>'Mary',:last_name=>'Scary',:dob=>'1963-06-06',:id=>nil, :doctor_id => 2})
      patient.save()
      expect(patient.id()).to(be_an_instance_of(Fixnum))
    end
  end
  describe("#save")do
    it('adds patient to a doctor id') do
      test_doctor = Doctor.new({:name => 'Hyde', :id => nil, :specialty_id => 1})
      test_doctor.save()
      test_patient = Patient.new({:first_name=>'Mary',:last_name=>'Scary',:dob=>'1963-06-06',:id=>nil, :doctor_id => test_doctor.id()})
      test_patient.save()
      expect(Patient.all()).to(eq([test_patient]))
    end
  end
  describe(".find") do
    it("returns a patient by its ID") do
      test_patient = Patient.new({:first_name=>'Mary',:last_name=>'Scary',:dob=>'1963-06-06',:id=>nil, :doctor_id => 2})
      test_patient.save()
      test_patient2 = Patient.new({:first_name=>'Bob',:last_name=>'Donut',:dob=>'1963-07-06',:id=>nil, :doctor_id => 2})
      test_patient2.save()
      expect(Patient.find(test_patient2.id())).to(eq(test_patient2))
    end
  end
end
