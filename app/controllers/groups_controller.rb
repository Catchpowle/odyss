class GroupsController < ApplicationController
  before_action :authorize_group, only: [:new, :show]
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :authorize_group_instance, only: [:edit, :update, :destroy]

  def index
    @groups = Group.all.order(:start_date)
  end

  def show
    @group = Group.find(params[:id])
    if current_user.groups.include?(@group)
      @membership = Membership.find_by(user: current_user, group: @group)
    end
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    if @group.valid?
      Membership.create(user: current_user, group: @group, admin: Time.zone.now)
      DiscordGroupMediator.create(@group, current_user)
      track_create

      redirect_to group_path(@group), notice: 'Group created'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @group.assign_attributes(group_params)

    if @group.valid?
      DiscordGroupMediator.update(@group)
      redirect_to group_path(@group), notice: 'Group updated'
    else
      render :edit
    end
  end

  def destroy
    DiscordGroupMediator.destroy(@group)

    redirect_to root_path, notice: 'Grouped deleted'
  end

  private

  def group_params
    params.require(:group).permit(:name, :objective, :information, :limit,
                                  :start_date)
  end

  def set_group
    @group = Group.find(params[:id])
  end

  def authorize_group
    authorize Group
  end

  def authorize_group_instance
    authorize @group
  end

  def track_create
    @analytics.track(['group_joined', { created: true }])
  end
end
