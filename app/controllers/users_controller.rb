class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[index]

  def index
    @users = User.paginate(page: params[:page], per_page: 15)
  end

  def edit
    @user = User.find(params[:id])
    redirect_to root_path, alert: 'You can only edit your data' if @user != current_user
  end

  def update
    @user = User.find(params[:id])
    if @user == current_user
      @user.skip_validation = false

      if @user.update(user_params)
        redirect_to root_path, notice: 'Data updated!'
      else
        render 'edit'
      end
    else
      redirect_to root_path, alert: 'You can only edit your data'
    end
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
