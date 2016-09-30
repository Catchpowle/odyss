class MembershipsController < ApplicationController
  before_action :set_group

  def create
    @membership = Membership.create(user: current_user, group: @group)
    authorize @membership

    DiscordGroupMediator.join(@group, current_user)
  end

  def destroy
    @membership = Membership.find_by(group: @group, user: current_user)
    authorize @membership

    @membership.destroy
    DiscordGroupMediator.leave(@group, current_user)

    render_for_group_destroy if @group.destroyed?
  end

  private

  def membership_params
    params.require(:group).permit(:name, :objective, :information)
  end

  def set_group
    @group = Group.find_by(params[:group_id])
  end

  def render_for_group_destroy
    flash[:notice] = 'Group deleted'
    render js: "window.location = '#{groups_path}'"
  end
end
