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
  describe 'validations' do
    it { should validate_presence_of(:full_url) }
    it { should allow_value(Faker::Internet.url).for(:full_url) }
    it { should_not allow_value('invalid_url').for(:full_url) }
    it { should validate_uniqueness_of(:short_url) }
  end

  describe 'callbacks' do
    describe '#generate_short_url' do
      let(:url) { Url.new(full_url: Faker::Internet.url) }

      it 'generates a short URL before validation' do
        url.validate
        expect(url.short_url).to be_present
      end

      it 'generates a unique short URL' do
        existing_url = FactoryBot.build(:url)
        url.validate
        expect(url.short_url).not_to eq(existing_url.short_url)
      end
    end
  end

  describe '#increment_visit_count' do
    let(:url) { FactoryBot.build(:url) }

    it 'increments the visit count' do
      expect {
        url.increment_visit_count
      }.to change { url.visit_count }.by(1)
    end
  end
end
