module Api
  module V1
    class ContactsController < ApplicationController
      def show
        @contact = Contact.find(params[:id])
        render json: @contact
      end

    end
  end
end
