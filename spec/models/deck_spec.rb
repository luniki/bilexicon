require 'spec_helper'

describe Deck do
  before(:each) do
    @valid_attributes = {
      :user_id => 1,
      :name => "value for name"
    }
  end

  it "should create a new instance given valid attributes" do
    Deck.create!(@valid_attributes)
  end
end
