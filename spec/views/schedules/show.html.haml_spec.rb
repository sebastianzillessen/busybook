require 'rails_helper'

RSpec.describe "schedules/show", type: :view do
  before(:each) do
    @schedule = assign(:schedule, Schedule.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
