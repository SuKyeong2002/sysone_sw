SELECT owner, table_name
FROM all_tables
WHERE table_name LIKE '%MEMBER%';

-- 7/24(목)
SELECT name FROM clothes
WHERE member_id = :myId AND deleted = 'N';

select * from clothes;

select * 
from clothes 
where member_id = 1;

select * from friend;

select * from member;

-- 친구 엮기
INSERT INTO friend (member1_id, member2_id, status)
VALUES (1, 2, 'Y');

desc clothes;

-- 옷 추가
INSERT INTO (id, member_id, category_id, name, memom, keyword, item_size, color, brand, deleted, created_at)
VALUSE (1)

DROP SEQUENCE SEQ_CLOTHES;

CREATE SEQUENCE SEQ_CLOTHES
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 9999999
    NOCYCLE;

-- CODI
CREATE SEQUENCE codi_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 9999999
    NOCYCLE;
    
SELECT constraint_name, column_name
FROM all_cons_columns
WHERE constraint_name = 'SYS_C008313';

-- 
-- notification
CREATE TABLE notification (
	id	number		NOT NULL,
	receiver_id	number		NOT NULL,
	sender_id	number		NOT NULL
);

--
CREATE SEQUENCE SEQ_NOTIFICATION
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 9999999
    NOCYCLE;

--
SELECT * FROM all_tables WHERE table_name = 'NOTIFICATION';

SELECT * FROM all_tables WHERE table_name = 'CLOTHES';

SELECT sequence_name
FROM user_sequences
WHERE sequence_name LIKE '%CLOTHES%';

--
DROP SEQUENCE SEQ_CLOTHES;



-- COMMIT
COMMIT;
