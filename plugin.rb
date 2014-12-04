# name: Douban login
# about: Authenticate with discourse with douban.
# version: 0.2.0
# author: Erick Guan

gem 'omniauth-douban-oauth2', '0.0.7'

class DoubanAuthenticator < ::Auth::Authenticator

  def name
    'douban'
  end

  def after_authenticate(auth_token)
    result = Auth::Result.new

    data = auth_token[:info]
    credentials = auth_token[:credentials]
    raw_info = auth_token[:extra][:raw_info]
    name = data[:name]
    username = data[:nickname]
    douban_uid = auth_token[:uid]

    current_info = ::PluginStore.get('douban', "douban_uid_#{douban_uid}")

    result.user =
      if current_info
        User.where(id: current_info[:user_id]).first
      end

    result.name = name
    result.username = username
    result.extra_data = { douban_uid: douban_uid, raw_info: raw_info }

    result
  end

  def after_create_account(user, auth)
    douban_uid = auth[:uid]
    ::PluginStore.set('douban', "douban_uid_#{douban_uid}", {user_id: user.id})
  end

  def register_middleware(omniauth)
    omniauth.provider :douban, :setup => lambda { |env|
      strategy = env['omniauth.strategy']
      strategy.options[:client_id] = SiteSetting.douban_client_id
      strategy.options[:client_secret] = SiteSetting.douban_client_secret
    }
  end
end

auth_provider :frame_width => 380,
              :frame_height => 460,
              :authenticator => DoubanAuthenticator.new,
              :background_color => 'rgb(42, 172, 94)'

register_css <<CSS

.btn-social.douban:before {
  content: "豆";
}

CSS
