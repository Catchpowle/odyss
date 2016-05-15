class Slack
  include HTTParty
  base_uri 'https://odyss.slack.com/api'

  def initialize(token)
    @token = token
  end

  def invite(email)
    options = { body: { email: email, channels: 'C02GZJABP', token: @token,
                        set_active: 'true', _attempts: '1' } }

    url = '/users.admin.invite?t=' + Time.now.to_i.to_s
    self.class.post(url, options)
  end
end
