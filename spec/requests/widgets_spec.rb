require 'rails_helper'
require 'simplecov'
require 'simplecov-rcov'
class SimpleCov::Formatter::MergedFormatter
  def format(result)
     SimpleCov::Formatter::HTMLFormatter.new.format(result)
     SimpleCov::Formatter::RcovFormatter.new.format(result)
  end
end


RSpec.describe "Widgets", :type => :request do
  describe "GET /widgets" do
    it "works! (now write some real specs)" do
      get widgets_path
      expect(response).to have_http_status(200)
    end
  end
end
