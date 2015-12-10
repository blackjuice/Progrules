require 'rails_helper'
require 'simplecov'
require 'simplecov-rcov'
class SimpleCov::Formatter::MergedFormatter
  def format(result)
     SimpleCov::Formatter::HTMLFormatter.new.format(result)
     SimpleCov::Formatter::RcovFormatter.new.format(result)
  end
end

RSpec.describe "alunos/index", :type => :view do
  before(:each) do
    assign(:alunos, [
      Aluno.create!(
        :name => "Name",
        :classe => "Classe",
        :rand_pass => "Pass",
        :sexo => "Sexo" 
      ),
      Aluno.create!(
        :name => "Name",
        :classe => "Classe",
        :rand_pass => "Pass",
        :sexo => "Sexo" 
      )
    ])
  end

  it "renders a list of alunos" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Classe".to_s, :count => 2
    assert_select "tr>td", :text => "Pass".to_s, :count => 2
    assert_select "tr>td", :text => "Sexo".to_s, :count => 2
  end
end
