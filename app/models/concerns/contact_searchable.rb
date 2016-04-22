require 'elasticsearch/model'
module ContactSearchable
  extend ActiveSupport::Concern

  attr_accessor :client

  included do

    include ::Elasticsearch::Model

    #---Customize the index name

    settings index: { number_of_shards: 1, number_of_replicas: 0 } do
      mapping do
        indexes :name, type: 'string', analyzer: 'simple'
        indexes :id,   index: 'not_analyzed', store: true
        indexes :type, type: 'string', analyzer: 'simple'
      end
    end

    ##---Set up callbacks for updating the index on model changes
    #
    after_save on: [:create] do
      index_document
    end

    after_commit on: [:update] do
      update_document
    end

    after_commit on: [:destroy] do
      initialize_client
      delete_document_in_cascade
    end


    ##---Customize the JSON serialization for Elasticsearch
    #
    def as_indexed_json(options={})
      hash = self.as_json(
        only: [:name, :address, :type],
        methods: [ :ancestors]
      )
    end

    def delete_document_in_cascade
      begin
        @client.delete index: self.class.index_name, type: self.class.document_type, id: id
      rescue Elasticsearch::Transport::Transport::Errors::NotFound
        Rails.logger.error "On destroy:: Error on contact with id:: #{id}, index:: #{self.class.index_name}, document_type:: #{self.class.document_type}>> ¡¡NOT FOUND!!"
      ensure
        if can_have_children?
          children.each do |child|
            delete_index
          end
        end
      end
    end

    def update_document
      begin
        __elasticsearch__.update_document #si no esta indexado, hace __elasticsearch__.index_document
      rescue Elasticsearch::Transport::Transport::Errors::NotFound
        Rails.logger.error "On update:: Error in contact with id: #{id}"
      end
    end

    def index_document
      begin
        similar_contact = Contact.find_by(name: name, type: type)
        if similar_contact.present?
          similar_contact.__elasticsearch__.update_document
        else
          __.elasticsearch__.index_document
        end
      rescue Elasticsearch::Transport::Transport::Errors::NotFound
        Rails.logger.error "On create:: Error in contact with id: #{id}"
      end
    end

    def initialize_client
      @client ||= Elasticsearch::Client.new host: Settings.elasticsearch.client.url
    end

  end
end
