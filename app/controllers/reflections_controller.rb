class ReflectionsController < ApplicationController
  def index
  end

  def new
    @reflection = Reflection.new
    @vanda_object = VandaCollection::Wrapper.find_by_system_number(params[:system_number])
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
