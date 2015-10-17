desc "Migrate the database through scripts in db/migrate."
namespace :db do
  
  task :migrate_kgg => :environment do
    KgDbFetcher.execute("CREATE schema IF NOT EXISTS #{Rails.application.config.gallery_shortname};")
    KgDbFetcher.execute('CREATE EXTENSION IF NOT EXISTS "uuid-ossp";')
    KgDbFetcher.execute('CREATE EXTENSION IF NOT EXISTS "hstore"   ;')
    ActiveRecord::Base.establish_connection
    ActiveRecord::Migrator.migrate("db/migrate/")
  end

end
