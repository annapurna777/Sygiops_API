class CreateSygiopsSupportTicketCounters < ActiveRecord::Migration[5.2]
  def change
    create_table :sygiops_support_ticket_counters do |t|
      t.column :content,              :string, limit: 100, null: false
      t.column :generator,            :string, limit: 100, null: false
    end
  end
end
