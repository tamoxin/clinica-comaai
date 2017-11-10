class GroupsController < ApplicationController

  before_action :set_group, only: [:show, :edit, :update, :destroy]

  skip_before_action :require_admin, :require_professor, :require_coordinator
  before_action :require_coordinator, only: [:new, :update, :create]
  before_action :coord_or_prof_or_stud, only: [:index, :show]
  before_action :coord_or_prof, only: [:edit]
  before_action :not_available, only: [:destroy]
  before_action :is_owner, except: [:index]


  # GET /groups
  # GET /groups.json
  def index
    if coordinator? || admin?
      @groups = Group.all
    elsif professor?
      @groups = Group.where(course_id: Course.where(professor_id: current_user.id).all.ids ).all
    elsif student?
       @groups = User.find(current_user.id).groups.references( :students ).where( students: { user_id: current_user.id })

    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  end


  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create

    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save

        @course = Course.find([@group.course_id]).first

        @course.cfolders.each do |cfolder|
          gfolder = @group.gfolders.create(name: cfolder.name, group_id: @group.id)
          cfolder.cposts.each do |cpost|
            gpost = gfolder.gposts.create(title: cpost.id, body: cpost.body, link: cpost.link, gfolder_id: gfolder.id)
          end
        end

        format.html { redirect_to [@group], notice: 'group was successfully created.' }
        format.json { render :show, status: :created, location: [@group] }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to [@group], notice: 'group was successfully updated.' }
        format.json { render :show, status: :ok, location: [@group] }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_path, notice: 'group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:code, :name, :description, :startDate, :endDate, :active, :course_id)
    end

  def coord_or_prof
    unless coordinator? || professor? || admin?
      redirect_to root_path
    end
  end

  def coord_or_prof_or_stud
    unless coordinator? || professor? || student? || admin?
      redirect_to root_path
    end
  end

  def is_owner
    unless coordinator? || admin?
      if professor? && current_user.id != Group.find(params[:id]).course.professor_id
          redirect_to courses_path
      elsif student? && Group.find(params[:id]).students.where(user_id: current_user.id) == nil
        redirect_to courses_path
      end

    end
  end

end
