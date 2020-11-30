class Shortener < ApplicationRecord
  require 'securerandom'

  # validations
  validates_presence_of :url
  validates :url, format: URI::regexp(%w[http https])

  # auto short url generation
  before_save :short_url

  
  def short_url
    self.short_code = SecureRandom.uuid[0..7]
  end
end
