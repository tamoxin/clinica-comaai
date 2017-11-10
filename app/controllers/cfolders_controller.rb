class CfoldersController < ApplicationController

  before_action :load_course
  before_action :set_cfolder, only: [:show, :edit, :update, :destroy]

  skip_before_action :require_admin, :require_coordinator
  before_action :coord_or_prof, :is_owner
  before_action :require_professor, only: [:edit, :update, :create, :destroy]
  before_action :not_available, only: [:index, :new]




  # GET /cfolders
  # GET /cfolders.json
  def index
    @cfolders = @course.cfolders.all
  end

  # GET /cfolders/1
  # GET /cfolders/1.json
  def show
  end

  # GET /cfolders/new
  def new
    @cfolder = @course.cfolders.new
  end

  # GET /cfolders/1/edit
  def edit
  end

  # POST /cfolders
  # POST /cfolders.json
  def create

    @cfolder = @course.cfolders.new(cfolder_params)

    respond_to do |format|
      if @cfolder.save
        format.html { redirect_to [@course, @cfolder], notice: 'Cfolder was successfully created.' }
        # TODO
        # format.json { render :show, status: :created, location: [@course, @cfolder] }
      else
        # format.html { render :new }
        # format.json { render json: @cfolder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cfolders/1
  # PATCH/PUT /cfolders/1.json
  def update
    respond_to do |format|
      if @cfolder.update(cfolder_params)
        format.html { redirect_to [@course, @cfolder], notice: 'Cfolder was successfully updated.' }
        # TODO
        # format.json { render :show, status: :ok, location: [@course, @cfolder] }
      else
        # format.html { render :edit }
        # format.json { render json: @cfolder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cfolders/1
  # DELETE /cfolders/1.json
  def destroy
    @cfolder.destroy
    respond_to do |format|
      format.html { redirect_to course_path(@course), notice: 'Cfolder was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cfolder
      @cfolder = @course.cfolders.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cfolder_params
      params.require(:cfolder).permit(:name)
    end

    def load_course
      @course = Course.find(params[:course_id])
    end

  def coord_or_prof
    unless coordinator? || professor? || admin?
      redirect_to course_path(@course)
    end
  end

  def not_available
    redirect_to course_path(@course)
  end

  def is_owner
    unless coordinator? || admin?
      unless current_user.id == Course.find(params[:course_id]).professor_id
        redirect_to courses_path
      end
    end
  end

end
