class MembershipsController < ApplicationController
  def create
    @group = Group.find_by(params[:group_id])
    @membership = Membership.create(user: current_user, group: @group)
    DiscordGroupMediator.join(@group, current_user)
  end

  def destroy
    @group = Group.find_by(params[:group_id])
    @membership = Membership.find_by(group: @group, user: current_user)
    @membership.destroy
    DiscordGroupMediator.leave(@group, current_user)

    render js: "window.location = '#{groups_path}'" if @group.destroyed?
  end

  private

  def membership_params
    params.require(:group).permit(:name, :objective, :information)
  end
end
