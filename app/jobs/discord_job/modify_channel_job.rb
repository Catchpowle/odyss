class DiscordJob::ModifyChannelJob < ActiveJob::Base
  queue_as :default

  def perform(channel_id, name)
    Discord.modify_channel(channel_id, name)
  end
end
