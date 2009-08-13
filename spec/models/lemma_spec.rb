require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Lemma do
  before(:each) do
    @valid_attributes = {
      :short1 => "to be", :short2 => "sein",
      :long1 => "to be", :long2 => "sein",
      :level_rezeptiv => "A1", :level_produktiv => "A1",
      :word_class => "V"
    }
  end

  it "should create a new instance given valid attributes" do
    Lemma.create!(@valid_attributes)
  end
end
