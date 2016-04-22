class OfficeSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :geolocation, :type, :parent

  def parent
    object.parent.id
  end

end
