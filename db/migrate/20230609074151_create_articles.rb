class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title

      # forgot to add description gemerate another migration
      # t.text :description

      t.timestamps
    end
  end
end
