class StudentSectionsController < ApplicationController
  before_action :set_student_section, only: [:destroy]
  before_action :set_student, only: [:new, :create]

  def new
    @student_section = StudentSection.new
  end

  def create
    @student_section = StudentSection.new(student_section_params)
    if @student_section.save
      flash[:notice] = 'Section was successfully added'
    else
      render :new
    end
  end

  def destroy
    @student_section.destroy
    flash[:notice] = 'Class was successfully removed'
  end

  private

  def set_student_section
    @student_section = StudentSection.find(params[:id])
  end

  def set_student
    @student = Student.find(params[:student_id])
  end

  def student_section_params
    params.require(:student_section).permit(:section_id, :student_id)
  end
end
