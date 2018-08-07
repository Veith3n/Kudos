class TeamsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
    @sorted_users_list = @team.users.sort_by { |user| [user.received_kudos.count, -user.id] }.reverse
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      redirect_to team_path(@team), notice: 'Created successfully'
    else
      render :new
    end
  end

  def add_member
    team = Team.find(params[:id])

    if current_user.teams.include?(team)
      redirect_to team, alert: 'You are already member of this team'
    else
      team.users << current_user
      redirect_to team, notice: 'You have become team member'
    end
  end

  def remove_member
    team = Team.find(params[:id])

    if current_user.teams.include?(team)
      team.users.delete(current_user)
      redirect_to team, notice: 'You are no longer a member of this team'
    else
      redirect_to team, alert: 'You are not a member of this team'
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, :description)
  end
end
