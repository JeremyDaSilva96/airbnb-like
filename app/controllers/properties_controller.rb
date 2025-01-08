class PropertiesController < ApplicationController
  def index
    @properties = Property.where(active: true, approved: true)
  end

  def show
    @property = Property.find(params[:id])
  end
end
