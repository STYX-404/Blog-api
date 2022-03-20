module Api
    module V1
        class PostsController < ApplicationController
            
            # show all posts
            def index
                posts = Post.order('id');
                render json: {status: "SUCCESS", message: "posts loaded", data:posts}
            end
            # show one post by its id
            def show
                post = Post.find(params[:id]);
                render json: {status: "SUCCESS", message: "Posts loaded", data:post}
            end
            # create new post
            def create
                post = @user.posts.new(post_params)
                tag = post.tags.new(tag_params)
                if post.save && tag.save
                    render json: {status: "SUCCESS", message: "post done", data:post}
                else
                    render json: {status: "ERROR", message: "post Failed!", data:[post.errors, tag.errors]}
                end
                DeletePostsJob.perform_later
            end
            #update post by owner
            def update
                post = Post.find(params[:id]);
                if post.user_id == @user.id
                    post.update(post_params)
                    render json: {status: "SUCCESS", message: "post done", data:post}
                else
                    render json: {status: "ERROR", message: "You can't edit someone else's post"}
                end
            end

            #Delete post by owner

            def destroy
                post = Post.find(params[:id]);
                tag = Tag.find_by(post_id: post.id)
                if post.user_id == @user.id
                    tag.destroy
                    post.destroy
                    render json: {status: "SUCCESS", message: "Post deleted successfully"}
                else
                    render json: {status: "ERROR", message: "You can't delete someone else's post"}
                end
            end

            private
            def post_params
                params.permit(:title, :body)
            end
            private
            def tag_params
                params.permit(:tag)
            end
        end
    end
end