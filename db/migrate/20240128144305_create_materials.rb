class CreateMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :materials do |t|
      t.string :name
      t.integer :quantity
      t.boolean :was_manual_updated

      t.timestamps
    end

    execute <<-SQL
      CREATE UNIQUE INDEX index_materials_on_lower_name ON materials (LOWER(name));
    SQL
  end
end
