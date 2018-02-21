class Students::CoursesController < ApplicationController
  include ParamsSearch

  load_and_authorize_resource class: "Student::Course"

  before_action :set_course, only: [:edit, :destroy, :update]
  add_breadcrumb "Home", :root_path

  def index
    add_breadcrumb "DIREN", sector_actions_path('diren')
    add_breadcrumb "Cursos"

    @courses = Student::Course.order("#{set_order}": :desc)
                     .search(params[:search])
                     .page(params[:page]).per(set_amount_return)
  end

  def new
    add_breadcrumb "DIREN", sector_actions_path('diren')
    add_breadcrumb "Cursos", :students_courses_path
    add_breadcrumb "Novo curso"

    @course = Student::Course.new
  end

  def create
    @courses = Student::Course.new(course_params)
    if @courses.save
      redirect_to students_courses_path, flash: { success: 'Curso cadastro com sucesso' }
    else
      flash.now[:error] = @courses.errors.full_messages
      render :new
    end
  end

  def edit
    add_breadcrumb "DIREN", sector_actions_path('diren')
    add_breadcrumb "Cursos", :students_courses_path
    add_breadcrumb "Atualizar curso"
  end

  def update
    if @courses.update(course_params)
      redirect_to students_courses_path, flash: { success: 'Curso atualizado com sucesso' }
    else
      flash.now[:error] = @courses.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @courses.destroy
      flash[:success] = "Curso deletado com sucesso"
      redirect_back(fallback_location: students_courses_path)
    else
      flash.now[:error] = @courses.errors.full_messages
      render :new
    end
  end

  private

  def set_course
    @courses = Student::Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :initial)
  end
end
