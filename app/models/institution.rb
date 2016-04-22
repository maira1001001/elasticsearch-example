class Institution < Contact 
  has_many :children, class_name: "Dependency", foreign_key: :parent_id, dependent: :destroy

  index_name Settings.elasticsearch.default_settings.index_name
  document_type Settings.elasticsearch.default_settings.document_type

end
