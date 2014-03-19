class Request < ActiveRecord::Base
  validates :url, presence: true, url: true

  class << self
    def stats
      data = Hash.new(0)

      select('COUNT(*) as count, response').group('response').each do |r|
        data[ r[:response] == 200 ? :success : :fail] += r[:count] if r[:response]

        data[:total] += r[:count]
      end

      data
    end

    def start_process

      where('response != 200 OR response IS NULL').each do |r|
        uri = URI(r.url)

        response = nil
        Net::HTTP.start(uri.host, uri.port) { |http| response = http.head('/') }
        r.update_attribute(:response, response.code) if response.is_a? Hash
      end
    end
  end
end