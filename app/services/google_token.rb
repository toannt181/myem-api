require 'google/api_client/client_secrets'
require 'google/apis/oauth2_v2'

class GoogleToken
  class << self
    def get_user_info(token)
      begin
        client_secrets = Google::APIClient::ClientSecrets.load
        auth_client = client_secrets.to_authorization
        auth_client.code = token
        auth_client.fetch_access_token!

        google = Google::Apis::Oauth2V2::Oauth2Service.new
        google.authorization = auth_client
        google.get_userinfo_v2
      rescue => error
        print(error)
        return nil
      end
    end
  end
end
