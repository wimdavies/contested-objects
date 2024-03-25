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
    # Assign MuseumObject a name from the API result primary title or object type if no title.
    # Will throw error if system number invalid, which devalues subsequent control flow.
    # TODO: integrate this into forthcoming Service
    vanda_object = VandaCollection::Wrapper.find_by_system_number(@museum_object.system_number)
    object_name = vanda_object.record.titles[0].title.presence || vanda_object.record.object_type
    @museum_object.update(name: object_name)

    if @museum_object.save
      redirect_to museum_object_path(@museum_object.system_number), notice: "Object saved successfully"
    else
      @vanda_object = VandaCollection::Wrapper.find_by_system_number(params[:museum_object][:system_number])
      unless @vanda_object
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
