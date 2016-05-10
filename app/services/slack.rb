class Slack
  include HTTParty
  base_uri 'https://odyss.slack.com/api'

  def initialize(email)
    @options = {
      body: {
        email: email,
        channels: 'C02GZJABP',
        token: ENV['SLACK_TOKEN'],
        set_active: 'true',
        _attempts: '1'
      }
    }
  end

  def invite
    url = '/users.admin.invite?t=' + Time.now.to_i.to_s
    self.class.post(url, @options)
  end
end
