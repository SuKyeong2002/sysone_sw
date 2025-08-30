package app.labs.ex08.mybatis.hr.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import app.labs.ex08.mybatis.hr.model.Emp;

public interface IEmpRepository {
	// returnType methodName (parameterType)
	// resultType id parameterType
	
	int getEmpCount();
	int getEmpCount(int deptId);
	
	List<Emp> getEmpList();
	Emp getEmpInfo(int empId);

	// CRUD
	void insertEmp(Emp emp);
	void updateEmp(Emp emp);
	int deleteEmp(@Param("empId") int empId, @Param("email") String email);
	
	void deleteJobHistory(int empId);
	
	// 제약조건
	List<Map<String, Object>> getAllDeptId();
	List<Map<String, Object>> getAllJobId();
	List<Map<String, Object>> getAllManagerId();
}
