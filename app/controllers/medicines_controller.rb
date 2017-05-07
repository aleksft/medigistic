class MedicinesController < ApplicationController
  before_action :set_medicine, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @medicines = Medicine.all
    respond_with(@medicines)
  end

  def show
    respond_with(@medicine)
  end

  def new
    @medicine = Medicine.new
    respond_with(@medicine)
  end

  def edit
  end

  def create
    @medicine = Medicine.new(medicine_params)
    @medicine.save
    respond_with(@medicine)
  end

  def update
    @medicine.update(medicine_params)
    respond_with(@medicine)
  end

  def destroy
    @medicine.destroy
    respond_with(@medicine)
  end

  def search
    if params[:medicine]
      @medicine = Medicine.where("user_id = ? AND name LIKE ?", current_user.id, "%#{params[:medicine]}%")
    end

    if @medicine
      render partial: 'lookup'
    else
      render status: :not_found, nothing: true
    end
  end

  private
    def set_medicine
      @medicine = Medicine.find(params[:id])
    end

    def medicine_params
      params.require(:medicine).permit(:name, :description, :expiration, :user_id)
    end
end
