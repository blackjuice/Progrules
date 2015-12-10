require 'rails_helper'
require 'simplecov'
require 'simplecov-rcov'
class SimpleCov::Formatter::MergedFormatter
  def format(result)
     SimpleCov::Formatter::HTMLFormatter.new.format(result)
     SimpleCov::Formatter::RcovFormatter.new.format(result)
  end
end


RSpec.describe Preferencia, type: :model do
  subject {FactoryGirl.build(:preferencia)}

  describe 'relations' do
    it {is_expected.to belong_to(:preferente).class_name('Aluno')}
    it {is_expected.to belong_to(:preferido).class_name('Aluno')}
    #it {should have_many(:alunos).with_foreign_key("aluno_id")}
  end

  describe "accessible attributes" do
    it "should allow access to ordem" do
      expect do
        Preferencia.new(ordem: true)
      end.to_not raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe 'attributes' do
    it 'is expected to set ordem' do
      expect(subject.ordem).to eq('1')
    end
    #it 'is expected to set preferente' do
    #  expect(subject.preferente).to eq('Gideao')
    #end
    #it 'is expected to set preferido' do
    #  expect(subject.preferido).to eq('Zebulom')
    #end
  end
end
