require 'rails_helper'

RSpec.describe "offers/show", type: :view do
  before(:each) do
    @offer = assign(:offer, Offer.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
