require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Collocation do
  before(:each) do
    @valid_attributes = {
      :form1 => "s.o./a car drives fast",
      :form2 => "j-m/ein Wagen fährt schnell",
      :syntax1 => "V + ADV",
      :syntax2 => "V + ADV"
    }
  end

  it "should create a new instance given valid attributes" do
    Collocation.create!(@valid_attributes)
  end
end
