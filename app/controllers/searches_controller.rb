class SearchesController < ApplicationController
  def index
    @query = params[:query]

    @properties = if @query.present?
      Property.search_by_location_and_attributes(@query)
    else
      Property.all
    end

    # If coordinates are provided, sort by distance
    if params[:latitude].present? && params[:longitude].present?
      @properties = @properties.near([params[:latitude], params[:longitude]], 50)
    end

    @markers = @properties.map do |property|
      {
        lat: property.latitude,
        lng: property.longitude,
        info_window_html: render_to_string(partial: "properties/info_window", locals: { property: property })
      }
    end
  end
end
