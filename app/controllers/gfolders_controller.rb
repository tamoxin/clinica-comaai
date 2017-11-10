class GfoldersController < ApplicationController

  before_action :load_group
  before_action :set_gfolder, only: [:show, :edit, :update, :destroy]

  skip_before_action :require_admin, :require_professor, :require_coordinator
  before_action :coord_or_prof_or_stud, only: [:show]
  before_action :require_professor, only: [:edit, :update, :create, :destroy]
  before_action :not_available, only: [:index, :new]




  # GET /gfolders
  # GET /gfolders.json
  def index
    @gfolders = @group.gfolders.all
  end

  # GET /gfolders/1
  # GET /gfolders/1.json
  def show
  end

  # GET /gfolders/new
  def new
    @gfolder = @group.gfolders.new
  end

  # GET /gfolders/1/edit
  def edit
  end

  # POST /gfolders
  # POST /gfolders.json
  def create

    @gfolder = @group.gfolders.new(gfolder_params)

    respond_to do |format|
      if @gfolder.save
        format.html { redirect_to [@group, @gfolder], notice: 'gfolder was successfully created.' }
        # TODO
        # format.json { render :show, status: :created, location: [@group, @gfolder] }
      else
        # format.html { render :new }
        # format.json { render json: @gfolder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gfolders/1
  # PATCH/PUT /gfolders/1.json
  def update
    respond_to do |format|
      if @gfolder.update(gfolder_params)
        format.html { redirect_to [@group, @gfolder], notice: 'gfolder was successfully updated.' }
        # TODO
        # format.json { render :show, status: :ok, location: [@group, @gfolder] }
      else
        format.html { render :edit }
        format.json { render json: @gfolder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gfolders/1
  # DELETE /gfolders/1.json
  def destroy
    @gfolder.destroy
    respond_to do |format|
      format.html { redirect_to group_path(@group), notice: 'gfolder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_gfolder
    @gfolder = @group.gfolders.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def gfolder_params
    params.require(:gfolder).permit(:name)
  end

  def load_group
    @group = Group.find(params[:group_id])
  end

  def coord_or_prof_or_stud
    unless coordinator? || professor? || student? || admin?
      redirect_to group_path(@group)
    end
  end

  def not_available
    redirect_to group_path(@group)
  end
end
