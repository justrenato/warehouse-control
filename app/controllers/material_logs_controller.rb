class MaterialLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_material, only: %i[ show edit update destroy add remove]
  before_action :set_was_manual_updated, only: %i[add remove]

  # GET /materials or /materials.json
  def index
    @material_logs = MaterialLog.order(created_at: :desc).page(params[:page]).per(10)
  end

  # GET /materials/1 or /materials/1.json
  def show
  end

  # GET /materials/new
  def new
    @material_logs = MaterialLog.new
  end

  # GET /materials/1/edit
  def edit
  end

  # POST /materials or /materials.json
  def create
    @material_logs = MaterialLog.new(material_params)
    begin
      @material_logs.save
    rescue ActiveRecord::RecordNotUnique => e
      @material_logs.errors.add(:nome, "já esta sendo utilizado")
    end

    respond_to do |format|
      if @material_logs.errors.blank?
        format.html { redirect_to material_url(@material_logs), notice: "MaterialLog was successfully created." }
        format.json { render :show, status: :created, location: @material_logs }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @material_logs.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /materials/1 or /materials/1.json
  def update
    respond_to do |format|
      if @material_logs.update(material_params)
        format.html { redirect_to material_url(@material_logs), notice: "MaterialLog was successfully updated." }
        format.json { render :show, status: :ok, location: @material_logs }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @material_logs.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /materials/1 or /materials/1.json
  def destroy
    @material_logs.destroy

    respond_to do |format|
      format.html { redirect_to materials_url, notice: "MaterialLog was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add
    @material_logs.add_quantity(params[:add_quantity].to_i)

    respond_to do |format|
      format.html { redirect_to materials_url, notice: "MaterialLog quantity was successfully add." }
      format.json { head :no_content }
    end
  end

  def remove
    @material_logs.remove_quantity(params[:remove_quantity].to_i)

    respond_to do |format|
      format.html { redirect_to materials_url, notice: "MaterialLog quantity was successfully removed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_material
    @material_logs = MaterialLog.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def material_params
    params.require(:material).permit(:name, :quantity)
  end

  def set_was_manual_updated
    @material_logs.was_manual_updated = true
    @material_logs.save
  end
end
