class SpacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
    def index
      @spaces = Space.all
      if params[:query].present?
        sql_subquery = "name ILIKE :query OR address ILIKE :query"
        @spaces = @spaces.where(sql_subquery, query: "%#{params[:query]}%")
      end

      if (params[:query_s_date].present? && params[:query_e_date].present?)
        @spaces.each do |space|
          space.unavailable_date_ranges.each do |range|
            @spaces = @spaces.where.not(id: space.id) if (range.include?(Date.parse(params[:query_s_date])) || range.include?(Date.parse(params[:query_e_date])))
          end
        end
      end

      @spaces
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
