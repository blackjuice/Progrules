class UserController < ApplicationController
  def show
    name = params[:name]
    @user = User.find(name)
  end

  def index
    @user = User.all()
  end

  def create
    @user = User.create!(params[:user])
    flash[:notice] = "#{user.name} foi adicionado com sucesso."
    redirect_to root_path
  end

  def destroy
    @user = User.find(params[:name])
    @user.destroy
    flash[:notice] = "Aluno removido com sucesso."
    redirect_to root_path
  end
end
