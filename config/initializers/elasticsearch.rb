# ----- Elasticsearch client setup
if Settings.elasticsearch.client.present?
  Elasticsearch::Model.client = Elasticsearch::Client.new Settings.elasticsearch.client.to_hash
  Contact.__elasticsearch__.create_index!
end

