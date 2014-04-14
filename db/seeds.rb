AdminUser.find_or_initialize_by_email(email: 'admin@example.com', password: 'password', password_confirmation: 'password').save!
User.find_or_initialize_by_email(name: 'Christo', email: 'hristodd@gmail.com', provider: 'facebook', uid: '587741082', oauth_token: 'CAAFpWEV47lYBAEQRykvY6SZAA932ZBMN7ClZB92v1mrSSBqSy9wA2tTorEAVJVrrkXACr85jiJXyleQO0Ir18YZAEqnqLvfpe2uQMGeek7ECTee1ZAl5cPf2aeXo5D0dZCcxQNTlWljdNTsYuEiLrOmLLyKsjl1LQsPgSZBOdIgPP8dXLh2ggBR', oauth_expires_at: '2014-12-31').save!

world_cup_2014 = Tournament.find_or_create_by_name(name: '2014 FIFA World Cup', start_at: '2014-06-12 00:00:00')
common_room = Room.find_or_create_by_name(name: 'World Room', tournament_id: world_cup_2014.id, q_public: true)
