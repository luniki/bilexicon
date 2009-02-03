require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Phraseologism do
  before(:each) do
    @valid_attributes = {
      :form1 => "a car bound to somewhere",
      :form2 => "ein Auto, das irgendwo hinfährt"
    }
  end

  it "should create a new instance given valid attributes" do
    Phraseologism.create!(@valid_attributes)
  end
end
