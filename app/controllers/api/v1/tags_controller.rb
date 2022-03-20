module Api
    module V1
        class TagsController < ApplicationController

            # update tag by owner
            def update
                post = Post.find(params[:id_post]);
                tag = Tag.find(params[:id_tag]);
                if post.user_id == @user.id 
                    tag.update(tag_params)
                    render json: {status: "SUCCESS", message: "The tag successfully edited", data:tag}
                else
                    render json: {status: "ERROR", message: "You can't edit someone else's post tags"}
                end
            end

            private
            def tag_params
                params.permit(:tag)
            end
        end
    end
end