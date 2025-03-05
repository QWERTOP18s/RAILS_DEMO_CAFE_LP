class AddContentEnToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :content_en, :text
  end
end
