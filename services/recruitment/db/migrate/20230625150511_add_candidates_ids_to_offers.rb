class AddCandidatesIdsToOffers < ActiveRecord::Migration[7.0]
  def change
    add_column :offers, :candidates, :uuid, array: true, default: [], null: false
  end
end
