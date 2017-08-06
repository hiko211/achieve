class BlogsController < ApplicationController
 before_action :set_blog, only: [:edit, :update, :destroy]
 before_action :authenticate_user!
 
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
  
  def update
   # binding.pry
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