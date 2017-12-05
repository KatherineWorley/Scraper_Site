class AddCategoryIdToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :category_id, :integer
  end
end
