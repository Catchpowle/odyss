class DiscordJob::DeleteChannelJob < ActiveJob::Base
  queue_as :default

  def perform(channel_id)
    Discord.delete_channel(channel_id)
  end
end
