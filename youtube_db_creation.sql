CREATE DATABASE youtube;

USE youtube;

CREATE TABLE users (
	id SERIAL PRIMARY KEY COMMENT "Идентификатор пользователя",
	first_name VARCHAR(50) NOT NULL COMMENT "Имя пользователя",
	last_name VARCHAR(50) NOT NULL COMMENT "Фамилия пользователя",
	sex VARCHAR(50) COMMENT "Пол пользователя",
	birthday DATE COMMENT "Дата рождения",
	country INT UNSIGNED NOT NULL COMMENT "Страна пользователя",
	premium BOOLEAN DEFAULT FALSE COMMENT "Статус платной подписки",
	premium_end DATE DEFAULT NULL COMMENT "Дата окончания платной подписки",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления"
) COMMENT "Пользователи";

CREATE TABLE chanels (
	id SERIAL PRIMARY KEY COMMENT "Идентификатор канала",
	name VARCHAR(150) NOT NULL COMMENT "Название канала",
	user_id INT UNSIGNED NOT NULL COMMENT "ID владельца",
	description TEXT(1000) COMMENT "Описание канала",
	partners_programm BOOLEAN DEFAULT FALSE COMMENT "Статус партнерской программы",
	block BOOLEAN DEFAULT FALSE COMMENT "Статус блокировки канала",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления"
) COMMENT "Каналы";

CREATE TABLE videos (
	id SERIAL PRIMARY KEY COMMENT "Идентификатор видео",
	name VARCHAR(150) NOT NULL COMMENT "Название видео",
	chanel_id INT UNSIGNED NOT NULL COMMENT "ID канала",
	description TEXT(1000) COMMENT "Описание видео",
	lasting TIME NOT NULL COMMENT "Продолжительность видео",
	file_size INT UNSIGNED NOT NULL COMMENT "Размер файла",
	rating ENUM("0+", "6+", "12+", "16+", "18+") NOT NULL COMMENT "Возрастной рейтинг",
	promotion BOOLEAN DEFAULT FALSE COMMENT "Статус продвижения",
	promotion_end DATE DEFAULT NULL COMMENT "Дата окончания продвижения",
	block BOOLEAN DEFAULT FALSE COMMENT "Статус блокировки видео",
	monetization BOOLEAN DEFAULT TRUE COMMENT "Статус монетизации",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления"
) COMMENT "Видео";

CREATE TABLE posts (
	id SERIAL PRIMARY KEY COMMENT "Идентификатор поста",
	name VARCHAR(150) NOT NULL COMMENT "Название поста",
	body TEXT(5000) COMMENT "Содержание поста",
	media_id INT UNSIGNED COMMENT "ID прикрепленного файла",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления"
) COMMENT "Посты";

CREATE TABLE broadcasts (
	id SERIAL PRIMARY KEY COMMENT "Идентификатор трансляции",
	name VARCHAR(150) NOT NULL COMMENT "Название трансляции",
	chanel_id INT UNSIGNED NOT NULL COMMENT "ID канала",
	description TEXT(1000) COMMENT "Описание трансляции",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления"
) COMMENT "Трансляции";

CREATE TABLE playlists (
	id SERIAL PRIMARY KEY COMMENT "Идентификатор плэйлиста",
	name VARCHAR(150) NOT NULL COMMENT "Название плэйлиста",
	chanel_id INT UNSIGNED NOT NULL COMMENT "ID канала",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления"
) COMMENT "Плэйлисты";

CREATE TABLE movies (
	id SERIAL PRIMARY KEY COMMENT "Идентификатор фильма",
	name VARCHAR(150) NOT NULL COMMENT "Название фильма",
	copyright VARCHAR(250) NOT NULL COMMENT "Правообладатель",
	relise DATE NOT NULL COMMENT "Дата релиза",
	rating ENUM("0+", "6+", "12+", "16+", "18+") NOT NULL COMMENT "Возрастной рейтинг",
	lasting TIME NOT NULL COMMENT "Продолжительность фильма",
	price INT UNSIGNED NOT NULL COMMENT "Цена",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления"
) COMMENT "Фильмы";

