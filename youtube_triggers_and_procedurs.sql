#��������
#���������� ����� � ������ ��������� ����� ���� ���������
DELIMITER //

CREATE TRIGGER video_block_violation AFTER INSERT ON violations
FOR EACH ROW BEGIN
  IF (SELECT COUNT(*) FROM violations v WHERE to_video_id=NEW.to_video_id AND decision_status IN ("Considered", "Acepted"))>2 THEN
    UPDATE videos SET block=1, promotion=0, promotion_end=NULL, monetization=0 WHERE videos.id=NEW.to_video_id;
  END IF;
END//

DELIMITER ;

#��������� ������������ ��� �������� ��� ������������ �� ���������� ���
DELIMITER //

CREATE TRIGGER validate_user_age BEFORE INSERT ON users
FOR EACH ROW BEGIN
  DECLARE birthday DATE;
  SELECT NOW() INTO birthday;
  SET NEW.birthday =COALESCE(NEW.birthday, birthday);
END//

DELIMITER ;

#���������
#������ ������� ����������� ���������
DELIMITER //

CREATE PROCEDURE is_chanel_partners_program (id INT)
BEGIN
  IF (SELECT COUNT(*) FROM subscriptions WHERE chanel_id=id AND status=1)>100 THEN
    UPDATE chanels SET partners_programm=1 WHERE chanels.id=id;
  END IF;
END//

DELIMITER ;

#������ ������� ����������� ���������
DELIMITER //

CREATE PROCEDURE is_video_exist (to_video_id INT)
BEGIN
  IF EXISTS(SELECT 1 FROM videos WHERE id = to_video_id) THEN
  	SIGNAL SQLSTATE "45000"
    SET MESSAGE_TEXT='Video existing';
  END IF;
END//

DELIMITER ;