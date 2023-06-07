

class SessionsController < ApplicationController
  def new
  end

  def create
    # authenticate the user
    @user = User.find_by({ "email" => params["email"] })
    if @user
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        redirect_to "/places"
      else
        flash["notice"] = "Incorrect Email or Password!"
        redirect_to "/login"
      end
    else
      flash["notice"] = "Incorrect Email or Password!"
      redirect_to "/login"
    end
  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "Visit again!"
    redirect_to "/login"
  end
end