class DiscordJob::CreateChannelJob < ActiveJob::Base
  queue_as :default

  def perform(group, name)
    response = Discord.create_channel(name)
    group.update(discord_id: response['id'])
  end
end
