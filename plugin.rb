require 'auth/oauth2_authenticator'
require 'omniauth-oauth2'

class NaverAuthenticator < ::Auth::OAuth2Authenticator

  CLIENT_ID = '44yeBG7tWFEpg9Zso8_q'
  CLIENT_SECRET = 'Y4PjI0GKpt'

  def register_middleware(omniauth)
    omniauth.provider :naver, CLIENT_ID, CLIENT_SECRET
  end
end

class OmniAuth::Strategies::Naver < OmniAuth::Strategies::OAuth2
  # Give your strategy a name.
  option :name, "naver"

  # This is where you pass the options you would pass when
  # initializing your consumer from the OAuth gem.
  option :client_options, site: 'https://nid.naver.com/oauth2.0/authorize'

  # These are called after authentication has succeeded. If
  # possible, you should try to set the UID without making
  # additional calls (if the user id is returned with the token
  # or as a URI parameter). This may not be possible with all
  # providers.
  uid { raw_info['id'].to_s }

  info do
    {
      :name => raw_info['name'],
      :email => raw_info['email']
    }
  end

  extra do
    {
      'raw_info' => raw_info
    }
  end

  def raw_info
    @raw_info ||= access_token.get('/oauth/me.json').parsed
  end
end

auth_provider :title => '네이버로 로그인',
    :message => '네이버 계정을 통한 로그인. (팝업을 해제해야 할 수도 있어요.)',
    :frame_width => 920,
    :frame_height => 800,
    :authenticator => NaverAuthenticator.new('naver', trusted: true,
      auto_create_account: true)