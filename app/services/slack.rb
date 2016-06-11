class Slack
  include HTTParty
  base_uri 'https://odyss.slack.com/api'

  def initialize(token)
    @token = token
  end

  def admin_invite(email)
    options = { body: { email: email, channels: 'C02GZJABP', token: @token,
                        set_active: 'true', _attempts: '1' } }
    url = '/users.admin.invite?t=' + Time.now.to_i.to_s

    self.class.post(url, options)
  end

  def create(name)
    options = { body: { token: @token, name: name } }
    url = '/groups.create'

    self.class.post(url, options)
  end

  def rename(channel, name)
    options = { body: { token: @token, channel: channel, name: name } }
    url = '/groups.rename'

    self.class.post(url, options)
  end

  def set_purpose(channel, purpose)
    options = { body: { token: @token, channel: channel, purpose: purpose } }
    url = '/groups.setPurpose'

    self.class.post(url, options)
  end

  def archive(channel)
    options = { body: { token: @token, channel: channel } }
    url = '/groups.archive'

    self.class.post(url, options)
  end

  def invite(channel, user)
    options = { body: { token: @token, channel: channel, user: user } }
    url = '/groups.invite'

    self.class.post(url, options)
  end

  def leave(channel)
    options = { body: { token: @token, channel: channel } }
    url = '/groups.leave'

    self.class.post(url, options)
  end
end
