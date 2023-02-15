# == Schema Information
#
# Table name: urls
#
#  id          :bigint           not null, primary key
#  full_url    :string
#  short_url   :string
#  visit_count :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "rails_helper"

RSpec.describe Url, type: :model do
  it "is not valid without a full_url" do
    url = URL.new(short_url: "ABCDE")
    expect(url).not_to be_valid
  end

  it "is not valid with an invalid full_url" do
    url = URL.new(full_url: "not-a-url", short_url: "ABCDE")
    expect(url).not_to be_valid
    expect(url.errors[:full_url]).to include("is not a valid URL")
  end

  it "is valid with a valid full_url and short_url" do
    url = URL.new(full_url: "https://www.example.com", short_url: "ABCDE")
    expect(url).to be_valid
  end
end
