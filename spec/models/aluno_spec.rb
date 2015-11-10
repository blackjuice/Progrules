require 'rails_helper'

RSpec.describe Aluno, type: :model do
  subject {FactoryGirl.build(:aluno)}

  it {is_expected.to validate_presence_of(:name)}
  it {is_expected.to validate_presence_of(:rand_pass)}
  it {is_expected.to validate_presence_of(:classe)}
  it {is_expected.to validate_presence_of(:sexo)}

  describe 'relations' do
    it {should have_one(:user).class_name('User') }
    #it {should have_one(:preferencia).with_foreign_key("preferente_id")}
    it {should have_many(:preferencias).with_foreign_key("preferido_id")}
    it {should have_many(:alunos).through(:preferencias)}
  end

  describe "accessible attributes" do
    it "should allow access to name" do
      expect do
        Aluno.new(name: true)
      end.to_not raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
    it "should allow access to rand_pass" do
      expect do
        Aluno.new(rand_pass: true)
      end.to_not raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
    it "should allow access to classe" do
      expect do
        Aluno.new(classe: true)
      end.to_not raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
    it "should allow access to sexo" do
      expect do
        Aluno.new(sexo: true)
      end.to_not raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe 'attributes' do
    it 'is expected to set name' do
      expect(subject.name).to eq('Gideao')
    end
    it 'is expected to set rand_pass' do
      expect(subject.rand_pass).to eq('AABBCC')
    end
    it 'is expected to set classe' do
      expect(subject.classe).to eq('C')
    end
    it 'is expected to set sexo' do
      expect(subject.sexo).to eq('M')
    end
  end
end
