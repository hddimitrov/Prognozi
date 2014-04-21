AdminUser.find_or_initialize_by_email(email: 'admin@example.com', password: 'password', password_confirmation: 'password').save!
me = User.find_or_initialize_by_email(name: 'Christo', email: 'hristodd@gmail.com', provider: 'facebook', uid: '587741082', oauth_token: 'CAAFpWEV47lYBAEQRykvY6SZAA932ZBMN7ClZB92v1mrSSBqSy9wA2tTorEAVJVrrkXACr85jiJXyleQO0Ir18YZAEqnqLvfpe2uQMGeek7ECTee1ZAl5cPf2aeXo5D0dZCcxQNTlWljdNTsYuEiLrOmLLyKsjl1LQsPgSZBOdIgPP8dXLh2ggBR', oauth_expires_at: '2014-12-31')
me.save

world_cup_2014 = Tournament.find_or_create_by_name(name: '2014 FIFA World Cup', start_at: '2014-06-12 00:00:00')
world_room = Room.find_or_create_by_name(name: 'World Room', tournament_id: world_cup_2014.id, q_public: true)
world_room.m_score_points = 4
world_room.m_sign_points = 1
world_room.gs_position_1_points = 4
world_room.e_ef_points = 3
world_room.e_qf_points = 6
world_room.e_sf_points = 11
world_room.e_l_points = 13
world_room.e_f_points = 16
world_room.e_c_points = 20
world_room.save

UserRoom.find_or_create_by_user_id_and_room_id(me.id, world_room.id)

groupA = Group.find_or_create_by_name('A', tournament_id: world_cup_2014.id)
groupB = Group.find_or_create_by_name('B', tournament_id: world_cup_2014.id)
groupC = Group.find_or_create_by_name('C', tournament_id: world_cup_2014.id)
groupD = Group.find_or_create_by_name('D', tournament_id: world_cup_2014.id)
groupE = Group.find_or_create_by_name('E', tournament_id: world_cup_2014.id)
groupF = Group.find_or_create_by_name('F', tournament_id: world_cup_2014.id)
groupG = Group.find_or_create_by_name('G', tournament_id: world_cup_2014.id)
groupH = Group.find_or_create_by_name('H', tournament_id: world_cup_2014.id)

ef = Elimination.find_or_create_by_code('ef', name: '1/8-Final', tournament_id: world_cup_2014.id)
qf = Elimination.find_or_create_by_code('qf', name: '1/4-Final', tournament_id: world_cup_2014.id)
sf = Elimination.find_or_create_by_code('sf', name: '1/2-Final', tournament_id: world_cup_2014.id)
l = Elimination.find_or_create_by_code('l',   name: '3rd Place', tournament_id: world_cup_2014.id)
f = Elimination.find_or_create_by_code('f',   name: 'Final',     tournament_id: world_cup_2014.id)
c = Elimination.find_or_create_by_code('c',   name: 'Champion',  tournament_id: world_cup_2014.id)

Team.find_or_create_by_name('Australia')
Team.find_or_create_by_name('Iran')
Team.find_or_create_by_name('Japan')
Team.find_or_create_by_name('South Korea')
Team.find_or_create_by_name('Algeria')
Team.find_or_create_by_name('Cameroon')
Team.find_or_create_by_name('Ghana')
Team.find_or_create_by_name('Ivory Coast')
Team.find_or_create_by_name('Nigeria')
Team.find_or_create_by_name('Costa Rica')
Team.find_or_create_by_name('Honduras')
Team.find_or_create_by_name('Mexico')
Team.find_or_create_by_name('United States')
Team.find_or_create_by_name('Argentina')
Team.find_or_create_by_name('Brazil')
Team.find_or_create_by_name('Chile')
Team.find_or_create_by_name('Colombia')
Team.find_or_create_by_name('Ecuador')
Team.find_or_create_by_name('Uruguay')
Team.find_or_create_by_name('Belgium')
Team.find_or_create_by_name('Bosnia and H')
Team.find_or_create_by_name('Croatia')
Team.find_or_create_by_name('England')
Team.find_or_create_by_name('France')
Team.find_or_create_by_name('Germany')
Team.find_or_create_by_name('Greece')
Team.find_or_create_by_name('Italy')
Team.find_or_create_by_name('Netherlands')
Team.find_or_create_by_name('Portugal')
Team.find_or_create_by_name('Russia')
Team.find_or_create_by_name('Spain')
Team.find_or_create_by_name('Switzerland')