CREATE TABLE users_movies (
	user_id INT UNSIGNED NOT NULL COMMENT "ID владельца",
	movie_id INT UNSIGNED NOT NULL COMMENT "ID фильма",
	status ENUM("bought", "rental") DEFAULT NULL COMMENT "Статус владения",
	rental_end DATE DEFAULT NULL COMMENT "Дата окончания проката",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления",
    PRIMARY KEY (user_id, movie_id) COMMENT "Составной первичный ключ"
) COMMENT "Связь пользователей и фильмов";

CREATE TABLE genres (
	id SERIAL PRIMARY KEY COMMENT "Идентификатор жанра",
	name ENUM("Action", "Adventure", "Animation", "Biography", "Comedy", "Crime", "Documentary",
		"Drama", "Family", "Fantasy", "Film Noir", "History", "Horror", "Music", "Musical", "Mystery",
		"Romance", "Sci-Fi", "Short Film", "Sport", "Superhero", "Thriller", "War", "Western") 
		NOT NULL UNIQUE COMMENT "Имя жанра",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания"
) COMMENT "Жанры";

CREATE TABLE movies_genres (
	genre_id INT UNSIGNED NOT NULL COMMENT "ID жанра",
	movie_id INT UNSIGNED NOT NULL COMMENT "ID фильма",
	PRIMARY KEY (genre_id, movie_id) COMMENT "Составной первичный ключ"
) COMMENT "Жанры фильмов";

CREATE TABLE countries (
	id SERIAL PRIMARY KEY COMMENT "Идентификатор страны",
	name VARCHAR(150) NOT NULL UNIQUE COMMENT "Название страны"
) COMMENT "Страны";

CREATE TABLE views (
	user_id INT UNSIGNED NOT NULL COMMENT "ID пользователя",
	video_id INT UNSIGNED NOT NULL COMMENT "ID видео",
	stop_marker TIME NOT NULL COMMENT "Временная метка окончания просмотра видео",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления",
	PRIMARY KEY (user_id, video_id) COMMENT "Составной первичный ключ"
) COMMENT "Просмотры";

CREATE TABLE subscriptions (
	user_id INT UNSIGNED NOT NULL COMMENT "ID пользователя",
	chanel_id INT UNSIGNED NOT NULL COMMENT "ID канала",
	status BOOLEAN DEFAULT FALSE COMMENT "Статус подписки",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления",
	PRIMARY KEY (user_id, chanel_id) COMMENT "Составной первичный ключ"
) COMMENT "Подписки";

CREATE TABLE media (
	id SERIAL PRIMARY KEY COMMENT "Идентификатор медиа",
	name VARCHAR(150) NOT NULL COMMENT "Название медиа",
	media_type ENUM("jpg", "JPEG", "png", "gif") NOT NULL COMMENT "Тип медиа",
	file_size INT UNSIGNED NOT NULL COMMENT "Размер файла",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления"
) COMMENT "Медиа";

CREATE TABLE playlists_videos (
	video_id INT UNSIGNED NOT NULL COMMENT "ID видео",
	playlist_id INT UNSIGNED NOT NULL COMMENT "ID плэйлиста",
	PRIMARY KEY (video_id, playlist_id) COMMENT "Составной первичный ключ"
) COMMENT "Видео в плэйлистах";

CREATE TABLE tags (
	id SERIAL PRIMARY KEY COMMENT "Идентификатор тэга",
	name VARCHAR(100) NOT NULL UNIQUE COMMENT "Имя тэга",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания"
) COMMENT "Тэги";

CREATE TABLE tags_videos (
	video_id INT UNSIGNED NOT NULL COMMENT "ID видео",
	tag_id INT UNSIGNED NOT NULL COMMENT "ID тэга",
	PRIMARY KEY (video_id, tag_id) COMMENT "Составной первичный ключ"
) COMMENT "Тэги для видео";

