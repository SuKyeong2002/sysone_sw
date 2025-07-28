-- 전체 테이블 확인
select table_name from user_tables;

-- like_post 테이블 구조 확인
desc like_post;

-- 좋아요 확인
SELECT p.id, p.title, p.member_id, p.create_at, NVL(COUNT(l.post_id), 0) AS like_count
FROM post p
LEFT JOIN like_post l ON p.id = l.post_id
GROUP BY p.id, p.title, p.member_id, p.create_at
ORDER BY p.create_at DESC;

--좋아요 테이블 프로시저 생성
	CREATE SEQUENCE SEQ_LIKE_POST
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 9999999
	NOCYCLE;
    
-- 좋아요 테이블 프로시저 확인 
SELECT sequence_name FROM user_sequences WHERE sequence_name = 'SEQ_LIKE_POST';

-- 커밋
COMMIT;

-- 좋아요 DB에서 직접 확인:
SELECT * FROM like_post ORDER BY created_at DESC;

SELECT * FROM post;

desc post;

-- 게시글 하나 삭제
DELETE FROM post_comment WHERE post_id = 21;
DELETE FROM post WHERE id = 21;

-- 
        SELECT p.id, p.title, p.member_id, p.cody_id, p.content,
            p.create_at, p.last_updated,
            m.nickname AS writer_name,
            (SELECT COUNT(*) FROM like_post l WHERE l.post_id = p.id) AS like_count
        FROM post p
            LEFT JOIN member m ON p.member_id = m.id
        ORDER BY p.id DESC;
        
-- SEQ_POST 프로시저 삭제
DROP SEQUENCE SEQ_POST_COMMENT;

-- POST 테이블 프로시저 생성
	CREATE SEQUENCE SEQ_POST_COMMENT
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 9999999
	NOCYCLE;
    
-- POST 테이블 데이터 확인
SELECT * FROM member;

desc like_post;