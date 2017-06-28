class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  geocoded_by :address, :latitude  => :lat, :longitude => :lng
  after_validation :geocode

  reverse_geocoded_by :lat, :lng do |address, results|
    fields = [:street_number, :route, :neighborhood, :sublocality, :administrative_area_level_1, :administrative_area_level_2, :country, :postal_code]
    result = results.first
    if result
      result.data['address_components'].each do |address_component|
        fields.each do |field|
          if address_component['types'].include? field.to_s
            address[field] = address_component['long_name']
          end
        end
      end
    end
  end

  after_validation :reverse_geocode
end
