require 'rails_helper'
require 'simplecov'
require 'simplecov-rcov'
class SimpleCov::Formatter::MergedFormatter
  def format(result)
     SimpleCov::Formatter::HTMLFormatter.new.format(result)
     SimpleCov::Formatter::RcovFormatter.new.format(result)
  end
end

RSpec.describe "preferencias/index", :type => :view do
  before(:each) do
    assign(:widgets, [
      Preferencia.create!(
        :name => "Name",
        :ordem => "Ordem"
      ),
      Preferencia.create!(
        :name => "Name",
        :ordem => "Ordem"
      )
    ])
  end

  it "renders a list of widgets" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Ordem".to_s, :count => 2
  end
end
