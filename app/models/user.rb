class User
  attr_accessor :latitude, :longitude, :name, :user_id

  def initialize(name: nil, latitude: nil, longitude: nil, user_id: nil)
    @name = name
    raise 'Name cannot be blank' if @name.blank?

    @latitude = latitude.to_f
    raise 'Latitude must be provided and be a number' if @latitude.blank? || !@latitude.is_a?(Numeric)

    @longitude = longitude.to_f
    raise 'Longitude must be provided and be a number' if @longitude.blank? || !@longitude.is_a?(Numeric)

    @user_id = user_id
  end

  def distance_to(latitude: 0, longitude: 0)
    SphereSurfaceDistance::Calculator.surface_distance_on_earth(
      { latitude: latitude, longitude: longitude },
      { latitude: @latitude, longitude: @longitude }
    )
  end
end
