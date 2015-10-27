class ProfessorController < ApplicationController
  def index
   unless (session[:position] == "Admin")
     redirect_to path_root
   end
  end
  def excel
    unless (session[:position] == "Admin")
      redirect_to path_root
    end
  end
end
