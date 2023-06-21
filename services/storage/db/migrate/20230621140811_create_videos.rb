class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos, id: :uuid do |t|
      t.text :name
      t.text :description
      t.text :type
      t.uuid :author
      t.uuid :subscribers, array: true, default: []
      t.jsonb :rules, array: true, default: []
      t.timestamps
    end
  end
end
