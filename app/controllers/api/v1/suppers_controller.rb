class Api::V1::SuppersController < ApplicationController

  def index
    @suppers = Supper.all
    render json: @suppers
  end

  def create
  @supper = Supper.new(name: params[:name], description: params[:description], date: params[:date], time: params[:time], picture: params[:picture], address: params[:address], city: params[:city], postcode: params[:postcode], user_id: params[:user_id])
    if @supper.save
      render json: @supper
    else
      render json: {error: "Unable to create supper"}, status: 400
    end
  end

  # QUESTION: Need to confirm how to find_by both params, so not just one

  def update
    @supper = Supper.find_by(name: params[:name], user_id: params[:user_id])
    if @supper.update_attributes(supper_params)
      flash[:success] = "Supper updated"
      render json: @supper
    else
      render json: {error: "Unable to edit supper"}, status: 400
    end
  end

  def delete
    @supper = Supper.find_by(name: params[:name], user_id: params[:user_id])
    @supper.destroy
  end



private

def supper_params
  params.permit(:name, :description, :date, :time, :picture, :address, :city, :postcode, :user_id)
end

end