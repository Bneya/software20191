Campus.create("name": "San joaquin", "description": "My camus verde en sn joaco", "location_map": "macul")
Course.create("name": "curso 1", "campus_id": 1, "description": "descipcion del primer curso")
Classroom.create("title": "sala 1", "ubication": "sanjoaco", "campus_id": 1)
Classroom.create("title": "sala 2", "ubication": "sanjoaco", "campus_id": 1)
Classroom.create("title": "sala 3", "ubication": "sanjoaco", "campus_id": 1)
Classroom.create("title": "sala 4", "ubication": "sanjoaco", "campus_id": 1)
Classroom.create("title": "sala 5", "ubication": "sanjoaco", "campus_id": 1)
Classroom.create("title": "sala 6", "ubication": "sanjoaco", "campus_id": 1)

user = User.new
user.email = 'admin@admin.com'
user.password =   '123456'
user.password_confirmation = '123456'
user.add_role :admin
user.save!

user = User.new
user.email = 'comun@comun.com'
user.password =   '123456'
user.password_confirmation = '123456'
user.save!
