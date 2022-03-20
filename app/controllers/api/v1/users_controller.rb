module Api
    module V1
        class UsersController < ApplicationController
            before_action :authorized, only: [:auto_login, :show, :index]
            def login
                user = User.find_by(email: params[:email])
                if user && user.authenticate(params[:password])
                  token = encode_token({user_id: user.id})
                  render json: {user: user, token: token}
                else
                  render json: {error: "Invalid username or password"}
                end
            end

            def auto_login
                render json: @user
              end

            def index
                users = User.order('id');
                render json: {status: "SUCCESS", message: "Users loaded", data:users}
            end

            def show
                user = User.find(params[:id]);
                render json: {status: "SUCCESS", message: "User loaded", data:user}
            end

            def create
                user = User.new(user_params)
                token = encode_token({user_id: user.id})
                if user.save
                    render json: {status: "SUCCESS", message: "User Signed Up", data:user, token:token}
                else
                    render json: {status: "ERROR", message: "User Signed Up Failed!", data:user.errors}
                end
            end

            def user_params
                params.permit(:name, :email, :password, :image)
            end
        end
    end
end