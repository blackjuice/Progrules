require 'rails_helper'
require 'simplecov'
require 'simplecov-rcov'
class SimpleCov::Formatter::MergedFormatter
  def format(result)
     SimpleCov::Formatter::HTMLFormatter.new.format(result)
     SimpleCov::Formatter::RcovFormatter.new.format(result)
  end
end

RSpec.describe ProfessorController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/professor").to route_to("professor#index")
    end

  end
end
