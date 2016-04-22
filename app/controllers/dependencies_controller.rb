class DependenciesController < ApplicationController
  before_action :set_dependency, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def show
  end

  def new
    @dependency = Dependency.new
    @dependency.parent_id = parent_id_param
  end

  def edit
  end

  def create
    @dependency = Dependency.new(dependency_params)
    @dependency.save
    respond_with @dependency
  end

  def update
    @dependency.update(dependency_params)
    respond_with @dependency
  end

  def destroy
    @dependency.destroy
    respond_with @dependency , location: -> { institution_path(@dependency.parent) }
  end

  private
  def set_dependency
    @dependency = Dependency.find(params[:id])
  end

  def parent_id_param
    params[:parent_id]
  end

  def dependency_params
    params.require(:dependency).permit(
      :name, :address, :parent_id, geolocation: []
    )
  end
end
