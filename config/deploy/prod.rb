server "sul-mirador-prod", user: "mirador", roles: %w{app db web}
Capistrano::OneTimeKey.generate_one_time_key!
