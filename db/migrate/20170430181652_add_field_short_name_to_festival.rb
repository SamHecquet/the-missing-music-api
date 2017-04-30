class AddFieldShortNameToFestival < ActiveRecord::Migration[5.0]
  def change
    add_column :festivals, :short_name, :string, after: :name
    add_index :festivals, :short_name
  end
end
