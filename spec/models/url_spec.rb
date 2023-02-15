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
require 'rails_helper'

RSpec.describe Url, type: :model do
  let(:url) { FactoryBot.create(:url) }

  describe "validations" do
    it { should validate_presence_of(:full_url) }
    it { should validate_uniqueness_of(:short_url) }
  end

  describe "generate_short_url" do
    it "generates a unique short_url" do
      expect(FactoryBot.create(:url).short_url).not_to eq(url.short_url)
    end

    it "generates a 5-character uppercase alphanumeric code" do
      expect(url.short_url).to match(/^[A-Z0-9]{5}$/)
    end
  end

  describe "increment_visit_count" do
    it "increments the visit count" do
      expect {
        url.increment_visit_count
        url.reload
      }.to change { url.visit_count }.by(1)
    end
  end
end
