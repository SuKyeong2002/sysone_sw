package app.labs.ex06.mvc02.hr.dao;

import java.util.List;
import java.util.Map;

import app.labs.ex06.mvc02.hr.model.Emp;

public interface IEmpRepository {
	int getEmpCount();
	int getEmpCount(int deptId);
	
	List<Emp> getEmpList();
	Emp getEmpInfo(int empId);

	// CRUD
	void insertEmp(Emp emp);
	void updateEmp(Emp emp);
	int deleteEmp(int empId, String email);
	
	void deleteJobHistory(int empId);
	
	// 제약조건
	List<Map<String, Object>> getAllDeptId();
	List<Map<String, Object>> getAllJobId();
	List<Map<String, Object>> getAllManagerId();
}
