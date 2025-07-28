CREATE OR REPLACE PROCEDURE get_refcur_proc(p_refcur IN OUT SYS_REFCURSOR, p_tab VARCHAR2)
IS 
    l_query VARCHAR2(2000) := 'SELECT * FROM departments';
BEGIN
    IF NOT p_refcur%ISOPEN THEN 
        CASE p_tab WHEN 'emp' THEN
                        OPEN p_refcur FOR 
                        SELECT * FROM employees 
                        WHERE department_id = 90;
                    ELSE 
                        OPEN p_refcur FOR l_query;
        END CASE; 
    ELSE
        DBMS_OUTPUT.PUT_LINE('Cursor Already Open!!');
    END IF;
END;
/

-- 
CREATE OR REPLACE PROCEDURE print_refcur_proc(p_refcur IN OUT SYS_REFCURSOR, p_tab VARCHAR2 DEFAULT 'emp')
AS 
    l_emprec employees%ROWTYPE;
    l_deptrec departments%ROWTYPE;
BEGIN
    IF p_refcur%ISOPEN THEN
        LOOP
            IF p_tab = 'emp' THEN
                FETCH p_refcur INTO l_emprec;
            ELSIF p_tab = 'dept' THEN
                FETCH p_refcur INTO l_deptrec;
            ELSE 
                RAISE_APPLICATION_ERROR(-20001, 'THE specified table is crap!!');
            END IF;
            
            EXIT WHEN p_refcur%NOTFOUND;
            
            IF p_tab = 'emp' THEN 
                DBMS_OUTPUT.PUT_LINE(l_emprec.employee_id || ', ' || l_emprec.salary);
            ELSE 
                DBMS_OUTPUT.PUT_LINE(l_deptrec.department_id || ', ' || l_deptrec.department_name);
            END IF;
            
        END LOOP;
    ELSE 
        DBMS_OUTPUT.PUT_LINE('커서가 닫혀있습니다 !!');
    END IF;
END;
/

-- 커서 함수
set serverout on;

DECLARE 
    l_refcur SYS_REFCURSOR; -- l_refcur : 변수
BEGIN -- 다른 결과 집합 출력
    get_refcur_proc(l_refcur, 'dept');
    print_refcur_proc(l_refcur, 'dept');
    
    DBMS_OUTPUT.NEW_LINE;
    
    get_refcur_proc(l_refcur, 'emp');
    print_refcur_proc(l_refcur, 'emp');
EXCEPTION 
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('오류 발생: ' || SQLERRM(SQLCODE));
END;
/

desc dbms_output

-- [실습] 커서를 여는 프로시저
CREATE OR REPLACE PROCEDURE open_refcur_proc
    (p_ename  IN  VARCHAR2,   
     o_cursor OUT SYS_REFCURSOR)  
IS
  l_sql_statement VARCHAR2(32767);
BEGIN
  -- 변수명 앞에 콜론(:)을 추가하여 USING구문 대상임을 선언해야 함
  l_sql_statement := 
      'SELECT /* USING TEST */ last_name, job_id' ||
      ' FROM employees' ||
      ' WHERE last_name = :p_ename';
  -- USING구문을 사용해야 SQL 공유가 가능함
  -- USING 다음에 :p_ename 바인드 변수에 대응하는 변수명을 입력
  OPEN o_cursor 
    FOR l_sql_statement 
    USING p_ename;     

END;    
/

-- [실습] Open된 커서를 변수로 받아 Fetch후 Close하는 프로시저
CREATE OR REPLACE PROCEDURE fetch_refcur_proc(p_refcur IN SYS_REFCURSOR)
IS  
  -- 커서 내용을 저장할 레코드 타입 선언
  TYPE rec_emp_typ iS RECORD (
    ename employees.last_name%TYPE,
    job   employees.job_id%TYPE
  );
  
  l_ref rec_emp_typ;
