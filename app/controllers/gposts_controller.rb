class GpostsController < ApplicationController

  before_action :load_group, :load_gfolder
  before_action :set_gpost, only: [:show, :edit, :update, :destroy]

  skip_before_action :require_login, :require_admin, :require_coordinator
  before_action :require_professor, only: [:create, :destroy]
  before_action :not_available, except: [:create, :destroy]
  before_action :is_owner



  # GET /gposts
  # GET /gposts.json
  def index
    @gposts = @gfolder.gposts.all
  end

  # GET /gposts/1
  # GET /gposts/1.json
  def show
  end

  # GET /gposts/new
  def new
    @gpost = @gfolder.gposts.new
  end

  # GET /gposts/1/edit
  def edit
  end

  # POST /gposts
  # POST /gposts.json
  def create
    @gpost = @gfolder.gposts.new(gpost_params)

    respond_to do |format|
      if @gpost.save
        format.html { redirect_to [@group, @gfolder], notice: 'gpost was successfully created.' }
        # TODO
        # format.json { render :show, status: :created, location: [@group, @gfolder] }
      else
        # format.html { render :new }
        # format.json { render json: @gpost.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /gposts/1
  # PATCH/PUT /gposts/1.json
  def update
    respond_to do |format|
      if @gpost.update(gpost_params)
        format.html { redirect_to [@group, @gfolder], notice: 'gpost was successfully updated.' }
        # TODO
        # format.json { render :show, status: :ok, location: [@course, @group, @gfolder, @gpost] }
      else
        # format.html { render :edit }
        # format.json { render json: @gpost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gposts/1
  # DELETE /gposts/1.json
  def destroy
    @gpost.destroy
    respond_to do |format|
      format.html { redirect_to group_gfolder_path(@group, @gfolder), notice: 'gpost was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_gpost
    @gpost = @gfolder.gposts.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def gpost_params
    params.require(:gpost).permit(:title, :body, :link)
  end


  def load_group
    @group = Group.find(params[:group_id])
  end

  def load_gfolder
    @gfolder = @group.gfolders.find(params[:gfolder_id])
  end

  def not_available
    redirect_to group_path(@group)
  end

  def is_owner
    unless current_user.id == Course.find(params[:course_id]).professor_id || admin?
      redirect_to courses_path
    end
  end

end
