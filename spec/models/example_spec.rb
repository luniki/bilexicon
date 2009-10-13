require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Example do
  before(:each) do
    @valid_attributes = {
      :form1 => "a",
      :form2 => "b",
      :exampleable_id => "",
      :exampleable_type => "Lemma"
    }
  end

  it "should create a new instance given valid attributes" do
    Example.create!(@valid_attributes)
  end
end
