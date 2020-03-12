class ChangeTypeToCategoryType < ActiveRecord::Migration[6.0]
  def change
    rename_column :categories, :type, :category_type
  end
end
