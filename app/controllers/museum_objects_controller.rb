class MuseumObjectsController < ApplicationController
  def index
    @museum_objects = MuseumObject.all
  end

  def show
    @museum_object = MuseumObject.find_by!(system_number: params[:system_number])

    @vanda_object = VandaCollection::Wrapper.find_by_system_number(@museum_object.system_number)
    unless @vanda_object
      @museum_objects = MuseumObject.all
      flash.now[:alert] = "Object not found"
      render :index, status: :not_found
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Object not found"
  end

  def search
    @museum_object = MuseumObject.new

    @vanda_object = VandaCollection::Wrapper.find_by_system_number(params[:system_number])
    unless @vanda_object
      @museum_objects = MuseumObject.all
      flash.now[:alert] = "Object not found"
      render :index, status: :not_found
    end
  end

  def create
    @museum_object = MuseumObject.new(museum_object_params)

    if @museum_object.save
      redirect_to museum_object_path(@museum_object.system_number), notice: "Object saved successfully"
    else
      response = VandaClient.retrieve_single_object_record(params[:museum_object][:system_number])
      # response = HTTParty.get("https://api.vam.ac.uk/v2/museumobject/#{params[:museum_object][:system_number]}", format: :plain)
      if response.success?
        @result = JSON.parse response.body, object_class: OpenStruct
      else
        flash[:alert] = "Object could not be saved"
        redirect_back(fallback_location: root_path)
        return
      end
      flash.now[:alert] = "Object could not be saved"
      render :search, status: :unprocessable_entity
    end
  end

  private

  def museum_object_params
    params.require(:museum_object).permit(:system_number)
  end
end
