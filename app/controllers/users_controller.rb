class UsersController < ApplicationController

  def show
    user = User.find_by(id: show_params[:id])
    render json: {status: "has_errors", error_no: 404, response: "Not found"} if user.nil?
    render json: user, serializer: UserSerializer
  end

  def create
    user = User.new(name: create_params[:name],
                    email: create_params[:email],
                    date_of_birth: create_params[:date_of_birth])
    if user.save
      user.send_registration_email
      render json: user, serializer: UserSerializer
    else
      render json: {status: "has_errors", status_no: 422, response: user.errors}, status: 422
    end
  end

  def update
    user = User.find_by(id: show_params[:id])
    render json: {status: "has_errors", error_no: 404, response: "Not found"} if user.nil?
    if user.update(name: update_params[:name],
                   email: update_params[:email],
                   date_of_birth: update_params[:date_of_birth])
      render json: user, serializer: UserSerializer
    else
      render json: {status: "has_errors", status_no: 422, response: user.errors}, status: 422
    end
  end

  def destroy
    user = User.find_by(id: show_params[:id])
    render json: {status: "has_errors", status_no: 404, response: "Not found"} if user.nil?
    if user.destroy
      render json: {status: "ok", status_no: 200, response: "deleted"}
    else
      render json: {status: "has_errors", status_no: 422, response: user.errors}, status: 422
    end
  end


  protected

  def create_params
    params.require(:name)
    params.require(:email)
    params.permit(:name, :email, :date_of_birth)
  end

  def update_params
    params.require(:id)
    params.require(:name)
    params.require(:email)
    params.permit(:id, :name, :email, :date_of_birth)
  end

  def show_params
    params.require(:id)
    params.permit(:id)
  end
end