class AuthenticationsController < ApplicationController
  def index
  	  puts "auth index"
    @authentications = current_user.authentications if current_user
  end
  
  def create
  	  puts"auth create"
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
    	    puts "if"
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
    	    puts "else if"
      current_user.apply_omniauth(omniauth)
      current_user.save
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else
    	    puts "else"
      user = User.new
      user.apply_omniauth(omniauth)
      if user.save
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, user)
      else
        session[:omniauth] = omniauth
        redirect_to new_user_registration_url
      end
    end
  end
  
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end
