class DiscordJob::RemoveFromChannel < ActiveJob::Base
  queue_as :default

  def perform(name)
    Discord.remove_from_channel(name)
  end
end
