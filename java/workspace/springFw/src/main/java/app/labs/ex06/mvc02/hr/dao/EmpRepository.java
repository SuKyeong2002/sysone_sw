package app.labs.ex06.mvc02.hr.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import app.labs.ex06.mvc02.hr.model.Emp;


@Repository
public class EmpRepository implements IEmpRepository {
	
	// PSA를 이용한 JDBC
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	/*
	 * RowMapper
	 * table row 1개와 empvo를 컬럼명과 프로퍼티, 데이터 타입을 매칭하는 인터페이스
	 */
	private class EmpMapper implements RowMapper<Emp> {

		// 행 반환 -> 서로 다른 값 반환 
		@Override
		public Emp mapRow(ResultSet rs, int rowNum) throws SQLException {
			// EmpVO 객체 생성 (주솟값 저장)
			Emp emp = new Emp();
		
			// 테이블 구조랑 동일 (= 엔터티 또는 도메인)
			emp.setEmployeeId(rs.getInt("EMPLOYEE_ID"));
			emp.setFirstName(rs.getString("FIRST_NAME"));
			emp.setLastName(rs.getString("LAST_NAME"));
			emp.setEmail(rs.getString("EMAIL"));
			emp.setPhoneNumber(rs.getString("PHONE_NUMBER"));
			emp.setHireDate(rs.getDate("HIRE_DATE"));
			emp.setJobId(rs.getString("JOB_ID"));
			emp.setSalary(rs.getDouble("SALARY"));
			emp.setCommissionPct(rs.getDouble("COMMISSION_PCT"));
			emp.setManagerId(rs.getInt("MANAGER_ID"));
			emp.setDepartmentId(rs.getInt("DEPARTMENT_ID"));
			
			return emp;
		}
		
	}

	@Override
	public int getEmpCount() {
		String sql = "select count(*) from employees";
		return jdbcTemplate.queryForObject(sql, Integer.class);
	}

	// 매개변수: deptId -> return 에도 추가
	@Override
	public int getEmpCount(int deptId) {
		String sql = "select count(*) from employees where department_id = ?";
		return jdbcTemplate.queryForObject(sql, Integer.class, deptId);
	}

	// EmpMapper 사용
	@Override
	public List<Emp> getEmpList() {
		String sql = "select * from employees";
		return jdbcTemplate.query(sql, new EmpMapper());
	}

	// 결과값 하나 보장 <- EMPLOYEE_ID 중복 허용 x
	@Override
	public Emp getEmpInfo(int empId) {
		String sql = "select * from employees where employee_id = ?";
		return jdbcTemplate.queryForObject(sql, new EmpMapper(), empId);
	}

	@Override
	public void insertEmp(Emp emp) {
		String sql = "insert into employees"
				+ "(employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)"
				+ "VALUES (?, ?, ?, ?, ?, sysdate, ?, ?, ?, ?, ?)";
		
		jdbcTemplate.update(sql, 
				emp.getEmployeeId(),
                  emp.getFirstName(),
                  emp.getLastName(),
                  emp.getEmail(),
                  emp.getPhoneNumber(),
                  emp.getJobId(),
                  emp.getSalary(),
                  emp.getCommissionPct(),
                  emp.getManagerId(),
                  emp.getDepartmentId());
	}
	
	@Override
	public void updateEmp(Emp emp) {
	    String sql = """
	            update employees
	            set first_name=?, last_name=?, email=?, phone_number=?, 
	                hire_date=?, job_id=?, salary=?, commission_pct=?, 
	                manager_id=?, department_id=?
	            where employee_id=?
	            """;

	    jdbcTemplate.update(sql,
	            emp.getFirstName(),
	            emp.getLastName(),
	            emp.getEmail(),
	            emp.getPhoneNumber(),
	            emp.getHireDate(),
	            emp.getJobId(),
	            emp.getSalary(),
	            emp.getCommissionPct(),
	            emp.getManagerId(),
	            emp.getDepartmentId(),
	            emp.getEmployeeId()
	    );
	}

	@Override
	public int deleteEmp(int empId, String email) {
		String sql = "delete from employees where employee_id=? and email=?";
		return jdbcTemplate.update(sql, empId, email);
	}

	@Override
	public void deleteJobHistory(int empId) {
		String sql = "delete from job_history where employee_id=?";
		jdbcTemplate.update(sql, empId);
	}

	@Override
	public List<Map<String, Object>> getAllDeptId() {
		String sql = "select DEPARTMENT_ID as departmentId, DEPARTMENT_NAME as departmentName from departments";
		return jdbcTemplate.queryForList(sql);
	}

	@Override
	public List<Map<String, Object>> getAllJobId() {
		String sql = "select JOB_ID as job_id, JOB_TITLE as job_title from jobs";
		return jdbcTemplate.queryForList(sql);
	}

	@Override
	public List<Map<String, Object>> getAllManagerId() {
		String sql = """
				select distinct e1.manager_id as manager_id, e2.first_name as manager_name
				from employees e1
				join employees e2 on e2.employee_id = e1.manager_id
				order by manager_name
				""";
		return jdbcTemplate.queryForList(sql);
	}
}
