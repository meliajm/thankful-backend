class Api::V1::SessionsController < ApplicationController

    def new
    end

    def create
        user = User.find_by(username: params[:session][:username])
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id 
            render json: {
                current_user: user,
                logged_in: true
            }
        else render json: {
            error: 'Not the right combo.',
            logged_in: false
        }
        end
    end

    def destroy
        session.delete :user_id
    end

    def get_current_user
        if logged_in?
            render json: {
                current_user: current_user,
                logged_in: true
            }
        else
            render json: {
                error: 'You are not logged in.',
                logged_in: false
            }
        end
    end

end