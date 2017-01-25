class DiscordGroupMediator
  def self.create(group, user)
    DiscordJob::CreateChannelJob.perform_later(group, format_name(group.name))
    join(group, user)
    group.save
  end

  def self.update(group)
    DiscordJob::ModifyChannelJob.perform_later(group.discord_id, format_name(group.name))
    group.save
  end

  def self.destroy(group)
    DiscordJob::DeleteChannelJob.perform_later(group.discord_id)
    group.destroy
  end

  def self.join(group, user)
    DiscordJob::AddToChannelJob.perform_later(group.discord_id, user.discord_id)
  end

  def self.leave(group, user)
    if group.users.empty?
      destroy(group)
    else
      DiscordJob::RemoveFromChannel.perform_later(group.discord_id, user.discord_id)
    end
  end

  private_class_method def self.format_name(name)
    name.tr(' ', '_')
  end
end
