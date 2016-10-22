module Groups
  class InviteController < ApplicationController
    include CurrentUserInvite

    def show
      @group = Group.find(params[:group_id])

      if current_user
        current_user_invite(@group)
      elsif @group.full?
        redirect_to group_path(@group), error: 'Group full'
      else
        cookies[:group_id] = @group.id
      end
    end
  end
end