CREATE TABLE chats (
	id SERIAL PRIMARY KEY COMMENT "Идентификатор сообщения",
	user_id INT UNSIGNED NOT NULL COMMENT "ID пользователя",
	broadcast_id INT UNSIGNED NOT NULL COMMENT "ID трансляции",
	body VARCHAR(250) NOT NULL COMMENT "Текст сообщения",
	answer BOOLEAN DEFAULT FALSE COMMENT "Является ли ответным",
	ms_to_answer_id INT UNSIGNED NOT NULL COMMENT "ID сообщения на которое отвечает",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления"
) COMMENT "Чаты";

CREATE TABLE violations (
	id SERIAL PRIMARY KEY COMMENT "Идентификатор нарушения",
	from_user_id INT UNSIGNED NOT NULL COMMENT "ID заявляющего пользователя",
	to_video_id INT UNSIGNED NOT NULL COMMENT "ID видео",
	violation_type ENUM("Inappropriate content", "borrowing footage", "audio track borrowing") 
		NOT NULL COMMENT "Тип притензии",
	claim_body TEXT(1000) NOT NULL COMMENT "Текст притензии",
	viol_time_marker TIME NOT NULL COMMENT "Время нарушения в видео",
	viol_link VARCHAR(250) NOT NULL COMMENT "Ссылка на доказательство нарушения",
	ref_body TEXT(1000) NOT NULL COMMENT "Текст опровержения",
	ref_link VARCHAR(250) COMMENT "Ссылка на опровержение нарушения",
	decision_status ENUM("Considered", "Acepted", "Denied") 
		NOT NULL COMMENT "Статус рассмотрения",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления"
) COMMENT "Нарушения";

CREATE TABLE languages (
	id SERIAL PRIMARY KEY COMMENT "Идентификатор языка",
	name VARCHAR(100) NOT NULL UNIQUE COMMENT "Название языка",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания"
) COMMENT "Языки";

CREATE TABLE translations (
	movie_id INT UNSIGNED NOT NULL COMMENT "ID фильма",
	lang_id INT UNSIGNED NOT NULL COMMENT "ID языка",
	trans_type ENUM("dub", "sub") 
		NOT NULL COMMENT "Тип перевода",
	PRIMARY KEY (movie_id, lang_id, trans_type) COMMENT "Составной первичный ключ"
) COMMENT "Переводы";

CREATE TABLE subs (
	video_id INT UNSIGNED NOT NULL COMMENT "ID видео",
	lang_id INT UNSIGNED NOT NULL COMMENT "ID языка",
	creator_id INT UNSIGNED DEFAULT NULL COMMENT "ID создателя",
	PRIMARY KEY (video_id, lang_id) COMMENT "Составной первичный ключ"
) COMMENT "Субтитры";

CREATE TABLE comments (
	id SERIAL PRIMARY KEY COMMENT "Идентификатор коментария",
	target_type ENUM("Video", "Broadcast", "Post") 
		NOT NULL COMMENT "Тип сущности",
	target_id INT UNSIGNED NOT NULL COMMENT "ID сущности",
	body TEXT(1000) COMMENT "Содержание коментария",
	user_id INT UNSIGNED COMMENT "ID пользователя",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления"
) COMMENT "Коментарии";

CREATE TABLE likes (
	id SERIAL PRIMARY KEY COMMENT "Идентификатор отметки",
	target_type ENUM("Video", "Broadcast", "Post", "Comment") 
		NOT NULL COMMENT "Тип сущности",
	target_id INT UNSIGNED NOT NULL COMMENT "ID сущности",
	user_id INT UNSIGNED COMMENT "ID пользователя",
	status BOOLEAN NOT NULL COMMENT "Поставлен лайк или дизлайк",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Время создания",  
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT "Время обновления"
) COMMENT "Лайки и дизлайки";

#Доработка данных
#Cleaning data in users
UPDATE users SET sex='F' WHERE sex IN ('Miss', 'Ms.', 'Mrs.', 'Dr.');
UPDATE users SET sex='M' WHERE sex IN ('Mr.', 'Prof.');
UPDATE users SET premium_end=NULL WHERE premium =0;
UPDATE users SET updated_at = NOW() WHERE updated_at < created_at;

#Cleaning data in violations
UPDATE violations 
SET viol_time_marker = (SELECT lasting 
							FROM videos
							WHERE videos.id=to_video_id) 
	WHERE viol_time_marker > (SELECT lasting 
								FROM videos
								WHERE videos.id=to_video_id);		
