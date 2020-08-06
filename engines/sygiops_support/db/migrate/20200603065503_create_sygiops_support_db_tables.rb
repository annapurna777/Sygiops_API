class CreateSygiopsSupportDbTables < ActiveRecord::Migration[5.2]
  def change
    create_table :sygiops_support_users do |t|


      t.string :login,                limit: 255, null: false
      t.string :firstname,            limit: 100, null: true, default: ''
      t.string :lastname,             limit: 100, null: true, default: ''
      t.string :email,                limit: 255, null: true, default: ''
      t.string :image,                limit: 100, null: true
      t.string :image_source,         limit: 200, null: true
      t.string :web,                  limit: 100, null: true, default: ''
      t.string :password,             limit: 100, null: true
      t.string :phone,                limit: 100, null: true, default: ''
      t.string :fax,                  limit: 100, null: true, default: ''
      t.string :mobile,               limit: 100, null: true, default: ''
      t.string :department,           limit: 200, null: true, default: ''
      t.string :street,               limit: 120, null: true, default: ''
      t.string :zip,                  limit: 100, null: true, default: ''
      t.string :city,                 limit: 100, null: true, default: ''
      t.string :country,              limit: 100, null: true, default: ''
      t.string :address,              limit: 500, null: true, default: ''
      t.boolean :vip,                                         default: false
      t.boolean :verified,                        null: false, default: false
      t.boolean :active,                          null: false, default: true
      t.string :note,                 limit: 5000, null: true, default: ''
      t.timestamp :last_login,        limit: 3,   null: true
      t.string :source,               limit: 200, null: true
      t.integer :login_failed,                    null: false, default: 0
      t.boolean :out_of_office,                   null: false, default: false
      t.date :out_of_office_start_at,             null: true
      t.date :out_of_office_end_at,               null: true
      t.integer :out_of_office_replacement_id,    null: true
      t.string :preferences,          limit: 8000, null: true


      t.timestamps limit: 3, null: false
    end

    create_table :sygiops_support_schedulers do |t|

      t.string :name,                     limit: 250,   null: false
      t.string :method,                   limit: 250,   null: false
      t.integer :period,                                null: true
      t.integer :running,                               null: false, default: false
      t.timestamp :last_run,              limit: 3,     null: true
      t.integer :prio,                                  null: false
      t.string :pid,                      limit: 250,   null: true
      t.string :note,                     limit: 250,   null: true
      t.string :error_message,                          null: true
      t.string :status,                                 null: true
      t.boolean :active,                                null: false, default: false

      t.timestamps
    end

    create_table :sygiops_support_groups do |t|

      t.integer :signature_id,                      null: true
      t.integer :email_address_id,                  null: true
      t.string :name,                   limit: 160, null: false
      t.integer :assignment_timeout,                null: true
      t.string :follow_up_possible,     limit: 100, null: false, default: 'yes'
      t.boolean :follow_up_assignment,              null: false, default: true
      t.boolean :active,                            null: false, default: true
      t.string :note,                   limit: 250, null: true
      t.boolean :default_create                                 , default: false

      t.timestamps
    end

    create_table :sygiops_support_channels do |t|

      t.column :active,         :boolean,              null: false, default: true
      t.column :preferences,    :string, limit: 2000,  null: true
      t.column :last_log_in,    :text,   limit: 500.kilobytes + 1, null: true
      t.column :last_log_out,   :text,   limit: 500.kilobytes + 1, null: true
      t.column :status_in,      :string, limit: 100,   null: true
      t.column :status_out,     :string, limit: 100,   null: true
      t.column :area,           :string, limit: 2000,  null: true
      t.column :options,        :string, limit: 2000,  null: true

      t.timestamps
    end

    create_table :sygiops_support_settings do |t|
      t.string :title,                  limit: 200,  null: false
      t.string :name,                   limit: 200,  null: false
      t.string :area,                   limit: 100,  null: false
      t.string :description,            limit: 2000, null: false
      t.string :options,                limit: 2000, null: true
      t.boolean :state
      t.text :state_current,            limit: 200.kilobytes + 1, null: true
      t.string :state_initial,          limit: 2000, null: true
      t.boolean :frontend,                           null: false
      t.text :preferences,              limit: 200.kilobytes + 1, null: true

      t.timestamps
    end

    create_table :sygiops_support_email_addresses do |t|
      t.integer :channel_id,                        null: true
      t.string  :realname,             limit: 250,  null: false
      t.string  :email,                limit: 250,  null: false
      t.boolean :active,                            null: false, default: true
      t.string  :note,                 limit: 250,  null: true
      t.string  :preferences,          limit: 2000, null: true
      t.timestamps limit: 3, null: false

      t.timestamps
    end

    create_table :sygiops_support_roles do |t|
      t.string :name,                   limit: 100, null: false
      t.text   :preferences,            limit: 500.kilobytes + 1, null: true
      t.boolean :default_create,                 null: true, default: false
      t.boolean :active,                            null: false, default: true
      t.string :note,                   limit: 250, null: true
      t.timestamps limit: 3, null: false
    end

    create_table :sygiops_support_ticket_states do |t|
      t.column :name,                 :string, limit: 250,  null: false
      t.column :next_state_id,        :integer,             null: true
      t.column :ignore_escalation,    :boolean,             null: false, default: false
      t.column :default_create,       :boolean,             null: false, default: false
      t.column :default_follow_up,    :boolean,             null: false, default: false
      t.column :note,                 :string, limit: 250,  null: true
      t.column :active,               :boolean,             null: false, default: true
      t.timestamps limit: 3, null: false
    end

    create_table :sygiops_support_ticket_priorities do |t|
      t.column :name,                 :string, limit: 250, null: false
      t.column :default_create,       :boolean,            null: false, default: false
      t.column :ui_icon,              :string, limit: 100, null: true
      t.column :ui_color,             :string, limit: 100, null: true
      t.column :note,                 :string, limit: 250, null: true
      t.column :active,               :boolean,            null: false, default: true
      t.timestamps limit: 3, null: false
    end

    create_table :sygiops_support_tickets do |t|
      t.integer :group_id,                                                null: true
      t.integer :priority_id,                                             null: true
      t.integer :state_id,                                                null: true
      t.integer :organization_id,                                         null: true
      t.column :number,                           :string,    limit: 60,  null: false
      t.column :title,                            :string,    limit: 250, null: false
      t.column :owner_id,                         :integer,               null: false
      t.column :customer_id,                      :integer,               null: false
      t.column :note,                             :string,    limit: 250, null: true
      t.column :first_response_at,                :timestamp, limit: 3,   null: true
      t.column :first_response_escalation_at,     :timestamp, limit: 3,   null: true
      t.column :first_response_in_min,            :integer,               null: true
      t.column :first_response_diff_in_min,       :integer,               null: true
      t.column :close_at,                         :timestamp, limit: 3,   null: true
      t.column :close_escalation_at,              :timestamp, limit: 3,   null: true
      t.column :close_in_min,                     :integer,               null: true
      t.column :close_diff_in_min,                :integer,               null: true
      t.column :update_escalation_at,             :timestamp, limit: 3,   null: true
      t.column :update_in_min,                    :integer,               null: true
      t.column :update_diff_in_min,               :integer,               null: true
      t.column :last_contact_at,                  :timestamp, limit: 3,   null: true
      t.column :last_contact_agent_at,            :timestamp, limit: 3,   null: true
      t.column :last_contact_customer_at,         :timestamp, limit: 3,   null: true
      t.column :last_owner_update_at,             :timestamp, limit: 3,   null: true
      t.column :create_article_type_id,           :integer,               null: true
      t.column :create_article_sender_id,         :integer,               null: true
      t.column :article_count,                    :integer,               null: true
      t.column :escalation_at,                    :timestamp, limit: 3,   null: true
      t.column :pending_time,                     :timestamp, limit: 3,   null: true
      t.column :type_id,                          :integer,               null: true
      t.column :time_unit,                        :decimal, precision: 6, scale: 2, null: true
      t.column :preferences,                      :text,      limit: 500.kilobytes + 1, null: true
      t.timestamps limit: 3, null: false
    end

    create_table :sygiops_support_ticket_flags do |t|
      t.integer :ticket_id,                          null: false
      t.column :key,            :string, limit: 50,  null: false
      t.column :value,          :string, limit: 50,  null: true
      t.timestamps limit: 3, null: false
    end

    create_table :sygiops_support_ticket_article_types do |t|
      t.column :name,                 :string, limit: 250, null: false
      t.column :note,                 :string, limit: 250, null: true
      t.column :communication,        :boolean,            null: false
      t.column :active,               :boolean,            null: false, default: true
      t.timestamps limit: 3, null: false
    end

    create_table :sygiops_support_ticket_article_senders do |t|
      t.column :name,                 :string, limit: 250, null: false
      t.column :note,                 :string, limit: 250, null: true
      t.timestamps limit: 3, null: false
    end

    create_table :sygiops_support_ticket_articles do |t|
      t.integer :ticket_id,                                    null: false
      t.integer :type_id,                                      null: false
      t.integer :sender_id,                                    null: false
      t.column :from,                 :string, limit: 3000,    null: true
      t.column :to,                   :string, limit: 3000,    null: true
      t.column :cc,                   :string, limit: 3000,    null: true
      t.column :subject,              :string, limit: 3000,    null: true
      t.column :reply_to,             :string, limit: 300,     null: true
      t.column :message_id,           :string, limit: 3000,    null: true
      t.column :message_id_md5,       :string, limit: 32,      null: true
      t.column :in_reply_to,          :string, limit: 3000,    null: true
      t.column :content_type,         :string, limit: 20,      null: false, default: 'text/plain'
      t.column :references,           :string, limit: 3200,    null: true
      t.column :body,                 :text,   limit: 20.megabytes + 1, null: false
      t.column :internal,             :boolean,                null: false, default: false
      t.column :preferences,          :text,   limit: 500.kilobytes + 1, null: true
      t.column :origin_by_id,         :integer
      t.timestamps limit: 3, null: false
    end

    create_table :sygiops_support_ticket_article_flags do |t|
      t.integer :ticket_article_id,                      null: false
      t.column :key,                 :string, limit: 50, null: false
      t.column :value,               :string, limit: 50, null: true
      t.timestamps limit: 3,  null: false
    end

    create_table :sygiops_support_ticket_time_accountings do |t|
      t.integer :ticket_id,                                       null: false
      t.integer :ticket_article_id,                               null: true
      t.column :time_unit,      :decimal, precision: 6, scale: 2, null: false
      t.timestamps limit: 3, null: false
    end

    create_table :sygiops_support_overviews do |t|
      t.column :name,                 :string,  limit: 250,    null: false
      t.column :link,                 :string,  limit: 250,    null: false
      t.column :prio,                 :integer,                null: false
      t.column :condition,            :text, limit: 500.kilobytes + 1, null: false
      t.column :order,                :string,  limit: 2500,   null: false
      t.column :group_by,             :string,  limit: 250,    null: true
      t.column :group_direction,      :string,  limit: 250,    null: true
      t.column :organization_shared,  :boolean,                null: false, default: false
      t.column :out_of_office,        :boolean,                null: false, default: false
      t.column :view,                 :string,  limit: 1000,   null: false
      t.column :active,               :boolean,                null: false, default: true
      t.timestamps limit: 3, null: false
    end

    create_table :sygiops_support_overviews_roles, id: false do |t|
      t.integer :overview_id
      t.integer :role_id
    end


    create_table :sygiops_support_overviews_users, id: false do |t|
      t.integer :overview_id
      t.integer :user_id
    end


    create_table :sygiops_support_overviews_groups, id: false do |t|
      t.integer :overview_id
      t.integer :group_id
    end

    create_table :sygiops_support_notifications do |t|
      t.column :subject,      :string, limit: 250,   null: false
      t.column :body,         :string, limit: 8000,  null: false
      t.column :content_type, :string, limit: 250,   null: false
      t.column :active,       :boolean,              null: false, default: true
      t.column :note,         :string, limit: 250,   null: true
      t.timestamps limit: 3, null: false
    end

    create_table :sygiops_support_slas do |t|
      t.integer :calendar_id,                                   null: false
      t.column :name,                 :string, limit: 150,      null: true
      t.column :first_response_time,  :integer,                 null: true
      t.column :update_time,          :integer,                 null: true
      t.column :solution_time,        :integer,                 null: true
      t.column :condition,            :text, limit: 500.kilobytes + 1, null: true
      t.timestamps limit: 3, null: false
    end

    create_table :sygiops_support_store_objects do |t|
      t.string :name,               limit: 250, null: false
      t.string :note,               limit: 250, null: true
      t.timestamps limit: 3, null: false
    end

    create_table :sygiops_support_store_files do |t|
      t.string :sha,                limit: 128, null: false
      t.string :provider,           limit: 20,  null: true
      t.timestamps limit: 3, null: false
    end

    create_table :sygiops_support_stores do |t|
      t.integer :store_object_id,               null: false
      t.integer :store_file_id,                 null: false
      t.integer :o_id,              limit: 8,   null: false
      t.string :preferences,        limit: 2500, null: true
      t.string :size,               limit: 50,  null: true
      t.string :filename,           limit: 250, null: false
      t.timestamps limit: 3, null: false
    end

    create_table :sygiops_support_store_provider_dbs do |t|
      t.string :sha,                limit: 128,            null: false
      t.binary :data,               limit: 200.megabytes,  null: true
      t.timestamps limit: 3, null: false
    end

    create_table :sygiops_support_ticket_types do |t|
      t.string :name
      t.string :note
      t.boolean :default_create , null: false, default: false

      t.timestamps
    end

    create_table :sygiops_support_calendars do |t|
      t.string  :name,                   limit: 250,  null: true
      t.string  :timezone,               limit: 250,  null: true
      t.string  :business_hours,         limit: 3000, null: true
      t.boolean :default_create,                             null: false, default: false
      t.string  :ical_url,               limit: 500,  null: true
      t.text    :public_holidays,        limit: 500.kilobytes + 1, null: true
      t.text    :last_log,               limit: 500.kilobytes + 1, null: true
      t.timestamp :last_sync,            limit: 3,    null: true

      t.timestamps
    end

    create_table :sygiops_support_signatures do |t|
      t.string :name,                 limit: 100,  null: false
      t.text :body,                   limit: 10.megabytes + 1, null: true
      t.boolean :active,                           null: false, default: true
      t.string :note,                 limit: 250,  null: true

      t.timestamps
    end

    create_table :sygiops_support_organizations do |t|
      t.string :name,                   limit: 100, null: false
      t.boolean :shared,                            null: false, default: true
      t.string :domain,                 limit: 250, null: true,  default: ''
      t.boolean :domain_assignment,                 null: false, default: false
      t.boolean :active,                            null: false, default: true
      t.string :note,                   limit: 5000, null: true,  default: ''

      t.timestamps
    end

    create_table :sygiops_support_import_jobs do |t|

      t.string :name, limit: 250, null: false
      t.boolean :dry_run, default: false
      t.text :payload, limit: 80_000
      t.text :result, limit: 80_000
      t.datetime :started_at
      t.datetime :finished_at

      t.timestamps
    end

    add_column :sygiops_support_users, :organization_id, :integer,null: true
    add_column :sygiops_support_users, :role_id, :integer,null: false
    add_foreign_key :sygiops_support_tickets, :sygiops_support_groups , column: :group_id
    add_foreign_key :sygiops_support_tickets, :sygiops_support_users, column: :owner_id
    add_foreign_key :sygiops_support_tickets, :sygiops_support_users, column: :customer_id
    add_foreign_key :sygiops_support_tickets, :sygiops_support_ticket_priorities, column: :priority_id
    add_foreign_key :sygiops_support_tickets, :sygiops_support_ticket_states, column: :state_id
    add_foreign_key :sygiops_support_tickets, :sygiops_support_ticket_types, column: :type_id
    add_foreign_key :sygiops_support_ticket_flags, :sygiops_support_tickets, column: :ticket_id
    add_foreign_key :sygiops_support_ticket_articles, :sygiops_support_tickets , column: :ticket_id
    add_foreign_key :sygiops_support_ticket_articles, :sygiops_support_ticket_article_types, column: :type_id
    add_foreign_key :sygiops_support_ticket_articles, :sygiops_support_ticket_article_senders, column: :sender_id
    add_foreign_key :sygiops_support_ticket_articles, :sygiops_support_users, column: :origin_by_id
    add_foreign_key :sygiops_support_ticket_article_flags, :sygiops_support_ticket_articles, column: :ticket_article_id
    add_foreign_key :sygiops_support_ticket_time_accountings, :sygiops_support_tickets , column: :ticket_id
    add_foreign_key :sygiops_support_ticket_time_accountings, :sygiops_support_ticket_articles , column: :ticket_article_id
    add_foreign_key :sygiops_support_overviews_roles, :sygiops_support_overviews , column: :overview_id
    add_foreign_key :sygiops_support_overviews_roles, :sygiops_support_roles , column: :role_id
    add_foreign_key :sygiops_support_overviews_users, :sygiops_support_overviews , column: :overview_id
    add_foreign_key :sygiops_support_overviews_users, :sygiops_support_users , column: :user_id
    add_foreign_key :sygiops_support_overviews_groups, :sygiops_support_overviews , column: :overview_id
    add_foreign_key :sygiops_support_overviews_groups, :sygiops_support_groups , column: :group_id
    add_foreign_key :sygiops_support_stores, :sygiops_support_store_objects, column: :store_object_id
    add_foreign_key :sygiops_support_stores, :sygiops_support_store_files, column: :store_file_id
    add_foreign_key :sygiops_support_users, :sygiops_support_roles, column: :role_id
    add_foreign_key :sygiops_support_groups, :sygiops_support_signatures, column: :signature_id
    add_foreign_key :sygiops_support_users, :sygiops_support_organizations, column: :organization_id
    add_column :sygiops_support_organizations, :timezone_name, :string
    add_column :sygiops_support_organizations, :sla_id, :integer
    add_foreign_key :sygiops_support_organizations, :sygiops_support_slas, column: :sla_id
    add_foreign_key :sygiops_support_slas, :sygiops_support_calendars, column: :calendar_id
    add_column :sygiops_support_slas, :default_create, :boolean ,default: false
    add_column :sygiops_support_tickets, :response_warning, :boolean ,default: false
    add_column :sygiops_support_tickets, :resolution_warning, :boolean ,default: false
    add_column :sygiops_support_tickets, :response_breach, :boolean ,default: false
    add_column :sygiops_support_tickets, :resolution_breach, :boolean ,default: false

  end

end
