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
  end
end