require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Example do
  before(:each) do
    @valid_attributes = {
      :form1 => "",
      :form2 => "",
      :exampleable_id => "",
      :exampleable_type => "value for exampleable_type"
    }
  end

  it "should create a new instance given valid attributes" do
    Example.create!(@valid_attributes)
  end
end
