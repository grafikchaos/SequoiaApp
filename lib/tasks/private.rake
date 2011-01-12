namespace :db do
  namespace :seed do
    desc 'Seed private data to the database.'
    task :private => 'db:abort_if_pending_migrations' do
      seed_file = File.join(Rails.root, 'db', 'seeds.private.rb')
      load(seed_file) if File.exist?(seed_file)
    end
  end
end

