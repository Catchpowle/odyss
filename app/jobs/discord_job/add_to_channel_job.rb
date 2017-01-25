class DiscordJob::AddToChannelJob < ActiveJob::Base
  queue_as :default

  def perform(channel_id, user_id)
    Discord.add_to_channel(channel_id, user_id)
  end
end
