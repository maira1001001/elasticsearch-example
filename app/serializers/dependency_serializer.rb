class DependencySerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :geolocation, :type, :parent

  def parent
    object.parent.id
  end

end
