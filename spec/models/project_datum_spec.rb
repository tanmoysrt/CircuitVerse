# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProjectDatum do
  it "Has valid spec" do
    expect(FactoryBot.create(:project)).to be_valid
  end
end
