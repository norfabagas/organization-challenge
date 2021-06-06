class CreateOrganizations < ActiveRecord::Migration[6.1]
  def change
    create_table :organizations do |t|
      t.string  :name, nullable: false, default: ""
      t.string  :phone, nullable: false, default: ""
      t.string  :email, nullable: false, default: ""
      t.string  :website, nullable: false, default: ""

      t.timestamps
    end
  end
end
