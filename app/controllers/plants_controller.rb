class PlantsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = find_plant
    render json: plant
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end

  #PATCH /plants/:id
  def update
    plant = find_plant
    plant.update(plant_params)
    render json: plant, status: :accepted
  end

  #DELETE /plants
  def destroy
    plant = find_plant
    plant.destroy
    head :no_content
  end

  private
  #permit params to the plant
  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end

  #find plant
  def find_plant
    Plant.find(params[:id])
  end

  #render_not_found_response
  def render_not_found_response
    render json: {error: 'Could not find that plant'}, status: :not_found
  end
end
