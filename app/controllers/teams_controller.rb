class TeamsController < ApplicationController
  before_action :authenticate_user!, only: %i[add_member remove_member]

  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
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
end
