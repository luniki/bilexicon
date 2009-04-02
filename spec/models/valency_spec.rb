require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Valency do
  before(:each) do
    @valid_attributes = {
      :form1 => "s.o. drives",
      :form2 => "j-m fährt",
      :syntax1 => "N + V",
      :syntax2 => "N + V"
    }
  end

  it "should create a new instance given valid attributes" do
    Valency.create!(@valid_attributes)
  end
end
