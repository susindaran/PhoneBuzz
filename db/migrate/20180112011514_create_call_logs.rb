class CreateCallLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :call_logs do |t|
      t.string :number
      t.string :delay
      t.string :digits

      t.timestamps
    end
  end
end
