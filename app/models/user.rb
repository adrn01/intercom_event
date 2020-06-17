class User
  attr_accessor :latitude, :longitude, :name, :user_id

  def initialize(**args)
    @name = args[:name]
    raise 'Name cannot be blank' if @name.blank?

    @latitude = args[:latitude].to_f
    if args[:latitude].blank? || !@latitude.is_a?(Numeric) || !args[:latitude].to_s.strip.match(/^\-?+\d*+\.?+\d*+$/)
      raise 'Latitude must be provided and be a number'
    end

    @longitude = args[:longitude].to_f
    if args[:longitude].blank? || !@longitude.is_a?(Numeric) || !args[:longitude].to_s.strip.match(/^\-?+\d*+\.?+\d*+$/)
      raise 'Longitude must be provided and be a number'
    end

    @user_id = args[:user_id]
    raise 'user_id must be supplied' if @user_id.blank?
  end

  def distance_to(latitude: 0, longitude: 0)
    SphereSurfaceDistance::Calculator.surface_distance_on_earth(
      { latitude: latitude, longitude: longitude },
      { latitude: @latitude, longitude: @longitude }
    )
  end
end
