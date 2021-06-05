class CreateConfigurations < ActiveRecord::Migration[6.1]
  def change
    create_table :configurations do |t|
      t.belongs_to  :user, foreign_key: true
      t.string :theme, null: false, default: 'default'
      t.string :locale, null: false, default: 'en'
      t.timestamps
    end
  end
end
