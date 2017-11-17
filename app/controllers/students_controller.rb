class StudentsController < ApplicationController

  before_action :load_group
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :not_available, except: [:index, :create, :destroy]
  skip_before_action :require_login, :require_admin, :require_professor
  before_action :require_coordinator, only: [:index, :create, :destroy]

  def new
  end

  def index
    @students = @group.students.all
  end

  def show
  end

  def update
  end

  # POST /students
  # POST /students.json
  def create
    @student = @group.students.new(student_params)
    respond_to do |format|
      if @student.save
        format.html { redirect_to group_students_path(@group), notice: 'Student was successfully created.' }
      else
        format.html { redirect_to group_students_path(@group), notice: "Student couldn't be created" }
      end
    end
  end


  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to group_students_path(@group), notice: 'Student was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = @group.students.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:user_id)
    end

  def load_group
    @group = Group.find(params[:group_id])
  end

  def not_available
    redirect_to group_students_path(@group)
  end
end