UPDATE violations SET updated_at = NOW() WHERE updated_at < created_at;

#Cleaning data in videos
UPDATE videos SET chanel_id = FLOOR(1 + RAND() * 500);
UPDATE videos SET promotion_end=NULL WHERE promotion =0;
UPDATE videos SET promotion=0, promotion_end=NULL, monetization =0 WHERE block =1;
UPDATE videos SET file_size = FLOOR(10000 + (RAND() * 1000000)) WHERE file_size < 10000 OR file_size > 1000000;

#Cleaning data in movies
UPDATE movies SET lasting='03:30:00' WHERE lasting >'03:30:00';
UPDATE movies SET lasting='01:30:00' WHERE lasting <'01:30:00';
UPDATE movies SET price=0 WHERE price < 13;
UPDATE movies SET price=25 WHERE price < 38 AND price > 12;
UPDATE movies SET price=50 WHERE price < 63 AND price > 37;
UPDATE movies SET price=75 WHERE price < 88 AND price > 62;
UPDATE movies SET price=25 WHERE price > 87;

#Cleaning data in comments
ALTER TABLE comments MODIFY target_type ENUM("Video", "Broadcast", "Post", "Comment") NOT NULL COMMENT "Тип сущности";
UPDATE comments SET target_id=FLOOR(1 + RAND() * 200) WHERE target_type ='Post';
UPDATE comments SET target_id=FLOOR(1 + RAND() * 300) WHERE target_type ='Broadcast';
UPDATE comments SET target_id=FLOOR(1 + RAND() * 7000) WHERE target_type ='Comment';
UPDATE comments SET target_id=FLOOR(1 + RAND() * 2000) WHERE target_type ='Video';

#Cleaning data in chats
ALTER TABLE chats MODIFY ms_to_answer_id INT UNSIGNED COMMENT "ID сообщения на которое отвечает";
UPDATE chats SET ms_to_answer_id=NULL WHERE answer =0;
UPDATE chats SET updated_at = NOW() WHERE updated_at < created_at;

#Cleaning data in chanels
UPDATE chanels SET partners_programm=0 WHERE block =1;
UPDATE chanels SET updated_at = NOW() WHERE updated_at < created_at;

#Cleaning data in likes
UPDATE likes SET target_id=FLOOR(1 + RAND() * 200) WHERE target_id >200 AND target_type ='Post';
UPDATE likes SET target_id=FLOOR(1 + RAND() * 300) WHERE target_id >300 AND target_type ='Broadcast';
UPDATE likes SET target_id=FLOOR(1 + RAND() * 2000) WHERE target_id >2000 AND target_type ='Video';
UPDATE likes SET updated_at = NOW() WHERE updated_at < created_at;

#Cleaning data in users_movies
UPDATE users_movies SET rental_end=NULL WHERE status='bought';
UPDATE users_movies SET updated_at = NOW() WHERE updated_at < created_at;

#Cleaning data in posts
UPDATE posts SET updated_at = NOW() WHERE updated_at < created_at;

#Cleaning data in media
UPDATE media SET file_size = FLOOR(1000 + (RAND() * 10000)) WHERE file_size < 1000 OR file_size > 10000;
UPDATE media SET updated_at = NOW() WHERE updated_at < created_at;

#Cleaning data in broadcasts
UPDATE broadcasts SET updated_at = NOW() WHERE updated_at < created_at;

#Cleaning data in views
UPDATE views 
SET stop_marker = (SELECT lasting 
							FROM videos
							WHERE videos.id=video_id) 
	WHERE stop_marker > (SELECT lasting 
								FROM videos
								WHERE videos.id=video_id);
UPDATE views SET updated_at = NOW() WHERE updated_at < created_at;

#Cleaning data in subscriptions
UPDATE subscriptions SET updated_at = NOW() WHERE updated_at < created_at;

#Cleaning data in playlists
UPDATE playlists SET updated_at = NOW() WHERE updated_at < created_at;

#Внешние ключи
ALTER TABLE countries MODIFY COLUMN id INT UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE users ADD CONSTRAINT users_country_fk
	FOREIGN KEY (country) REFERENCES countries(id);

