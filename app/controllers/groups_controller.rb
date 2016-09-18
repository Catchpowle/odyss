class GroupsController < ApplicationController
  before_action :authorize_group, only: [:new, :show, :edit]

  def index
    @groups = Group.all.order(:start_date)
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
      DiscordGroupMediator.create(@group, current_user)
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    @group.assign_attributes(group_params)

    if @group.valid?
      DiscordGroupMediator.update(@group)
      redirect_to group_path(@group)
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    DiscordGroupMediator.destroy(@group)

    redirect_to root_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :objective, :information, :limit,
                                  :start_date)
  end

  def authorize_group
    authorize Group
  end
end
