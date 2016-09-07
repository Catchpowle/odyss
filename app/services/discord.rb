class Discord
  include HTTParty

  AUTHORIZATION = 'Bot MjA4OTkyODQ0MzUyODQ3ODc1.CqyhIw.'\
                  'rG9jd8_Wq_oPq_fRB4_xPcYEFpw'.freeze
  GUILD_ID = '208586716414476288'.freeze

  base_uri 'https://discordapp.com/api'
  headers 'Authorization' => AUTHORIZATION
  headers 'Content-Type' => 'application/json'

  def self.create_channel(name)
    url = "/guilds/#{GUILD_ID}/channels"
    options = { body: { name: name }.to_json }

    post(url, options)
  end

  def self.modify_channel(channel_id, name)
    url = "/channels/#{channel_id}"
    options = { body: { name: name }.to_json }

    patch(url, options)
  end

  def self.delete_channel(channel_id)
    url = "/channels/#{channel_id}"

    delete(url)
  end

  def self.add_to_channel(channel_id, user_id)
    url = "/channels/#{channel_id}/permissions/#{user_id}"
    options = { body: { allow: 1024, type: 'member' }.to_json }

    put(url, options)
  end

  def self.remove_from_channel(channel_id, user_id)
    url = "/channels/#{channel_id}/permissions/#{user_id}"
    options = { body: { deny: 1024, type: 'member' }.to_json }

    put(url, options)
  end
end
