class CreateSchema < ActiveRecord::Migration
  def change
    
    create_table :kgg_groupings do |t|
      t.string  :shortname, :null => false
      t.string  :name
      t.text    :description
      t.jsonb   :groupings,  null: false, default: '{}'
      t.jsonb   :attributes, null: false, default: '{}'
    end
    add_index :kgg_groupings, :shortname, :unique => true
    add_index :kgg_groupings, :name  
    add_index :kgg_groupings, :groupings, :using => :gin
    add_index :kgg_groupings, :attributes, :using => :gin

    
    create_table :kgg_attributes do |t|
      t.string  :shortname, :null => false
      t.string  :datatype, :null => false # must be a valid json datatype
      t.string  :name
      t.text    :description
    end
    add_index :kgg_attributes, :shortname, :unique => true
    add_index :kgg_attributes, :datatype
    add_index :kgg_attributes, :name
    
    
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""
    
      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
    
      ## Rememberable
      t.datetime :remember_created_at
    
      ## Trackable
      t.integer  :sign_in_count, :default => 0, :null => false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
    
      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable
    
      ## Lockable
      t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at
    
      ## Token authenticatable
      t.string   :authentication_token
    
      ## Custom:
      t.string   :username
      t.string   :phone
      t.boolean  :admin,                    :default => false
      t.string   :firstname
      t.string   :lastname
      t.string   :initial
      t.date     :birthdate
      t.boolean  :is_enabled
      t.boolean  :is_valid
      t.boolean  :is_test
      t.jsonb    :groupings,  null: false, default: '{}'
      t.jsonb    :attributes, null: false, default: '{}'
      
      t.timestamps
    end
    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :confirmation_token,   :unique => true
    add_index :users, :unlock_token,         :unique => true
    add_index :users, :authentication_token, :unique => true
    add_index :users, :username,             :unique => true
    add_index :users, :encrypted_password
    add_index :users, :sign_in_count
    add_index :users, :current_sign_in_ip
    add_index :users, :last_sign_in_ip
    add_index :users, :unconfirmed_email
    add_index :users, :failed_attempts
    add_index :users, :phone
    add_index :users, :admin
    add_index :users, :firstname
    add_index :users, :lastname
    add_index :users, :initial
    add_index :users, :birthdate
    add_index :users, :is_enabled
    add_index :users, :is_valid
    add_index :users, :is_test
    add_index :users, :groupings,  :using => :gin
    add_index :users, :attributes, :using => :gin
    
    
    create_table :kg_gallery_objects do |t|
      t.references :object_type, :null => false
      t.string     :shortname, :unique => true
      t.string     :name
      t.text       :description
      t.references :file
      t.references :author
      t.text       :note
      t.jsonb      :groupings,  null: false, default: '{}'
      t.jsonb      :attributes, null: false, default: '{}'
      
      t.timestamps
    end
    add_index :kg_gallery_objects, :shortname
    add_index :kg_gallery_objects, :name
    add_index :kg_gallery_objects, :description
    add_index :kg_gallery_objects, :groupings,  :using => :gin
    add_index :kg_gallery_objects, :attributes, :using => :gin

    
    create_table :kg_gallery_files do |t|
      t.attachment :file
      t.string     :shortname
      t.string     :original_filename
      t.string     :filetype
      t.string     :version
      t.string     :name
      t.text       :description
      t.text       :url
      t.text       :note
      t.datetime   :creation_date
      t.hstore     :exif
      
      t.timestamps
    end
    add_index :kg_gallery_files, :shortname, :name => :kggf_shortname
    add_index :kg_gallery_files, :original_filename, :name => :kggf_original_filename
    add_index :kg_gallery_files, :filetype, :name => :kggf_filetype
    add_index :kg_gallery_files, :version, :name => :kggf_version
    add_index :kg_gallery_files, :name, :name => :kggf_name
    add_index :kg_gallery_files, :description, :name => :kggf_description
    add_index :kg_gallery_files, :url, :name => :kggf_url
    add_index :kg_gallery_files, :creation_date, :name => :kggf_creation_date
    
    
  end
end
