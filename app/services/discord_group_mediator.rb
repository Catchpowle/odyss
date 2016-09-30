class DiscordGroupMediator
  def self.create(group, user)
    response = Discord.create_channel(format_name(group.name))
    group.discord_id = response['id']
    join(group, user)
    group.save
  end

  def self.update(group)
    Discord.modify_channel(group.discord_id, format_name(group.name))
    group.save
  end

  def self.destroy(group)
    Discord.delete_channel(group.discord_id)
    group.destroy
  end

  def self.join(group, user)
    Discord.add_to_channel(group.discord_id, user.discord_id)
  end

  def self.leave(group, user)
    if group.users.empty?
      destroy(group)
    else
      Discord.remove_from_channel(group.discord_id, user.discord_id)
    end
  end

  private_class_method def self.format_name(name)
    name.tr(' ', '_')
  end
end
