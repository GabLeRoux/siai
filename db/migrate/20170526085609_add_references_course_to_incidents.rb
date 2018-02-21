class AddReferencesStudent::CourseToStudent::Incidents < ActiveRecord::Migration[5.0]
  def change
    add_reference :incidents, :course, foreign_key: true, index: true
  end
end
