require 'rails_helper'
require 'simplecov'
require 'simplecov-rcov'
class SimpleCov::Formatter::MergedFormatter
  def format(result)
     SimpleCov::Formatter::HTMLFormatter.new.format(result)
     SimpleCov::Formatter::RcovFormatter.new.format(result)
  end
end

RSpec.describe AlunoController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/aluno/index").to route_to("aluno#index")
    end

    it "routes to #new" do
      expect(:get => "/aluno/new").to route_to("aluno#new")
    end

    it "routes to #show" do
      expect(:get => "/aluno").to route_to("aluno#show")#, :id => "1")
    end

    #it "routes to #edit" do
    #  expect(:get => "/aluno").to route_to("aluno#edit", :id => "1")
    #end

    it "routes to #create" do
      expect(:post => "/aluno").to route_to("aluno#create")
    end

    #it "routes to #update via PUT" do
    #  expect(:put => "/aluno/1").to route_to("aluno#update", :id => "1")
    #end

    #it "routes to #update via PATCH" do
    #  expect(:patch => "/aluno/1").to route_to("aluno#update", :id => "1")
    #end

    #it "routes to #destroy" do
    #  expect(:delete => "/aluno").to route_to("aluno#destroy", :id => "1")
    #end

  end
end
