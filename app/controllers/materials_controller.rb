class MaterialsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_material, only: %i[ show edit update destroy add remove]

  # GET /materials or /materials.json
  def index
    @materials = if params[:search]
                   Material.order(:name).where('name ILIKE ?', "%#{params[:search]}%").page(params[:page]).per(10)
                 else
                   Material.order(:name).page(params[:page]).per(10)
                 end
  end

  # GET /materials/1 or /materials/1.json
  def show
  end

  # GET /materials/new
  def new
    @material = Material.new
  end

  # GET /materials/1/edit
  def edit
  end

  # POST /materials or /materials.json
  def create
    @material = Material.new(material_params)
    begin
      @material.save
    rescue ActiveRecord::RecordNotUnique => e
      @material.errors.add(:nome, "já esta sendo utilizado")
    end

    respond_to do |format|
      if @material.errors.blank?
        format.html { redirect_to material_url(@material), notice: "Material was successfully created." }
        format.json { render :show, status: :created, location: @material }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /materials/1 or /materials/1.json
  def update
    respond_to do |format|
      if @material.update(material_params)
        format.html { redirect_to material_url(@material), notice: "Material was successfully updated." }
        format.json { render :show, status: :ok, location: @material }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @material.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /materials/1 or /materials/1.json
  def destroy
    @material.destroy

    respond_to do |format|
      format.html { redirect_to materials_url, notice: "Material was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add
    response = @material.add_quantity(params[:add_quantity].to_i, current_user)
    if response.eql?(true)
      redirect_to materials_url, notice: "Material quantity was successfully added."
    elsif response.eql?('isnt_working_day')
      redirect_to materials_url, alert: "No update permitted out of work day range."
    else
      redirect_to materials_url, alert: "Failed to add material quantity."
    end
  end

    def remove
    response = @material.remove_quantity(params[:remove_quantity].to_i, current_user)
    if response.eql?(true)
      redirect_to materials_url, notice: "Material quantity was successfully removed."
    elsif response.eql?('isnt_working_day')
      redirect_to materials_url, alert: "No update permitted out of work day range."
    else
      redirect_to materials_url, alert: "Failed to remove material quantity."
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_material
    @material = Material.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def material_params
    params.require(:material).permit(:name, :quantity)
  end
end
