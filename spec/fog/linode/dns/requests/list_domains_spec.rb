require 'minitest_helper'

describe Fog::Linode::DNS do
  describe '#list_domains' do
    before do
      VCR.insert_cassette('list_domains')
    end

    after do
      VCR.eject_cassette
    end

    let(:connection) do
      Fog::DNS.new(
        provider: :linode,
        linode_url: ENV['LINODE_URL'] || 'https://api.linode.com',
        linode_token: ENV['LINODE_TOKEN'] || 'fake_token'
      )
    end

    it 'lists existing Linode domains' do
      domains_response = connection.list_domains
      assert !domains_response.empty?
      assert !domains_response.first['description'].nil?
    end
  end
end
