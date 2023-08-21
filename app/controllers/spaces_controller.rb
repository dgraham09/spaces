class SpacesController < ApplicationController
    def index
      @spaces = Space.all
    end

    def new
      @space = Space.new
    end

    def create
      @space = Space.new(space_params)
      @space.save
      redirect_to spaces_path
    end

    def show
      @space = Space.find(params[:id])
    end

    def destroy
      @space = Space.find(params[:id])
      @space.destroy
      redirect_to spaces_path, status: :see_other
    end

    private

    def space_params
      params.require(:space).permit(:name, :address, :price)
    end
  end
