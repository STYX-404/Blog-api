module Api
    module V1
        class CommentsController < ApplicationController
            # show all comments
            def index
                comments = Comment.order('id');
                render json: {status: "SUCCESS", message: "comments loaded", data:comments}
            end
            # show one comment by its id
            def show
                comment = Comment.find(params[:id]);
                render json: {status: "SUCCESS", message: "comment loaded", data:comment}
            end
            # create new comment
            def create
                post = Post.find(params[:id]);
                comment = @user.comments.new(comment_params)
                comment.post_id = post.id
                if comment.save
                    render json: {status: "SUCCESS", message: "you added a comment to this post", data:post}
                else
                    render json: {status: "ERROR", message: "comment Failed!", data:[post.errors, comment.errors]}
                end
            end
            # update comment by owner
            def update
                comment = Comment.find(params[:id]);
                if comment.user_id == @user.id
                    comment.update(comment_params)
                    render json: {status: "SUCCESS", message: "The comment successfully edited", data:comment}
                else
                    render json: {status: "ERROR", message: "You can't edit someone else's comment"}
                end
            end

            # Delete post by comment

            def destroy
                comment = Comment.find(params[:id]);
                if comment.user_id == @user.id
                    comment.destroy
                    render json: {status: "SUCCESS", message: "Comment deleted successfully"}
                else
                    render json: {status: "ERROR", message: "You can't delete someone else's comment"}
                end
            end

            private
            def comment_params
                params.permit(:comment)
            end
        end
    end
end