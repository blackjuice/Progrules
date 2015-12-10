require 'rails_helper'
require 'simplecov'
require 'simplecov-rcov'
class SimpleCov::Formatter::MergedFormatter
  def format(result)
     SimpleCov::Formatter::HTMLFormatter.new.format(result)
     SimpleCov::Formatter::RcovFormatter.new.format(result)
  end
end

RSpec.describe "alunos/new", :type => :view do
  before(:each) do
    assign(:aluno, Aluno.new(
        :name => "MyString",
        :classe => "MyString",
        :rand_pass => "MyString",
        :sexo => "MyString" 
    ))
  end

  it "renders new aluno form" do
    render

    assert_select "form[action=?][method=?]", alunos_path, "post" do

      assert_select "input#aluno_name[name=?]", "aluno[name]"
      assert_select "input#aluno_classe[name=?]", "aluno[classe]"
      assert_select "input#aluno_rand_pass[name=?]", "aluno[rand_pass]"
      assert_select "input#aluno_sexo[name=?]", "aluno[sexo]"
    end
  end
end
