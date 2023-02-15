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
class Url < ApplicationRecord
  validates :full_url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp, message: "must be a valid URL" }
  validates :short_url, uniqueness: true
  before_validation :generate_short_url

  def generate_short_url
    self.short_url ||= SecureRandom.alphanumeric(5).upcase
  end

  def increment_visit_count
    self.visit_count += 1
    self.save
  end
end
