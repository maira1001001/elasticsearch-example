class Office < Contact
  belongs_to :parent, class_name: "Dependency"

  index_name Settings.elasticsearch.default_settings.index_name
  document_type Settings.elasticsearch.default_settings.document_type

  def can_have_children?
    false
  end

  def can_have_parent?
    true
  end

end
