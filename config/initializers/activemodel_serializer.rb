# Generate responses according to the json:api spec (http://jsonapi.org)
ActiveModelSerializers.config.adapter = :json_api

# Enable use of URL helpers inside link blocks in serializers
#ActiveModel::Serializer::Adapter::JsonApi::Link.send(:include, Rails.application.routes.url_helpers)
