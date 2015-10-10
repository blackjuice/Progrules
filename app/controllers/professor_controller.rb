class ProfessorController < ApplicationController
  def index
   unless (session[:position] == "Admin")
     redirect_to "/"
   end
  end
end