ALTER TABLE movies MODIFY COLUMN id INT UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE genres MODIFY COLUMN id INT UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE movies_genres ADD CONSTRAINT movies_genres_movie_id_fk
	FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE;
ALTER TABLE movies_genres ADD CONSTRAINT movies_genres_genre_id_fk
	FOREIGN KEY (genre_id) REFERENCES genres(id);

ALTER TABLE videos MODIFY COLUMN id INT UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE playlists MODIFY COLUMN id INT UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE playlists_videos ADD CONSTRAINT playlists_videos_video_id_fk
	FOREIGN KEY (video_id) REFERENCES videos(id) ON DELETE CASCADE;
ALTER TABLE playlists_videos ADD CONSTRAINT playlists_videos_playlist_id_fk
	FOREIGN KEY (playlist_id) REFERENCES playlists(id) ON DELETE CASCADE;

ALTER TABLE tags MODIFY COLUMN id INT UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE tags_videos ADD CONSTRAINT tags_videos_video_id_fk
	FOREIGN KEY (video_id) REFERENCES videos(id) ON DELETE CASCADE;
ALTER TABLE tags_videos ADD CONSTRAINT tags_videos_tag_id_fk
	FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE;

ALTER TABLE languages MODIFY COLUMN id INT UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE subs ADD CONSTRAINT subs_video_id_fk
	FOREIGN KEY (video_id) REFERENCES videos(id) ON DELETE CASCADE;
ALTER TABLE subs ADD CONSTRAINT subs_lang_id_fk
	FOREIGN KEY (lang_id) REFERENCES languages(id);

ALTER TABLE translations ADD CONSTRAINT translations_movie_id_fk
	FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE;
ALTER TABLE translations ADD CONSTRAINT translations_lang_id_fk
	FOREIGN KEY (lang_id) REFERENCES languages(id);

ALTER TABLE users MODIFY COLUMN id INT UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE chanels MODIFY COLUMN id INT UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE subscriptions ADD CONSTRAINT subscriptions_user_id_fk
	FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;
ALTER TABLE subscriptions ADD CONSTRAINT subscriptions_chanel_id_fk
	FOREIGN KEY (chanel_id) REFERENCES chanels(id) ON DELETE CASCADE;

ALTER TABLE views ADD CONSTRAINT views_user_id_fk
	FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE views ADD CONSTRAINT views_video_id_fk
	FOREIGN KEY (video_id) REFERENCES videos(id) ON DELETE CASCADE;

ALTER TABLE users_movies ADD CONSTRAINT users_movies_user_id_fk
	FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;
ALTER TABLE users_movies ADD CONSTRAINT users_movies_movie_id_fk
	FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE;

ALTER TABLE chanels ADD CONSTRAINT chanels_user_id_fk
	FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;

UPDATE playlists SET chanel_id=1 WHERE chanel_id =0;
ALTER TABLE playlists ADD CONSTRAINT playlists_chanel_id_fk
	FOREIGN KEY (chanel_id) REFERENCES chanels(id) ON DELETE CASCADE;

ALTER TABLE videos ADD CONSTRAINT videos_chanel_id_fk
	FOREIGN KEY (chanel_id) REFERENCES chanels(id);

ALTER TABLE broadcasts ADD CONSTRAINT broadcasts_chanel_id_fk
	FOREIGN KEY (chanel_id) REFERENCES chanels(id);

ALTER TABLE violations ADD CONSTRAINT violations_from_user_id_fk
	FOREIGN KEY (from_user_id) REFERENCES users(id) ON DELETE CASCADE;
ALTER TABLE violations ADD CONSTRAINT violations_to_video_id_fk
	FOREIGN KEY (to_video_id) REFERENCES videos(id) ON DELETE CASCADE;

ALTER TABLE likes ADD CONSTRAINT likes_user_id_fk
	FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;

ALTER TABLE chats MODIFY COLUMN id INT UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE broadcasts MODIFY COLUMN id INT UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE chats ADD CONSTRAINT chats_user_id_fk
	FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE chats ADD CONSTRAINT chats_broadcast_id_fk
	FOREIGN KEY (broadcast_id) REFERENCES broadcasts(id) ON DELETE CASCADE;
