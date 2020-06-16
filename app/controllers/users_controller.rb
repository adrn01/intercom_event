class UsersController < ApplicationController
  before_action :set_users, only: %i[index download]

  def index; end

  def download
    return redirect_to users_path, notice: 'Please upload a user file first' if @users.nil?

    @users.select! { |u| download_params[:ids].include? u.user_id.to_s }

    f = Tempfile.new
    @users.map { |u| f.puts u.instance_values.as_json }
    f.close
    send_file(f.path, filename: "users_#{Time.now.strftime('%Y%m%d%H%M')}.txt",
                      type: 'application/text',
                      disposition: 'attachment')
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

  def download_params
    params.permit(ids: [])
  end

  def import_params
    params.permit(:user_batch)
  end

  def set_users
    @users = Rails.cache.fetch(cache_key)&.sort_by!(&:user_id)
  end
end
