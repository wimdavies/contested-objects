require "httparty"
require "json"
require "ostruct"

class MuseumObjectsController < ApplicationController
  include HTTParty

  def index
    @museum_objects = MuseumObject.all
  end
  
  def search
    response = HTTParty.get("https://api.vam.ac.uk/v2/museumobject/#{params[:system_number]}", format: :plain)
    @result = JSON.parse response.body, symbolize_names: true, object_class: OpenStruct
  end

  # def new
  #   @museum_object = MuseumObject.new
  # end

  # # def create
  #   @museum_object = MuseumObject.new(museum_object_params)

  #   if @museum_object.save
  #     redirect_to @museum_object
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  # private

  # def museum_object_params
  #   params.require(:museum_object).permit(:system_number)
  # end
end
