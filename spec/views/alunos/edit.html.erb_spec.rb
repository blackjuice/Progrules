require 'rails_helper'
require 'simplecov'
require 'simplecov-rcov'
class SimpleCov::Formatter::MergedFormatter
  def format(result)
     SimpleCov::Formatter::HTMLFormatter.new.format(result)
     SimpleCov::Formatter::RcovFormatter.new.format(result)
  end
end

RSpec.describe "alunos/edit/:id", :type => :view do
  before(:each) do
    @aluno = assign(:aluno, Aluno.create!(
      :name => "MyString",
      :classe => "MyString",
      :rand_pass => "MyString",
      :sexo => "MyString" 
    ))
  end

  it "renders the edit aluno form" do
    render

    assert_select "form[action=?][method=?]", aluno_path(@aluno), "post" do

      assert_select "input#aluno_name[name=?]", "aluno[name]"
      assert_select "input#aluno_classe[name=?]", "aluno[classe]"
      assert_select "input#aluno_rand_pass[name=?]", "aluno[rand_pass]"
      assert_select "input#aluno_sexo[name=?]", "aluno[sexo]"
    end
  end
end
