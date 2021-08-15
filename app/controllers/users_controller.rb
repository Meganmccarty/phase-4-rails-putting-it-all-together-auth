class UsersController < ApplicationController
    before_action :authorize, only: [:show]

    def create
        user = User.new(user_params)
        if user.valid?
            user.save
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def show
        user = User.find_by(id: session[:user_id])
        render json: user, status: :created
    end

    private

    def user_params
        params.permit(:username, :password, :password_confirmation, :image_url, :bio)
    end

    def authorize
        render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
    end
end
