class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[give_kudo]

  def index
    @users = User.paginate(page: params[:page], per_page: 15)
  end

  def give_kudo
    user = User.find(params[:id])

    if (current_user.teams & user.teams).present? && current_user.id != user.id
      if current_user.kudos_given_in_a_week < current_user.weekly_kudos_limit
        if current_user.given_kudos.pluck(:receiver_id).include?(user.id)
          redirect_to request.referrer, alert: 'You already gave a kudo to this user'
        else
          current_user.increment!(:kudos_given_in_a_week)
          Kudo.create(giver_id: current_user.id, receiver_id: user.id)
          redirect_to request.referrer, notice: 'You gave a kudo'
        end
      else
        redirect_to request.referrer, alert: "You can't give more kudos this week"
      end
    else
      redirect_to request.referrer, alert: 'You are not team members'
    end
  end
end
