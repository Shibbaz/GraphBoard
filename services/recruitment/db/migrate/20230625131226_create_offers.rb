class CreateOffers < ActiveRecord::Migration[7.0]
  def change
    create_table :offers, id: :uuid do |t|
      t.text :name
      t.text :description
      t.json :requirements, array: true
      t.uuid :tags, array: true
      t.uuid :author
      t.json :contact_details

      t.timestamps
    end
  end
end
