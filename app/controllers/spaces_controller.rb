class SpacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
    def index
      @spaces = Space.all
    end

    def new
      @space = Space.new
    end

    def create
      @space = Space.new(space_params)
      @space.user = current_user
      if @space.save
        redirect_to spaces_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show
      @space = Space.find(params[:id])
      @booking = Booking.new
    end

    def edit
      @space = Space.find(params[:id])
    end

    def update
      @space = Space.find(params[:id])
      @space.update(space_params)
      @space.save
      redirect_to dashboard_path
    end

    def destroy
      @space = Space.find(params[:id])
      @space.destroy
      redirect_to dashboard_path, status: :see_other
    end

    private

    def space_params
      params.require(:space).permit(:name, :address, :price, :photoe)
    end
  end
