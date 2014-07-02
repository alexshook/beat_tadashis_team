class AddCompanyIdToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :company_id, :integer
  end
end
