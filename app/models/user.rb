class User
  attr_accessor :latitude, :longitude, :name, :user_id

  def initialize(name: nil, latitude: nil, longitude: nil, user_id: nil)
    @name = name
    raise 'Name cannot be blank' if @name.blank?

    @latitude = latitude.to_f
    if latitude.blank? || !@latitude.is_a?(Numeric) || @latitude.to_s != latitude.to_s
      raise 'Latitude must be provided and be a number'
    end

    @longitude = longitude.to_f
    if longitude.blank? || !@longitude.is_a?(Numeric) || @longitude.to_s != longitude.to_s
      raise 'Longitude must be provided and be a number'
    end

    @user_id = user_id
    raise 'user_id must be supplied' if @user_id.blank?
  end

  def distance_to(latitude: 0, longitude: 0)
    SphereSurfaceDistance::Calculator.surface_distance_on_earth(
      { latitude: latitude, longitude: longitude },
      { latitude: @latitude, longitude: @longitude }
    )
  end
end
