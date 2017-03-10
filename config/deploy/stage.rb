server "sul-mirador-stage", user: "mirador", roles: %w{app db web}
Capistrano::OneTimeKey.generate_one_time_key!

set :rails_env, 'production'