BEGIN
  LOOP
    -- 넘겨받은 REF커서의 내용을 Fetch하여 변수에 저장함  
    FETCH p_refcur INTO l_ref;
    
    EXIT WHEN p_refcur%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE(l_ref.ename|| ' ' ||l_ref.job);    
  END LOOP;

  -- 커서 Close
  CLOSE p_refcur;
  
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Outer Error : '||SQLERRM(SQLCODE));

END;
/


-- [실습] 위 두 프로시저를 실행하는 익명 블록
DECLARE
  l_refcur SYS_REFCURSOR;
BEGIN
  open_refcur_proc('King', l_refcur);
  fetch_refcur_proc(l_refcur);
  DBMS_OUTPUT.PUT_LINE('-----------------------');
  open_refcur_proc('De Haan', l_refcur);
  fetch_refcur_proc(l_refcur);
  DBMS_OUTPUT.PUT_LINE('-----------------------');
  open_refcur_proc('Grant', l_refcur);
  fetch_refcur_proc(l_refcur);
  DBMS_OUTPUT.PUT_LINE('-----------------------');
  open_refcur_proc('Hunold', l_refcur);
  fetch_refcur_proc(l_refcur);  
END;
/

-- [실습] System 계정으로 접속해서 소프트 파스가 일어났는지 확인해봅시다.
SELECT sql_id, hash_value, loaded_versions, executions, sql_text
FROM v$sql
WHERE sql_text LIKE '%USING TEST%';

-- [실습] Nested Table 예외 처리
DECLARE
  -- Nested Table 컬렉션 타입 생성
  TYPE ename_nested_table IS TABLE OF VARCHAR2(5);
  ename_nt ename_nested_table;

  err_msg VARCHAR2(100);
BEGIN
  -- COLLECTION_IS_NULL 예외 
  BEGIN
    -- varray와 nested table 타입 컬렉션에서 초기화하지 않고 사용 시 COLLECTION_IS_NULL 예외 발생
    ename_nt(1) := 10; 
  EXCEPTION
    WHEN COLLECTION_IS_NULL THEN 
      err_msg := SUBSTR(SQLERRM, 1, 100);
      DBMS_OUTPUT.PUT_LINE('COLLECTION_IS_NULL Exception : ' || err_msg);
  END;
  
  -- VALUE_ERROR 예외 #1
  -- 3개의 값을 입력하며 초기화
  ename_nt := ename_nested_table('A', 'B', 'C'); 
  
  BEGIN
    -- 지정된 크기보다 큰 값을 입력 시 VALUE_ERROR 예외 발생
    ename_nt(3) := 'ABCDEFG'; 
  EXCEPTION
    WHEN VALUE_ERROR THEN
      err_msg := SUBSTR(SQLERRM, 1, 100);
      DBMS_OUTPUT.PUT_LINE('VALUE_ERROR Exception : ' || err_msg);
  END;
  
  -- VALUE_ERROR 예외 #2
  BEGIN
    -- nested table의 경우 첨자에 정수가 아닌 값이 사용 시
    ename_nt('A') := 'ABC'; 
  EXCEPTION
    WHEN VALUE_ERROR THEN 
      err_msg := SUBSTR(SQLERRM, 1, 100);
      DBMS_OUTPUT.PUT_LINE('VALUE_ERROR Exception : ' || err_msg);
  END;  

  -- SUBSCRIPT_OUTSIDE_LIMIT 예외
  BEGIN
    -- 첨자 0은 범위안에 없음
    ename_nt(0) := 'zero'; 
  EXCEPTION
    WHEN SUBSCRIPT_OUTSIDE_LIMIT THEN 
      err_msg := SUBSTR(SQLERRM, 1, 100);
      DBMS_OUTPUT.PUT_LINE('SUBSCRIPT_OUTSIDE_LIMIT Exception : ' || err_msg);
  END;  

  -- SUBSCRIPT_BEYOND_COUNT 예외
  BEGIN
    -- subscript (4)는 요소의 수를 초과하였음.
    -- 새로운 요소를 추가하기 위해서는 extend를 수행해야함
    ename_nt(4) := 'maybe'; -- Raises SUBSCRIPT_BEYOND_COUNT
  EXCEPTION
    WHEN SUBSCRIPT_BEYOND_COUNT THEN 
      err_msg := SUBSTR(SQLERRM, 1, 100);
      DBMS_OUTPUT.PUT_LINE('SUBSCRIPT_BEYOND_COUNT Exception : ' || err_msg);
  END;  

  -- NO_DATA_FOUND 예외
  BEGIN
    -- 삭제된 요소를 액세스할 경우
    ename_nt.DELETE(1);
    IF ename_nt(1) = 'First' THEN 
       NULL; 
    END IF;   

  EXCEPTION
    WHEN NO_DATA_FOUND THEN 
      err_msg := SUBSTR(SQLERRM, 1, 100);
      DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND Exception : ' || err_msg);
  END;
