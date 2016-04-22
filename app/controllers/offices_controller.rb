class OfficesController < ApplicationController
  before_action :set_office, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def show
  end

  def new
    @office = Office.new
    @office.parent_id = parent_id_param
  end

  def edit
  end

  def create
    @office = Office.new(office_params)
    @office.save
    respond_with @office
  end

  def update
    @office.update(office_params)
    respond_with @office
  end

  def destroy
    @office.destroy
    respond_with @office, location: -> { dependency_path(@office.parent)  }
  end

  private

  def set_office
    @office = Office.find(params[:id])
  end

  def office_params
    params.require(:office).permit(
      :name, :address, :parent_id, geolocation: [],
    )
  end

  def parent_id_param
    params[:parent_id]
  end
end
