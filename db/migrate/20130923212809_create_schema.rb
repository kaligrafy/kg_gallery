class CreateSchema < ActiveRecord::Migration
  def change
    
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :email             , :null => false, :default => ""
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
      t.boolean  :admin, :default => false
      t.string   :firstname
      t.string   :lastname
      t.string   :initial
      t.date     :birthdate
      t.boolean  :is_enabled
      t.boolean  :is_valid
      t.boolean  :is_test
      t.jsonb    :groupings , :null => false, :default => '{}'
      t.jsonb    :attributes, :null => false, :default => '{}'
      t.timestamps
    end
    add_index :users, :email               , :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :confirmation_token  , :unique => true
    add_index :users, :unlock_token        , :unique => true
    add_index :users, :authentication_token, :unique => true
    add_index :users, :username            , :unique => true
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
    add_index :users, :groupings           , :using => :gin
    add_index :users, :attributes          , :using => :gin

    create_table :kgg_groupings do |t|
      t.string  :shortname  , :null => false
      t.string  :name
      t.text    :description
      t.jsonb   :groupings  , :null => false, :default => '{}'
      t.jsonb   :attributes , :null => false, :default => '{}'
    end
    add_index :kgg_groupings, :shortname  , :name => :idx_kggg_shortname  , :unique => true
    add_index :kgg_groupings, :name       , :name => :idx_kggg_name
    add_index :kgg_groupings, :description, :name => :idx_kggg_description
    add_index :kgg_groupings, :groupings  , :name => :idx_kggg_groupings  , :using => :gin
    add_index :kgg_groupings, :attributes , :name => :idx_kggg_attributes , :using => :gin
    
    create_table :kgg_grouping_choices do |t|
      t.string  :shortname  , :null => false
      t.string  :name
      t.text    :description
      t.integer :grouping_id, :null => false
      t.jsonb   :groupings  , :null => false, :default => '{}'
      t.jsonb   :attributes , :null => false, :default => '{}'
    end
    add_index :kgg_grouping_choices, :shortname  , :name => :idx_kgggc_shortname  , :unique => true
    add_index :kgg_grouping_choices, :name       , :name => :idx_kgggc_name
    add_index :kgg_grouping_choices, :description, :name => :idx_kgggc_description
    add_index :kgg_grouping_choices, :groupings  , :name => :idx_kgggc_groupings  , :using => :gin
    add_index :kgg_grouping_choices, :attributes , :name => :idx_kgggc_attributes , :using => :gin
    add_foreign_key :kgg_grouping_choices, :kgg_groupings, :name => :fk_kgggc_groupings, :column => :grouping_id

    
    create_table :kgg_attributes do |t|
      t.string  :shortname  , :null => false
      t.string  :name
      t.text    :description
      t.string  :datatype   , :null => false
      t.string  :units
      t.string  :format
    end
    add_index :kgg_attributes, :shortname  , :name => :idx_kgga_shortname  , :unique => true
    add_index :kgg_attributes, :name       , :name => :idx_kgga_name
    add_index :kgg_attributes, :description, :name => :idx_kgga_description
    add_index :kgg_attributes, :units      , :name => :idx_kgga_units
    add_index :kgg_attributes, :format     , :name => :idx_kgga_format
    add_index :kgg_attributes, :datatype   , :name => :idx_kgga_datatype

    create_table :kgg_files do |t|
      t.string     :shortname
      t.string     :name
      t.text       :description
      t.attachment :media
      t.string     :original_filename
      t.string     :filetype
      t.string     :version
      t.text       :url
      t.text       :note
      t.jsonb      :exif             , :null => false, :default => '{}'
      t.timestamps
    end
    add_index :kgg_files, :shortname         , :name => :idx_kggf_shortname
    add_index :kgg_files, :name              , :name => :idx_kggf_name
    add_index :kgg_files, :description       , :name => :idx_kggf_description
    add_index :kgg_files, :media_file_name   , :name => :idx_kggf_media_file_name
    add_index :kgg_files, :media_file_size   , :name => :idx_kggf_media_file_size
    add_index :kgg_files, :media_content_type, :name => :idx_kggf_media_content_type
    add_index :kgg_files, :media_updated_at  , :name => :idx_kggf_media_updated_at
    add_index :kgg_files, :original_filename , :name => :idx_kggf_original_filename
    add_index :kgg_files, :filetype          , :name => :idx_kggf_filetype
    add_index :kgg_files, :version           , :name => :idx_kggf_version
    add_index :kgg_files, :url               , :name => :idx_kggf_url
    add_index :kgg_files, :exif              , :name => :idx_kggf_exif              , :using => :gin

    create_table :kgg_object_types do |t|
      t.string     :shortname    , :unique => true
      t.string     :name
      t.text       :description
      t.integer    :grouping_ids , :array  => true
      t.integer    :attribute_ids, :array  => true
      t.timestamps
    end
    add_index :kgg_object_types, :shortname    , :name => :idx_kggot_shortname
    add_index :kgg_object_types, :name         , :name => :idx_kggot_name
    add_index :kgg_object_types, :description  , :name => :idx_kggot_description
    add_index :kgg_object_types, :grouping_ids , :name => :idx_kggot_grouping_ids , :using => :gin
    add_index :kgg_object_types, :attribute_ids, :name => :idx_kggot_attribute_ids, :using => :gin

    create_table :kgg_objects do |t|
      t.references :object_type         , :null   => false
      t.string     :shortname           , :unique => true
      t.string     :name
      t.text       :description
      t.integer    :file_id
      t.integer    :author_id
      t.text       :note
      t.jsonb      :groupings           , :null   => false, :default => '{}'
      t.jsonb      :attributes          , :null   => false, :default => '{}'
      t.integer    :secondary_file_ids  , :array  => true
      t.integer    :secondary_author_ids, :array  => true
      t.timestamps
    end
    add_index :kgg_objects, :shortname           , :name => :idx_kggo_shortname
    add_index :kgg_objects, :name                , :name => :idx_kggo_name
    add_index :kgg_objects, :description         , :name => :idx_kggo_description
    add_index :kgg_objects, :file_id             , :name => :idx_kggo_file_id
    add_index :kgg_objects, :author_id           , :name => :idx_kggo_author_id
    add_index :kgg_objects, :groupings           , :name => :idx_kggo_groupings           , :using => :gin
    add_index :kgg_objects, :attributes          , :name => :idx_kggo_attributes          , :using => :gin
    add_index :kgg_objects, :secondary_file_ids  , :name => :idx_kggo_secondary_file_ids  , :using => :gin
    add_index :kgg_objects, :secondary_author_ids, :name => :idx_kggo_secondary_author_ids, :using => :gin
    add_foreign_key :kgg_objects, :kgg_object_types, :name => :fk_kggo_object_types, :column => :object_type_id
    add_foreign_key :kgg_objects, :kgg_files       , :name => :fk_kggo_files       , :column => :file_id
    add_foreign_key :kgg_objects, :users           , :name => :fk_kggo_authors     , :column => :author_id
            
        
  end
end
