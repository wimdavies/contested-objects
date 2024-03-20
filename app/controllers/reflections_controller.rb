class ReflectionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
  end

  def new
    @museum_object = MuseumObject.find_by!(system_number: params[:system_number])
    @vanda_object = VandaCollection::Wrapper.find_by_system_number(params[:system_number])
    @reflection = @museum_object.reflections.new
  end

  def create
    @museum_object = MuseumObject.find_by!(system_number: params[:system_number])
    @vanda_object = VandaCollection::Wrapper.find_by_system_number(params[:system_number])
    @reflection = @museum_object.reflections.new(reflection_params)
    @reflection.update(user_id: current_user.id)

    if @reflection.save
      redirect_to @reflection, notice: "Reflection saved successfully!"
    else
      flash.now[:alert] = "Reflection could not be saved."
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def reflection_params
    params.require(:reflection).permit(
      :deaccession_flag,
      :deaccession_reason,
      :provenance_thoughts,
      :presence_feelings,
      :absence_feelings
    )
  end
end
