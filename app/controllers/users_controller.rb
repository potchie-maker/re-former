class UsersController < ApplicationController
  before_action :set_user, only: %i[ edit update ]
  def new
    # add default value to username field while allowing for render on
    # failed submit to repopulate properly
    @user = User.new(username: "Bon Jovi")
  end

  def edit
  end

  def create
    # @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    @user = User.new(user_params)

    if @user.save
      redirect_to new_user_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params.expect(:id))
  end

  def user_params
    params.expect(user: [:username, :email, :password])
  end
end
