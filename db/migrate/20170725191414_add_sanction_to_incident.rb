class AddSanctionToStudent::Incident < ActiveRecord::Migration[5.1]
  def change
    add_column :incidents, :sanction, :integer
  end
end
