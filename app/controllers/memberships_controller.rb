class MembershipsController < ApplicationController
  def create
    @group = Group.find_by(params[:group_id])
    @membership = Membership.create(user: current_user, group: @group)
    token = @group.users.first.slack_token

    Slack.new(token).invite(@group.slack_id, current_user.slack_id)
  end

  def destroy
    @group = Group.find_by(params[:group_id])
    @membership = Membership.find_by(group: @group, user: current_user)
    @membership.destroy

    if @group.users.empty?
      Slack.new(current_user.slack_token).archive(@group.slack_id)
      @group.destroy
    else
      Slack.new(current_user.slack_token).leave(@group.slack_id)
    end
  end

  private

  def membership_params
    params.require(:group).permit(:name, :objective, :information)
  end
end
