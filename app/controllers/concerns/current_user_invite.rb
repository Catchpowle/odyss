module CurrentUserInvite
  extend ActiveSupport::Concern

  private

  def current_user_invite(group)
    if current_user.groups.include?(group)
      flash[:error] = "You're already member of this group"
    else
      create_membership(group)
      flash[:notice] = 'Group joined!'
    end
    redirect_to group_path(group)
  end

  def create_membership(group)
    Membership.create(user: current_user, group: group)
    DiscordGroupMediator.join(group, current_user)
  end
end
