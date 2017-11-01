class BlogsController < ApplicationController
 before_action :set_blog, only: [:show, :edit, :update, :destroy]
 before_action :authenticate_user!
 #before_action :signed_in_user, only: [:edit, :update]
 #before_action :correct_user,   only: [:edit, :update]

  def index
   @blogs = Blog.all
  end

  def new
   if params[:back]
    @blog = Blog.new(blogs_params)
   elsif
    @blog = Blog.new
   end
  end

  def create
   @blog = Blog.new(blogs_params)
   @blog.user_id = current_user.id
   @blog.name = current_user.name
   if @blog.save
    redirect_to blogs_path, notice: "ブログを作成しました！"
    NoticeMailer.sendmail_blog(@blog).deliver
   else
    render 'new'
   end
  end

  def confirm
   @blog = Blog.new(blogs_params)
   render :new if @blog.invalid?
  end

  def edit
  end

  def show
    @comment = @blog.comments.build
    @comments = @blog.comments
    Notification.find(params[:notification_id]).update(read: true) if params[:notification_id]
  end

  def update
   #binding.pry
   if @blog.update(blogs_params)
    redirect_to blogs_path
   else
    render 'edit'
   end
  end

  def destroy
   @blog.destroy
   redirect_to blogs_path, notice: "ブログを削除しました！"
  end

  private
    def blogs_params
      params.require(:blog).permit(:name, :title, :content)
    end

    def set_blog
      @blog = Blog.find(params[:id])
    end
end
