# name: Naver login
# about: Authenticate with discourse with naver.
# version: 0.1.0
# author: lainfox

gem 'omniauth-naver'

class NaverAuthenticator < ::Auth::Authenticator

  def name
    'naver'
  end

  # def after_authenticate(auth_token)
  #   result = Auth::Result.new

  #   data = auth_token[:info]
  #   credentials = auth_token[:credentials]
  #   raw_info = auth_token[:extra][:raw_info]
  #   name = data[:name]
  #   username = data[:nickname]
  #   naver_uid = auth_token[:uid]

  #   current_info = ::PluginStore.get('naver', "naver_uid_#{naver_uid}")

  #   result.user =
  #     if current_info
  #       User.where(id: current_info[:user_id]).first
  #     end

  #   result.name = name
  #   result.username = username
  #   result.extra_data = { naver_uid: naver_uid, raw_info: raw_info }

  #   result
  # end

  # def after_create_account(user, auth)
  #   naver_uid = auth[:uid]
  #   ::PluginStore.set('naver', "naver_uid_#{naver_uid}", {user_id: user.id})
  # end

  # def register_middleware(omniauth)
  #   omniauth.provider :naver, :setup => lambda { |env|
  #     strategy = env['omniauth.strategy']
  #     strategy.options[:client_id] = SiteSetting.naver_client_id
  #     strategy.options[:client_secret] = SiteSetting.naver_client_secret
  #   }
  # end
end

auth_provider :frame_width => 380,
              :frame_height => 460,
              :authenticator => NaverAuthenticator.new

# register_css <<CSS

# .btn-social.naver {
#   background: "#1ec800";
# }

# .btn-social.naver:before {
#   font-family:"arial",
#   content: "N";
# }

# CSS
