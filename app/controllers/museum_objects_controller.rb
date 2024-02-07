require "httparty"
require "json"
require "ostruct"

class MuseumObjectsController < ApplicationController
  include HTTParty

  def index
    @museum_objects = MuseumObject.all
  end
  
  def search
    @museum_object = MuseumObject.new

    response = HTTParty.get("https://api.vam.ac.uk/v2/museumobject/#{params[:system_number]}", format: :plain)

    if response.success?
      @result = JSON.parse response.body, symbolize_names: true, object_class: OpenStruct
    else
      @museum_objects = MuseumObject.all
      flash.now[:alert] = "Object not found"
      render :index, status: :not_found
    end
  end

  def create
    @museum_object = MuseumObject.new(museum_object_params)

    if @museum_object.save
      redirect_to root_path, notice: "Object saved successfully", status: :see_other
    else
      flash.now[:alert] = "Object could not be saved"
      render :search, status: :unprocessable_entity
    end
  end

  private

  def museum_object_params
    params.require(:museum_object).permit(:system_number)
  end
end
