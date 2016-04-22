class Contact < ActiveRecord::Base
  serialize :geolocation, Array
  belongs_to :parent, class_name: "Contact"
  has_many :children, class_name: "Contact", foreign_key: :parent_id

  include ContactSearchable

  index_name Settings.elasticsearch.default_settings.index_name
  document_type Settings.elasticsearch.default_settings.document_type

  def preorder
    return if is_root? && is_leaf?
    return [name] if is_root?
    contacts = parent.preorder
    contacts << name
  end

  def ancestors
    contacts = preorder
    return if contacts.nil? || contacts.size == 1
    contacts[0..contacts.size-2]
  end

  def can_have_children?
    true
  end

  def can_have_parent?
    false
  end

  def is_root?
    parent.nil?
  end

  def is_leaf?
    children.blank?
  end

  def geolocation=(v)
    sanitized = v.map do |marker|
      JSON.parse(marker) rescue nil
    end.compact rescue []
    super sanitized
  end

end
