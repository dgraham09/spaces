class SpacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
    def index
      @spaces = Space.all

      # Location Search:
      if params[:query].present?
        sql_subquery = "name ILIKE :query OR address ILIKE :query"
        @spaces = @spaces.where(sql_subquery, query: "%#{params[:query]}%")
      end

      # Date Search
      if (params[:query_s_date].present? && params[:query_e_date].present?)
        @spaces.each do |space|
          space.unavailable_date_ranges.each do |range|
            @spaces = @spaces.where.not(id: space.id) if (range.include?(Date.parse(params[:query_s_date])) || range.include?(Date.parse(params[:query_e_date])))
          end
        end
      end

      # Price, Capacity, and Rating Search:
      if params[:min_price].present?
        @spaces = @spaces.where("price >= :min_price", min_price: params[:min_price])
      end

      if params[:max_price].present?
        @spaces = @spaces.where("price <= :max_price", max_price: params[:max_price])
      end


      if params[:min_capacity].present?
        @spaces = @spaces.where("capacity >= :min_capacity", min_capacity: params[:min_capacity])
      end

      if params[:max_capacity].present?
        @spaces = @spaces.where("capacity <= :max_capacity", max_capacity: params[:max_capacity])
      end


      if params[:min_rating].present?
        @spaces = @spaces.where("rating >= :min_rating", min_rating: params[:min_rating])
      end

      if params[:max_rating].present?
        @spaces = @spaces.where("rating <= :max_rating", max_rating: params[:max_rating])
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
