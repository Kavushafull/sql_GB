#¬ложенные запросы
#«апрос на вывод процентного соотношени€ видео по рейтингу и просмотрам
SELECT rating, 
	COUNT(id) number_of_videos, 
	(SELECT COUNT(*) FROM videos) all_videos,
	(COUNT(id)/(SELECT COUNT(*) FROM videos))*100 '%%',
	SUM((SELECT COUNT(user_id) FROM views v2 WHERE video_id=v.id)) views,
	(SELECT COUNT(*) FROM views) all_views,
	(SUM((SELECT COUNT(user_id) FROM views v2 WHERE video_id=v.id))/(SELECT COUNT(*) FROM views))*100 '%%' 
FROM videos v GROUP BY rating ORDER BY rating;

#«апрос на вывод колличества пользователей по странам и полу
SELECT (SELECT name FROM countries c WHERE c.id=country) country, 
	COUNT(id) nubber_of_users, 
	(SELECT COUNT(*) FROM users u2) all_users,
	(COUNT(id)/(SELECT COUNT(*) FROM users u2))*100 '%%',
	(SELECT COUNT(id) FROM users u3 WHERE sex='F' AND u3.country = u.country GROUP BY country) female,
	(SELECT COUNT(id) FROM users u3 WHERE sex='M' AND u3.country = u.country GROUP BY country) male
FROM users u GROUP BY country ORDER BY nubber_of_users DESC; 

#JOIN запросы
#«апрос на вывод колличества подписчиков и их среднего возраста, и колличества видео на каналах
SELECT DISTINCT c.id, c.name, COUNT(s.user_id) OVER(PARTITION BY c.id) subscribers,
	(COUNT(s.user_id) OVER(PARTITION BY c.id)/(SELECT COUNT(u2.id) FROM users u2))*100 '%%',
	ROUND(AVG((YEAR(CURRENT_DATE())-YEAR(u.birthday))-
		(DATE_FORMAT(CURRENT_DATE(), '%m%d')<DATE_FORMAT(u.birthday, '%m%d'))) 
			OVER(PARTITION BY c.id)) avg_subscribers_age,
	v_by_chanels videos, (v_by_chanels/all_v)*100 '%%' 
	FROM subscriptions s 
	JOIN chanels c 
		ON c.id =s.chanel_id
	JOIN users u 
		ON s.user_id =u.id
	JOIN (SELECT DISTINCT chanel_id, (SELECT COUNT(*) FROM videos) all_v , 
			COUNT(id) OVER(PARTITION BY chanel_id) v_by_chanels FROM videos) v
		ON v.chanel_id = s.chanel_id 
	WHERE s.status=1
	ORDER BY subscribers DESC; 

#«апрос на вывод имен пользователей, их возраста, количества оставленных коментариев и лайков	
SELECT DISTINCT u.id, CONCAT(first_name, ' ', last_name) username,
	(YEAR(CURRENT_DATE())-YEAR(u.birthday))-
		(DATE_FORMAT(CURRENT_DATE(), '%m%d')<DATE_FORMAT(u.birthday, '%m%d')) age,
	COUNT(c.id) OVER(PARTITION BY u.id) comments, likes 
	FROM users u
	JOIN comments c 
		ON c.user_id =u.id
	JOIN (SELECT DISTINCT user_id, COUNT(id) OVER(PARTITION BY user_id) likes FROM likes l) l 
		ON l.user_id =u.id 
	ORDER BY comments DESC, likes DESC;
	