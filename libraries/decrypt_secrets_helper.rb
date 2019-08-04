# frozen_string_literal: true

require 'base64'
require 'aws-sdk'
require 'json'

module DecryptSecrets
  module Helper
    # Fetch AWS credentials.
    def self.get_metadata(path)
      JSON.parse(Net::HTTP.get('169.254.169.254', path))
    end
    def self.decrypt(secret)
      decoded = Base64.decode64(secret)

      region = get_metadata('/latest/dynamic/instance-identity/document')['region']
      client = Aws::KMS::Client.new region: region
      resp = client.decrypt(ciphertext_blob: decoded)
      resp.plaintext
    end
    # rubocop:enable all
  end
end
