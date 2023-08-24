class SpacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
    def index
      @spaces = Space.all
      if params[:query].present?
        sql_subquery = "name ILIKE :query OR address ILIKE :query"
        @spaces = @spaces.where(sql_subquery, query: "%#{params[:query]}%")
      end

      if params[:query_s_date].present?
        @spaces = @spaces.where{booking_start_date: params[:query_s_date]}
        (query_s_date >= booking_start_date && query_s_date <= booking_end_date
      end



      @spaces.booking.each do |booking_start_date, booking_end_date|
        if ) ||
           (query_e_date >= booking_start_date && query_e_date <= booking_end_date)
          return false # Dates overlap with an existing booking
        end
      end
      true # Dates are available
    end

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

      @markers = [{lat: @space.latitude, lng: @space.longitude, info_window_html: render_to_string(partial: "info_window", locals: {space: @space})}]
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
      params.require(:space).permit(:name, :address, :price, :photo)
    end
  end
