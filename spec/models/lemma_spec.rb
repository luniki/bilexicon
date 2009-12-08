require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Lemma do
  before(:each) do
    @valid_attributes = {
      :short1 => "to be", :short2 => "sein",
      :long1 => "to be", :long2 => "sein",
      :level_rezeptiv => "A1", :level_produktiv => "A1",
      :word_class1 => "V",
      :word_class2 => "V",
      :categories => [Factory.create(:category)]
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

  it "should remove inappropriate additional attributes" do
    @valid_attributes[:gender1] = @valid_attributes[:gender2] = "m"
    lemma = Lemma.create(@valid_attributes)
    lemma.save.should be_true
    lemma.gender1.should be_nil
    lemma.gender2.should be_nil
  end
end
