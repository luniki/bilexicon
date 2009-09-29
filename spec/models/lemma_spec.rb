require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Lemma do
  before(:each) do
    @valid_attributes = {
      :short1 => "to be", :short2 => "sein",
      :long1 => "to be", :long2 => "sein",
      :level_rezeptiv => "A1", :level_produktiv => "A1",
      :word_class1 => "V",
      :word_class2 => "V"
    }
  end

  it "should create a new instance given valid attributes" do
    Lemma.create!(@valid_attributes)
  end

  it "should have a list of translated word classes" do
    de = Lemma.word_classes(:de)
    en = Lemma.word_classes(:de)
    de.size.should == en.size
    de.collect{|e| e[1]}.should == en.collect{|e| e[1]}
  end
end
