class CreateMaterialLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :material_logs do |t|
      t.references :user, foreign_key: true
      t.references :material, foreign_key: true
      t.integer :amount
      t.string :action

      t.timestamps
    end
  end
end
