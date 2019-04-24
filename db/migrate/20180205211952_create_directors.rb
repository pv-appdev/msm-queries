class CreateDirectors < ActiveRecord::Migration[5.1]
  def change
    create_table :directors do |t|
      t.date :dob
      t.string :name
      t.text :bio
      t.string :image_url

      t.timestamps
    end
  end
end
