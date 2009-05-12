require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Subentry do
  before(:each) do
    @valid_attributes = {
      :form1 => "drive",
      :form2 => "fahren"
    }
  end

  it "should create a new instance given valid attributes" do
    Subentry.create!(@valid_attributes)
  end
end
