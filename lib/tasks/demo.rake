namespace :db do
  namespace :seed do
    desc 'Seed demo dummy data to the database.'
    task :demo => 'db:abort_if_pending_migrations' do
      seed_file = File.join(Rails.root, 'db', 'seeds.demo.rb')
      load(seed_file) if File.exist?(seed_file)
    end
  end
end

