class Dependency < Contact
  belongs_to :parent, class_name: "Institution"
  has_many :children, class_name: "Office", foreign_key: :parent_id, dependent: :destroy

  index_name Settings.elasticsearch.default_settings.index_name
  document_type Settings.elasticsearch.default_settings.document_type

  def can_have_parent?
    true
  end

end