ALTER TABLE chats ADD CONSTRAINT chats_ms_to_answer_id_fk
	FOREIGN KEY (ms_to_answer_id) REFERENCES chats(id);

UPDATE subs SET creator_id=NULL WHERE creator_id =0;
ALTER TABLE subs ADD CONSTRAINT subs_creator_id_fk
	FOREIGN KEY (creator_id) REFERENCES users(id);
 
ALTER TABLE media MODIFY COLUMN id INT UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE posts ADD COLUMN chanel_id INT UNSIGNED NOT NULL COMMENT "ID канала" AFTER id;
UPDATE posts SET chanel_id = FLOOR(1 + (RAND() * 500));
UPDATE posts SET media_id=NULL WHERE media_id =0;
ALTER TABLE posts ADD CONSTRAINT posts_chanel_id_fk
	FOREIGN KEY (chanel_id) REFERENCES chanels(id) ON DELETE CASCADE;
ALTER TABLE posts ADD CONSTRAINT posts_media_id_fk
	FOREIGN KEY (media_id) REFERENCES media(id);

ALTER TABLE comments MODIFY COLUMN id INT UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE comments ADD CONSTRAINT comments_user_id_fk
	FOREIGN KEY (user_id) REFERENCES users(id);

#Функция для проверки наличия идентификатора сущности для таблиц лайков и коментариев
DELIMITER //

CREATE FUNCTION row_existing (target_type VARCHAR(50), target_id INT)
RETURNS BOOLEAN READS SQL DATA

BEGIN
  CASE target_type
    WHEN 'Video' THEN
      RETURN EXISTS(SELECT 1 FROM videos WHERE id = target_id);
    WHEN 'Post' THEN 
      RETURN EXISTS(SELECT 1 FROM posts WHERE id = target_id);
    WHEN 'Broadcast' THEN
      RETURN EXISTS(SELECT 1 FROM broadcasts WHERE id = target_id);
    WHEN 'Comment' THEN
      RETURN EXISTS(SELECT 1 FROM comments WHERE id = target_id);
    ELSE 
      RETURN FALSE;
  END CASE;
END//

#Триггер для проверки наличия идентификатора сущности для таблицы лайков
CREATE TRIGGER likes_validation BEFORE INSERT ON likes

FOR EACH ROW BEGIN
  IF NOT row_existing(NEW.target_type, NEW.target_id) THEN
    SIGNAL SQLSTATE "45000"
    SET MESSAGE_TEXT = "Error adding like! Target table doesn't contain row id provided!";
  END IF;
END//

#Триггер для проверки наличия идентификатора сущности для таблицы коментариев
CREATE TRIGGER comments_validation BEFORE INSERT ON comments

FOR EACH ROW BEGIN
  IF NOT row_existing(NEW.target_type, NEW.target_id) THEN
    SIGNAL SQLSTATE "45000"
    SET MESSAGE_TEXT = "Error adding comment! Target table doesn't contain row id provided!";
  END IF;
END//

DELIMITER ;

#Создание дополнительных индексов
CREATE INDEX users_last_name_idx ON users(last_name);
CREATE INDEX users_last_name_first_name_idx ON users(last_name, first_name);

CREATE INDEX chanels_name_idx ON chanels(name);

CREATE INDEX playlists_name_idx ON playlists(name);

CREATE INDEX videos_name_idx ON videos(name);

CREATE INDEX violations_viol_link_idx ON violations(viol_link);

CREATE INDEX movies_name_idx ON movies(name);
CREATE INDEX movies_copyright_idx ON movies(copyright);

CREATE INDEX broadcasts_name_idx ON broadcasts(name);

CREATE INDEX posts_name_idx ON posts(name);

CREATE INDEX media_name_idx ON media(name);
CREATE INDEX media_media_type_idx ON media(media_type);

CREATE INDEX likes_target_type_idx ON likes(target_type);
CREATE INDEX likes_target_id_idx ON likes(target_id);

CREATE INDEX comments_target_type_idx ON comments(target_type);
CREATE INDEX comments_target_id_idx ON comments(target_id);
