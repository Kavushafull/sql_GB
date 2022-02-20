#Видео с названием канала на котором находится
CREATE OR REPLACE VIEW video_chanels AS
SELECT
  v.name AS video,
  c.name AS chanel
FROM videos AS v
  JOIN chanels AS c
    ON v.chanel_id = c.id;

SELECT * FROM video_chanels ;

#Видео с текстом нарушения, временным маркером и доказательством
CREATE OR REPLACE VIEW video_violations AS
SELECT
  v.name AS video,
  v2.claim_body AS violation,
  v2.viol_time_marker AS on_time,
  v2.viol_link AS confirmation
FROM videos AS v
  JOIN violations AS v2
    ON v.id = v2.to_video_id ;

SELECT * FROM video_violations ;