END;
/

-- [실습] Nested Table
DECLARE
  -- 커서 선언
  CURSOR emp_cur IS SELECT * FROM employees;
  
  l_cnt NUMBER(3) NOT NULL := 1;
  i     NUMBER(4) := 1;

  -- Nested Table 컬렉션 타입  정의 
  -- emp_cur 커서의 타입으로 선언
  TYPE emp_nested_table IS TABLE OF emp_cur%ROWTYPE;  
  
  -- 컬렉션 변수 초기화
  emp_nt emp_nested_table := emp_nested_table(); 
  
BEGIN
  -- LIMIT 확인. nested table은 NULL임
  DBMS_OUTPUT.PUT_LINE('[Limit]');   
  DBMS_OUTPUT.PUT_LINE('emp_nt.limit : '|| emp_nt.LIMIT);  
  
  -- 컬렉션 EXTEND
  -- emp_cur 커서의 결과를 컬렉션과 Loop를 이용하여 저장
  -- extend 함수를 이용하여 요소 크기를 증가시킨 후 값 입력
  FOR emp_rec IN emp_cur LOOP
    emp_nt.EXTEND;                  
    emp_nt(l_cnt) := emp_rec;  
    l_cnt := l_cnt + 1;    
  END LOOP;   
   
  -- Count
  -- 저장되어 있는 요소의 개수 반환
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[Count #1]'); 
  DBMS_OUTPUT.PUT_LINE('emp_nt.count : '|| emp_nt.COUNT); -- emp_nt.count : 107

  -- Nested Table 에서 요소 조회 
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[List #1]');
   
  -- FIRST, LAST 함수를 이용하여 배열의 요소간 이동
  FOR i IN emp_nt.FIRST..emp_nt.LAST LOOP   
    DBMS_OUTPUT.PUT('subscript : '||i||' -> ');
    DBMS_OUTPUT.PUT_LINE(emp_nt(i).employee_id||', '||emp_nt(i).salary);
  END LOOP;      
   
  -- 컬렉션 요소 삭제
  -- Nested Table에서 존재 여부 확인 후 일부 요소 삭제 
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[Delete(5,8)]');
  IF emp_nt.EXISTS(8) THEN     
     emp_nt.DELETE(5,8);
  END IF;
      
  -- 컬렉션 요소 삭제 후 재 Count
  -- delete된 요소를 제외한 저장되어 있는 요소의 개수 반환
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[Count #2]'); 
  DBMS_OUTPUT.PUT_LINE('emp_nt.count : '|| emp_nt.COUNT); 
   
  -- Nested Table 에서 요소 조회 
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[List #2]');
    
   
  -- 삭제되어 존재하지 않는 요소 조회 시 예외 발생 
  BEGIN      
    FOR i in emp_nt.FIRST .. emp_nt.LAST LOOP
      DBMS_OUTPUT.PUT('subscript : '||i||' -> ');
      DBMS_OUTPUT.PUT_LINE(emp_nt(i).employee_id||','||emp_nt(i).salary);
    END LOOP;
  EXCEPTION
    WHEN no_data_found THEN
      DBMS_OUTPUT.PUT_LINE('[Exception : no_data_found]');
    WHEN others THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM(SQLCODE));
  END;
   
  -- Nested Table 에서 요소 조회 
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[List #3]');
   
  -- FIRST, LAST, NEXT 함수를 이용하여 삭제된 요소를 건너뛰어 조회
  BEGIN      
    i := emp_nt.FIRST;
  
    LOOP
      DBMS_OUTPUT.PUT('subscript : '|| i ||' -> ');
      DBMS_OUTPUT.PUT_LINE(emp_nt(i).employee_id||', '||emp_nt(i).salary);	       

      EXIT WHEN i = emp_nt.LAST;
	  
      i := emp_nt.NEXT(i);
    END LOOP;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('[Exception : NO_DATA_FOUND]');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM(SQLCODE));
  END;    
   
END;   
/

-- [실습] VARRAY
DECLARE
  CURSOR emp_cur IS
    SELECT * FROM employees;
  
  l_cnt NUMBER(3) NOT NULL := 1;
  i     NUMBER(4) := 1;
  
  -- Varray의 경우 선언 시 사이즈 지정이 필요함
  -- emp_cur 커서 타입의 컬렉션을 생성함
  TYPE emp_varray IS VARRAY(10) OF emp_cur%ROWTYPE;   
  
  -- 컬렉션 변수 초기화
  emp_va emp_varray := emp_varray(); 
  
BEGIN
  -- LIMIT 확인
  DBMS_OUTPUT.PUT_LINE('[Limit]');      
  DBMS_OUTPUT.PUT_LINE('emp_va.limit : '||emp_va.LIMIT); 
    
  -- 컬렉션 EXTEND
  -- emp_cur 커서의 결과를 컬렉션과 Loop를 이용하여 저장
  -- varray의 경우 limit 함수를 이용해 limit 도달 여부를 확인한 후에 extend해야 함
  FOR emp_rec IN emp_cur LOOP
    IF l_cnt <= emp_va.LIMIT THEN   
      emp_va.EXTEND;               
      emp_va(l_cnt) := emp_rec;
    END IF;
       
    l_cnt := l_cnt + 1;    
  END LOOP;
  
  -- emp_va.EXTEND;      -- ORA-06532: Subscript outside of limit
     
  -- Count
  -- 저장되어 있는 요소의 개수 반환
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[Count #1]'); 
  DBMS_OUTPUT.PUT_LINE('emp_va.count : '||emp_va.COUNT); 
   
  -- Varray 에서 요소 조회
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[List #1]');
    
  -- FIRST, LAST 함수를 이용하여 배열의 요소간 이동
  FOR i IN emp_va.FIRST .. emp_va.LAST LOOP     
    DBMS_OUTPUT.PUT('subscript : '||i||' -> ');
    DBMS_OUTPUT.PUT_LINE(emp_va(i).employee_id||', '||emp_va(i).salary);
  END LOOP;
   
  -- 컬렉션 요소 삭제
  -- Varrary는 삭제하려면 모두 삭제해야 함(부분 삭제 불가)
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[Delete]');
  emp_va.DELETE;   
   
  -- 컬렉션 요소 삭제 후 재 Count
  -- 저장되어 있는 요소의 개수 반환
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[Count #2]'); 
  DBMS_OUTPUT.PUT_LINE('emp_va.count : '||emp_va.COUNT); 
   
  -- Varray 에서 요소 조회 
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[List #2]');
    
  -- Varray  조회 - 모두 삭제되어 조회 시 에러 발생 
  BEGIN   
    FOR i IN emp_va.FIRST .. emp_va.LAST LOOP
      DBMS_OUTPUT.PUT('subscript : '||i||' -> ');
      DBMS_OUTPUT.PUT_LINE(emp_va(i).employee_id||','||emp_va(i).salary);
    END LOOP;
  EXCEPTION
    WHEN value_error THEN
      DBMS_OUTPUT.PUT_LINE('[Exception : value_error]');
    WHEN others THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM(SQLCODE));
  END;

END;   
/

-- [실습] VARRAY
DECLARE
  CURSOR emp_cur IS
    SELECT * FROM employees;
  
  l_cnt NUMBER(3) NOT NULL := 1;
  i     NUMBER(4) := 1;
  
  -- Varray의 경우 선언 시 사이즈 지정이 필요함
  -- emp_cur 커서 타입의 컬렉션을 생성함
  TYPE emp_varray IS VARRAY(10) OF emp_cur%ROWTYPE;   
  
  -- 컬렉션 변수 초기화
  emp_va emp_varray := emp_varray(); 
  
BEGIN
  -- LIMIT 확인
  DBMS_OUTPUT.PUT_LINE('[Limit]');      
  DBMS_OUTPUT.PUT_LINE('emp_va.limit : '||emp_va.LIMIT); 
    
  -- 컬렉션 EXTEND
  -- emp_cur 커서의 결과를 컬렉션과 Loop를 이용하여 저장
  -- varray의 경우 limit 함수를 이용해 limit 도달 여부를 확인한 후에 extend해야 함
  FOR emp_rec IN emp_cur LOOP
    IF l_cnt <= emp_va.LIMIT THEN   
      emp_va.EXTEND;               
      emp_va(l_cnt) := emp_rec;
    END IF;
       
    l_cnt := l_cnt + 1;    
  END LOOP;
  
  -- emp_va.EXTEND;      -- ORA-06532: Subscript outside of limit
     
  -- Count
  -- 저장되어 있는 요소의 개수 반환
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[Count #1]'); 
  DBMS_OUTPUT.PUT_LINE('emp_va.count : '||emp_va.COUNT); 
   
  -- Varray 에서 요소 조회
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[List #1]');
    
  -- FIRST, LAST 함수를 이용하여 배열의 요소간 이동
  FOR i IN emp_va.FIRST .. emp_va.LAST LOOP     
    DBMS_OUTPUT.PUT('subscript : '||i||' -> ');
    DBMS_OUTPUT.PUT_LINE(emp_va(i).employee_id||', '||emp_va(i).salary);
  END LOOP;
   
  -- 컬렉션 요소 삭제
  -- Varrary는 삭제하려면 모두 삭제해야 함(부분 삭제 불가)
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[Delete]');
  emp_va.DELETE;   
   
  -- 컬렉션 요소 삭제 후 재 Count
  -- 저장되어 있는 요소의 개수 반환
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[Count #2]'); 
  DBMS_OUTPUT.PUT_LINE('emp_va.count : '||emp_va.COUNT); 
   
  -- Varray 에서 요소 조회 
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[List #2]');
    
  -- Varray  조회 - 모두 삭제되어 조회 시 에러 발생 
  BEGIN   
    FOR i IN emp_va.FIRST .. emp_va.LAST LOOP
      DBMS_OUTPUT.PUT('subscript : '||i||' -> ');
      DBMS_OUTPUT.PUT_LINE(emp_va(i).employee_id||','||emp_va(i).salary);
    END LOOP;
  EXCEPTION
    WHEN value_error THEN
      DBMS_OUTPUT.PUT_LINE('[Exception : value_error]');
    WHEN others THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM(SQLCODE));
  END;

END;   
/

-- [실습] Associative Array
DECLARE
  CURSOR emp_cur IS
    SELECT * FROM employees;
  
  l_cnt NUMBER(3) NOT NULL := 1;
  i     NUMBER(4) := 1;
  
  -- Index by Table타입의 컬렉션 타입 생성
  -- emp_cur 커서 타입의 컬렉션 타입을 생성함
  TYPE emp_indexby_table IS TABLE OF emp_cur%ROWTYPE 
          INDEX BY PLS_INTEGER;
  
  -- Index by Table은 초기화할 수 없음(= 컬렉션 생성자 없음)
  emp_it emp_indexby_table;
  
BEGIN
  -- LIMIT 확인
  DBMS_OUTPUT.PUT_LINE('[Limit]');
  DBMS_OUTPUT.PUT_LINE('emp_it.limit : '||emp_it.LIMIT); 
  
  -- 컬렉션 EXTEND
  -- Index-by table의 경우 extend 함수를 이용하여 확장이 필요없음
  -- Nested table, varray와 달리 첨자가 순차적으로 증가하는 정수 값이 아니어도 무방함
  -- 여기에서는 employee_id 값을 인덱스로 사용하여 요소에 값을 저장함 
  FOR emp_rec IN emp_cur LOOP      
    emp_it(emp_rec.employee_id) := emp_rec; 
       
    l_cnt := l_cnt + 1;    
  END LOOP;
  
  -- Count
  -- 저장되어 있는 요소의 개수 반환
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[Count #1]'); 
  DBMS_OUTPUT.PUT_LINE('emp_it.count : '||emp_it.COUNT); 
   
  -- Index by Table 에서 요소 조회 
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[List #1]');
   
  -- Index-by Table 에서 요소간 이동 #1
  -- Index-by Table과 FOR LOOP, FIRST/LAST 함수를 사용하여 값 출력
  -- 일련번호가 아닌 employee_id를 인덱스로 사용함에 따라 FIRST/LAST 사용 시 잘못된 인덱스 키 값 사용으로 인한 에러가 발생하게 됨
  --   subscript : 3 -> emp_it : no_data_found   
  BEGIN
    DBMS_OUTPUT.PUT_LINE('[emp_it list test #1]');  
     
    FOR i in emp_it.FIRST..emp_it.LAST LOOP 
      DBMS_OUTPUT.PUT('subscript : '||i||' -> ');
      DBMS_OUTPUT.PUT_LINE(emp_it(i).employee_id||', '||emp_it(i).salary);
    END LOOP;
  EXCEPTION
    WHEN no_data_found THEN
      DBMS_OUTPUT.PUT_LINE('emp_it : no_data_found');
    WHEN others THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM(SQLCODE));
  END;
    
  -- Index by Table 에서 요소 조회
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[List #2]');
   
  --   사원번호 값을 인덱스 키 값으로 사용하여 정상적으로 출력
  BEGIN
    FOR emp_rec IN emp_cur LOOP
      DBMS_OUTPUT.PUT('subscript : '||emp_rec.employee_id||' -> ');
      DBMS_OUTPUT.PUT_LINE(emp_it(emp_rec.employee_id).employee_id||', '||emp_it(emp_rec.employee_id).salary);
    END LOOP;
  EXCEPTION
    WHEN no_data_found THEN
      DBMS_OUTPUT.PUT_LINE('emp_it : no_data_found');
    WHEN others THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM(SQLCODE));
  END;

  -- 컬렉션 요소 삭제
  -- Index-by Table에서 존재 여부 확인 후 일부 요소 삭제
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[Delete(200)]');
   
  IF emp_it.EXISTS(200) THEN  
    emp_it.DELETE(200);
  END IF;
   
  -- Count
  -- 저장되어 있는 요소의 개수 반환
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[Count #2]'); 
  DBMS_OUTPUT.PUT_LINE('emp_it.count : '||emp_it.COUNT); 
   
  -- Index by Table 에서 요소 조회
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[List #3]');
   
  -- Index-by Table과 FOR LOOP, FIRST, LAST, NEXT 함수를 사용하여 값 출력
  BEGIN       
    i := emp_it.FIRST;
   
    LOOP
      DBMS_OUTPUT.PUT('subscript : '|| i ||' -> ');
      DBMS_OUTPUT.PUT_LINE(emp_it(i).employee_id||', '||emp_it(i).salary);	       

      EXIT WHEN i = emp_it.LAST;

      i := emp_it.NEXT(i);
    END LOOP;
  END;   

END;   
/











