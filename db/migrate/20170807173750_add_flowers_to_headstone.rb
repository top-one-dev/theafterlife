class AddFlowersToHeadstone < ActiveRecord::Migration[5.1]
  def change
    add_column :headstones, :flowers, :text
  end
end
