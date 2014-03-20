require 'support/active_record'
require_relative '../models/request'

describe Request do

  context 'validation' do
    subject { Request.new }

    context 'when not valid' do
      it { should have(2).error_on(:url) }
      it do
        subject.url = 'foo'
        should have(1).error_on(:url)
      end
    end

    context 'when valid' do
      it do
        subject.url = 'http://google.com'
        should have(:no).error_on(:url)
      end
    end

  end

  describe '::stats' do
    subject {Request.stats}
    it { should be_a(Hash) }
    it { should be_empty }

    it do
      Request.create(url: 'http://google.com')

      subject.each_value do |v|
        expect(v).to be > 0
      end
    end
  end

  describe '.start_process' do
    it do
      r = Request.create(url: 'http://google.com')
      check = Request.find(r.id)

      expect(check.response).not_to be_nil
    end
  end
end
