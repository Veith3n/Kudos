class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[index]

  def index
    sorted_users = User.all.sort_by { |user| [user.received_kudos.count] }.reverse
    @users = sorted_users.paginate(page: params[:page], per_page: 15)
  end

  def profile
    @user = current_user
  end

  def update_profile
    @user = current_user

    @user.skip_validation = false

    if @user.update(user_params)
      redirect_to root_path, notice: 'Data updated!'
    else
      render 'profile'
    end
  end

  def top_ten
    @users = User.all.sort_by { |user| [user.received_kudos.count] }.reverse.first(10)
  end

  def give_kudo
    user = User.find(params[:id])

    if (current_user.teams & user.teams).present? && current_user.id != user.id
      if current_user.given_kudos.pluck(:receiver_id).include?(user.id)
        redirect_to request.referrer, alert: 'You already gave a kudo to this user'
      else
        Kudo.create(giver_id: current_user.id, receiver_id: user.id)
        redirect_to request.referrer, notice: 'You gave a kudo'
      end
    else
      redirect_to request.referrer, alert: 'You are not team members'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :surname, :birth_date)
  end
end
