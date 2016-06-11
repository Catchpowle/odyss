class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    if current_user.groups.include?(@group)
      @membership = Membership.where(user: current_user, group: @group)
    end
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.users << current_user

    if @group.valid?
      slack = Slack.new(current_user.slack_token)
      response = slack.create(@group.name)

      @group.slack_id = response['group']['id']
      slack.set_purpose(@group.slack_id, @group.objective)
      @group.save

      redirect_to group_path(@group)
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    @group.assign_attributes(group_params)

    if @group.valid?
      slack = Slack.new(current_user.slack_token)
      if @group.name_changed?
        slack.rename(@group.slack_id, @group.name)
      elsif @group.objective_changed?
        slack.set_purpose(@group.slack_id, @group.objective)
      end
      @group.save

      redirect_to group_path(@group)
    end
  end

  def destroy
    @group = Group.find(params[:id])
    Slack.new(current_user.slack_token).archive(@group.slack_id)

    @group.destroy

    redirect_to root_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :objective, :information)
  end
end
