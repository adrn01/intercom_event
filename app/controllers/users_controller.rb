class UsersController < ApplicationController
  def index
    @users = Rails.cache.fetch(cache_key)&.sort_by!(&:user_id)
  end

  def import
    parsed_file = File.open(import_params[:user_batch]).map do |user|
      User.new(JSON.parse(user).deep_symbolize_keys)
    end
    Rails.cache.write(cache_key, parsed_file, expires_in: 2.hours)

    notice = 'loaded users'
    redirect_to users_path, notice: notice
  rescue Exception => e
    notice = "Oops, we weren't able to process that file, please check it is in the correct format and try again."
    redirect_to users_path, notice: notice
  end

  private

  def cache_key
    session[:results_key] ||= SecureRandom.uuid
  end

  def import_params
    params.permit(:latitude, :longitude, :user_batch)
  end
end
