# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

desc 'Run continuous integration suite'
task ci: [:environment] do
  if Rails.env.test?
    Rake::Task['db:migrate'].invoke
    Rake::Task['spec'].invoke
  else
    system('rake ci RAILS_ENV=test')
  end
end

task default: :ci
