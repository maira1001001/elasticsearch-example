class InstitutionSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :geolocation, :type, :parent

  def parent
    nil
  end

end
