# name: naver.com
# about: Authenticate with discourse with naver.com, see more at: http://developer.naver.com/wiki/pages/NaverLogin
# version: 0.1.0
# author: lainfox

#gem 'omniauth-naver', '~> 0.0.1'

class NaverAuthenticator < ::Auth::Authenticator

  def name
    'naver'
  end

  def after_authenticate(auth_token)
    result = Auth::Result.new

    # grap the info we need from omni auth
    data = auth_token[:info]
    raw_info = auth_token["extra"]["raw_info"]
    name = data["name"]
    naver_uid = auth_token["uid"]

    # plugin specific data storage
    current_info = ::PluginStore.get("naver", "naver_uid_#{naver_uid}")

    result.user =
      if current_info
        User.where(id: current_info[:user_id]).first
      end

    result.name = name
    result.extra_data = { naver_uid: naver_uid }

    result
  end

  def after_create_account(user, auth)
    data = auth[:extra_data]
    ::PluginStore.set("naver", "naver_uid_#{data[:naver_uid]}", {user_id: user.id })
  end

  def register_middleware(omniauth)
    omniauth.provider :naver, :setup => lambda { |env|
      strategy = env['omniauth.strategy']
      strategy.options[:client_id] = SiteSetting.naver_client_id
      strategy.options[:client_secret] = SiteSetting.naver_client_secret
    }
  end
end


auth_provider :frame_width => 920,
              :frame_height => 800,
              :authenticator => NaverAuthenticator.new

# We ship with zocial, it may have an icon you like http://zocial.smcllns.com/sample.html
#  in our current case we have an icon for vk

register_css <<CSS

.btn-social.naver {
  background: #1ec800;
}

.btn-social.naver:before {
  font-family:"arial",
  content: "N";
}

CSS
