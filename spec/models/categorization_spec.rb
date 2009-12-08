require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Categorization do
  before(:each) do
    lemma = Factory(:lemma)
    @valid_attributes = {
      :lemma_id => lemma.id,
      :category_id => lemma.categories[0].id
    }
  end

  it "should create a new instance given valid attributes" do
    Categorization.create!(@valid_attributes)
  end

  it "should not assign to position" do
    @valid_attributes[:position] = "4711"
    c = Categorization.create!(@valid_attributes)
    c.position.should_not == 4711
  end

  it "should succeed creating a new :categorization from the Factory" do
    Factory.create(:categorization)
  end

  it "should invalid :invalid_user factory" do
    Factory.build(:invalid_categorization).should be_invalid
  end

  it "should be deleted when the lemma is deleted" do
    lemma = Factory(:lemma)
    categorization = lemma.categorizations.first
    lemma.destroy
    lambda {
      Categorization.find(categorization.id)
    }.should raise_error(ActiveRecord::RecordNotFound)
  end

  it "should be deleted when the category is deleted" do
    lemma = Factory(:lemma)
    category = lemma.categories.first
    categorization = lemma.categorizations.first
    category.destroy
    lambda {
      Categorization.find(categorization.id)
    }.should raise_error(ActiveRecord::RecordNotFound)
  end
end
