class UsersController < ApplicationController
  before_action :check, only: [:edit, :update]
  
  def show # 追加
   @user = User.find(params[:id])
   @microposts = @user.microposts.order(created_at: :desc).page(params[:page]).per(3)
  end
  
  def new
     @user = User.new
  end


  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
     redirect_to @user # ここを修正
    else
      render 'new'
    end
  end
  
  def edit
     @user = User.find(params[:id])
  end
  
  def update
       @user = User.find(params[:id])
    if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to @user , notice: 'メッセージを編集しました'
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  def following
    @titlle = "Followings"
       @user = User.find(params[:id])
       @users = @user.following_users
  end
  
  def followers
     @titlle = "Followers"
       @user = User.find(params[:id])
       @users =  @user.follower_users
  end
  
 private

  def user_params
    params.require(:user).permit(:name, :email, :password, :area,
                                 :password_confirmation)
  end
  
  def check
    @user = User.find(params[:id])
    redirect_to root_path if current_user != @user
  end
end
