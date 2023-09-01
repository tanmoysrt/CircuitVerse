# frozen_string_literal: true

module UsersCircuitverseHelper
  # Returns an array of priority countries, with "IN" as the default first element.
  # Uses the Geocoder gem to determine the country of the user making the request, based on their IP address.
  # @return [Array<String>] An array of priority countries
  def get_priority_countries
    priority_countries = ["IN"]
    geo_contry = Geocoder.search(request.remote_ip).first&.country
    priority_countries.prepend(geo_contry) if priority_countries.exclude?(geo_contry) && !geo_contry.nil?
    priority_countries
  end

  def user_profile_picture(attachment)
    if attachment.attached?
      attachment
    else
      image_path("thumb/Default.jpg")
    end
  end
end
