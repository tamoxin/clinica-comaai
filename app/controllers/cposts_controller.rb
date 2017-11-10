class CpostsController < ApplicationController

  before_action :load_course, :load_cfolder
  before_action :set_cpost, only: [:show, :edit, :update, :destroy]

  skip_before_action :require_login, :require_admin, :require_coordinator
  before_action :require_professor, only: [:create, :destroy]
  before_action :not_available, except: [:create, :destroy]
  before_action :is_owner


  # GET /cposts
  # GET /cposts.json
  def index
    @cposts = @cfolder.cposts.all
  end

  # GET /cposts/1
  # GET /cposts/1.json
  def show
  end

  # GET /cposts/new
  def new
    @cpost = @cfolder.cposts.new
  end

  # GET /cposts/1/edit
  def edit
  end

  # POST /cposts
  # POST /cposts.json
  def create
    @cpost = @cfolder.cposts.new(cpost_params)

    respond_to do |format|
      if @cpost.save
        format.html { redirect_to [@course, @cfolder], notice: 'Cpost was successfully created.' }
        # TODO
        # format.json { render :show, status: :created, location: [@course, @cfolder, @cpost] }
      else
        # format.html { render :new }
        # format.json { render json: @cpost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cposts/1
  # PATCH/PUT /cposts/1.json
  def update
    respond_to do |format|
      if @cpost.update(cpost_params)
        format.html { redirect_to [@course, @cfolder], notice: 'Cpost was successfully updated.' }
        # TODO
        # format.json { render :show, status: :ok, location: [@course, @cfolder, @cpost] }
      else
        # format.html { render :edit }
        # format.json { render json: @cpost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cposts/1
  # DELETE /cposts/1.json
  def destroy
    @cpost.destroy
    respond_to do |format|
      format.html { redirect_to course_cfolder_path(@course, @cfolder), notice: 'Cpost was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cpost
      @cpost = @cfolder.cposts.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cpost_params
      params.require(:cpost).permit(:title, :body, :link)
    end

    def load_course
      @course = Course.find(params[:course_id])
    end

    def load_cfolder
      @cfolder = @course.cfolders.find(params[:cfolder_id])
    end

  def not_available
    redirect_to course_path(@course)
  end

  def is_owner
      unless current_user.id == Course.find(params[:course_id]).professor_id || admin?
        redirect_to courses_path
      end
  end


end
