class PropertiesController < ApplicationController
  def index
    @properties = Property.where(active: true, approved: true)
  end
end
