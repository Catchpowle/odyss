class MembershipsController < ApplicationController
  before_action :assign_create_instance_variables, only: [:create]
  before_action :assign_destroy_instance_variables, only: [:destroy]

  def create
    authorize @membership
    @membership.save

    DiscordGroupMediator.join(@group, current_user)
  end

  def destroy
    debugger
    user = @membership.user
    authorize @membership

    @membership.destroy
    DiscordGroupMediator.leave(@group, user)

    if @group.destroyed?
      render_for_group_destroy
    elsif @group.admins.empty?
      assign_new_admin
    end
  end

  private

  def membership_params
    params.require(:group).permit(:name, :objective, :information)
  end

  def set_user
    @user = User.find_by(params[:user_id])
  end

  def render_for_group_destroy
    flash[:notice] = 'Group deleted'
    render js: "window.location = '#{groups_path}'"
  end

  def assign_create_instance_variables
    @group = Group.find(params[:group_id])
    @membership = Membership.new(user: current_user, group: @group)
  end

  def assign_destroy_instance_variables
    debugger
    @membership = Membership.find(params[:id])
    @group = @membership.group
  end

  def assign_new_admin
    @group.memberships.order(:created_at).first.update(admin: Time.zone.now)
  end
end
