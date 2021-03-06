require 'rails_helper'
require 'simplecov'
require 'simplecov-rcov'
class SimpleCov::Formatter::MergedFormatter
  def format(result)
     SimpleCov::Formatter::HTMLFormatter.new.format(result)
     SimpleCov::Formatter::RcovFormatter.new.format(result)
  end
end


RSpec.describe User, type: :model do
  subject {FactoryGirl.build(:user)}

  #it {is_expected.to validate_presence_of(:name)}
  #it {is_expected.to validate_presence_of(:pass_hash)}
  #it {is_expected.to validate_presence_of(:position)}

  describe 'relations' do
    #it {should (:preferencia).with_foreign_key("preferente_id")}
    it { is_expected.to belong_to(:aluno)}#.class_name('Aser') }
  end

  describe "accessible attributes" do
    it "should allow access to name" do
      expect do
        User.new(name: true)
      end.to_not raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
    it "should allow access to pass_hash" do
      expect do
        Aser.new(rand_pass: true)
      end.to_not raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
    it "should allow access to position" do
      expect do
        Aser.new(classe: true)
      end.to_not raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe 'attributes' do
    it 'is expected to set name' do
      expect(subject.name).to eq('Gideao')
    end
    it 'is expected to set pass_hash' do
      expect(subject.pass_hash).to eq('AABBCC')
    end
    it 'is expected to set position' do
      expect(subject.position).to eq('aluno')
    end
  end
end
