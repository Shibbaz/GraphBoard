class CreateTechnologyTags < ActiveRecord::Migration[7.0]
  def change
    create_table :technology_tags, id: :uuid do |t|
      t.text :name
    end
  end
end
