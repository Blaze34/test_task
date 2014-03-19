class Request < ActiveRecord::Base
  validates :url, presence: true, url: true

  after_create :start_process

  class << self
    def stats
      data = Hash.new(0)

      select('COUNT(*) as count, response').group('response').each do |r|
        data[ r[:response] == 200 ? :success : :fail] += r[:count] if r[:response]

        data[:total] += r[:count]
      end

      data
    end
  end

  private

  def start_process
    Request.where('response != 200 OR response IS NULL').each do |r|
      uri = URI r.url

      Net::HTTP.start uri.host, uri.port do |http|
        response = http.head '/'
        r.update_attribute :response, response.code
      end
    end
  end
end