class CommentsController < ApplicationController
  def create
    # Blogをパラメータの値から探し出し,Blogに紐づくcommentsとしてbuildします。
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_path(@blog), notice: 'コメントを投稿しました。' }
        format.js { render :index }
      unless @comment.blog.user_id == current_user.id
        Pusher.trigger("user-#{@comment.blog.user_id}_channel", 'comment_created', {
          message: 'あなたの作成したブログにコメントが付きました'
        })
       else
        format.html { render :new }
      end
    end
  end


  def destroy
   @comment = Comment.find(params[:id])
   @comment.destroy
    flash.now[:notice] = 'コメントを削除しました。'
   respond_to do |format|
    format.js { render :index }
   end
  end


  private
    def comment_params
      params.require(:comment).permit(:blog_id, :content)
    end
  end