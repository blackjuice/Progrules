require 'rails_helper'
require 'simplecov'
require 'simplecov-rcov'
class SimpleCov::Formatter::MergedFormatter
  def format(result)
     SimpleCov::Formatter::HTMLFormatter.new.format(result)
     SimpleCov::Formatter::RcovFormatter.new.format(result)
  end
end

RSpec.describe "preferencias/new", :type => :view do
  before(:each) do
    assign(:preferencia, Preferencia.new(
        :name => "MyString",
        :ordem => "MyString"
    ))
  end

  it "renders new preferencia form" do
    render

    assert_select "form[action=?][method=?]", alunos_path, "post" do

      assert_select "input#preferencia_name[name=?]", "preferencia[name]"
      assert_select "input#preferencia_ordem[name=?]", "preferencia[ordem]"
    end
  end
end
