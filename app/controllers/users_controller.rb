class UsersController < ApplicationController
  def index
    @users = []
  end

  def import
    # @base_location = { latitude: import_params[:latitude], longitude: import_params[:longitude] }
    @users = File.open(import_params[:user_batch]).map do |user|
      User.new(JSON.parse(user).deep_symbolize_keys)
    end

    @users.sort_by!(&:user_id)

    notice = 'loaded users'
    render :index, notice: notice
  # rescue Exception => e
  #   notice = 'Oops, we weren\'t able to process that file, please check it is in the correct format and try again.' +
  #            "\n" + e.message
  #   redirect_to users_path, notice: notice
  end

  private

  def import_params
    params.permit(:latitude, :longitude, :user_batch)
  end
end
