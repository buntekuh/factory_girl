require "spec_helper"

describe "declaring attributes on a Factory that are private methods on Object" do
  before do
    define_model("Website", :system => :boolean, :link => :string, :sleep => :integer, :format => :string, :y => :integer, :more_format => :string)

    FactoryGirl.define do
      factory :website do
        system false
        link   "http://example.com"
        sleep  15
        more_format { "format: #{format}" }
      end
    end
  end

  subject { FactoryGirl.build(:website, :sleep => -5, :format => "Great", :y => 12345) }

  its(:system)      { should == false }
  its(:link)        { should == "http://example.com" }
  its(:sleep)       { should == -5 }
  its(:format)      { should == "Great" }
  its(:y)           { should == 12345 }
  its(:more_format) { should == "format: Great" }
end
