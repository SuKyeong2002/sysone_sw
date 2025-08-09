-- BLOB 컬럼을 제외하고 INSERT 후 UPDATE
INSERT INTO member (
  id, account_id, email, name,
  nickname, password, 
  deleted, count
)
SELECT DISTINCT
  p.member_id,
  'user' || p.member_id,
  'test' || p.member_id || '@ex.com',
  '사용자' || p.member_id,
  '닉네임' || p.member_id,
  'pw',
  'N',
  0
FROM post p
LEFT JOIN member m ON p.member_id = m.id
WHERE m.id IS NULL
AND ROWNUM <= 20;

-- member 테이블 조회
select * 
from member 
order by id desc;


-- post 테이블 조회
select * from post
order by member_id desc;

-- member 테이블과 post 테이블 조인
SELECT p.*, m.name AS writer_name
FROM post p
LEFT OUTER JOIN member m ON p.member_id = m.id
ORDER BY p.id DESC;


-- member 테이블의 id를 201에서 117로 수정
UPDATE member 
SET id = 117,
    account_id = 'user117',  -- account_id도 일관성 유지를 위해 수정
    email = 'test117@ex.com'  -- email도 일관성 유지를 위해 수정
WHERE id = 117;

-- member 테이블의 122번 id의 이름 변경
UPDATE member 
SET name = '홍길동' 
WHERE id = 122;

-- 확인용 쿼리
SELECT * FROM post WHERE member_id = 117;

-- member 테이블의 id를 1에서 106로 수정
UPDATE member 
SET id = 106,
    account_id = 'user106',  -- account_id도 일관성 유지를 위해 수정
    email = 'test117@ex.com'  -- email도 일관성 유지를 위해 수정
WHERE id = 1;

-- 확인용 쿼리
SELECT * FROM member WHERE id = 106;

-- member 테이블의 id를 22에서 100로 수정
UPDATE member 
SET id = 100,
    account_id = 'user100',  -- account_id도 일관성 유지를 위해 수정
    email = 'test100@ex.com'  -- email도 일관성 유지를 위해 수정
WHERE id = 22;

-- 확인용 쿼리
SELECT * FROM member WHERE id = 106;

-- post 테이블의 id=122인 행의 member_id를 1에서 100으로 수정
UPDATE post 
SET member_id = 100
WHERE id = 122;

-- 확인용 쿼리
SELECT * FROM post WHERE id = 122;

-- post 테이블의 id=1753084863588인 행의 member_id를 201에서 104로 수정
UPDATE post 
SET member_id = 102
WHERE id = 1753099373602;

-- 확인용 쿼리
SELECT * FROM post WHERE id = 1753099373602;

-- post 테이블에서 id=122인 행 삭제
DELETE FROM post 
WHERE id = 22;

-- 삭제 확인용 쿼리 (삭제된 경우 결과 없음)
SELECT * FROM post WHERE id = 122;

-- member 테이블에 id=117인 새로운 회원 추가
INSERT INTO member (
  id, account_id, email, name, 
  nickname, password, profile_img, 
  deleted, count
) VALUES (
  117,
  'user117',
  'test117@ex.com',
  '사용자117',
  '닉네임117',
  'pw',
  NULL,  -- profile_img는 NULL로 설정
  'N',
  0
);

-- 확인용 쿼리
SELECT * FROM member WHERE id = 117;

-- 1번 추가
INSERT INTO post (id, member_id, cody_id, title, content, create_at, last_updated)
VALUES (1, 101, 201, '첫 번째 글', '이것은 테스트 게시글입니다.', SYSDATE, SYSDATE);

INSERT INTO member (
    id, account_id, email, name, nickname, password, profile_img, deleted, count
)
VALUES (
    122,
    'user122',
    'devwithosk@gmail.com',
    '오수경',
    '수수수수퍼노바.',
    '4604q624',
    '',
    'N',
    0
);

SELECT * FROM member 
WHERE NAME LIKE '오수경';

-- 7/22(화)
-- member 테이블에 시퀀스 추가
CREATE SEQUENCE SEQ_MEMBER
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 9999999
	NOCYCLE;

-- post 테이블에 시퀀스 추가
CREATE SEQUENCE SEQ_POST
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 9999999
	NOCYCLE;

-- post 테이블에 시퀀스 삭제  
DROP SEQUENCE SEQ_POST;


-- commit
commit;



