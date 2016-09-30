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
      redirect_to group_path(@group), notice: 'Group created'
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
      redirect_to group_path(@group), notice: 'Group updated'
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    DiscordGroupMediator.destroy(@group)

    redirect_to root_path, notice: 'Grouped deleted'
  end

  def invite
    @group = Group.find(params[:id])

    if current_user
      current_user_invite
    elsif @group.full?
      redirect_to group_path(@group), error: 'Group full'
    else
      cookies[:group_id] = @group.id
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :objective, :information, :limit,
                                  :start_date)
  end

  def authorize_group
    authorize Group
  end

  def current_user_invite
    if current_user.groups.include?(@group)
      flash[:error] = "You're already member of this group"
    else
      create_membership
      flash[:notice] = 'Group joined!'
    end
    redirect_to group_path(@group)
  end

  def create_membership
    Membership.create(user: current_user, group: @group)
    DiscordGroupMediator.join(@group, current_user)
  end
end
