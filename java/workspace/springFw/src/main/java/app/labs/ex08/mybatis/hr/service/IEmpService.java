package app.labs.ex08.mybatis.hr.service;

import java.util.List;
import java.util.Map;

import app.labs.ex08.mybatis.hr.model.Emp;


public interface IEmpService {
	int getEmpCount();
	int getEmpCount(int deptId);
	
	List<Emp> getEmpList();
	Emp getEmpInfo(int empId);

	// CRUD
	void insertEmp(Emp emp);
	void updateEmp(Emp emp);
	int deleteEmp(int empId, String email);
	
	// 제약조건
	List<Map<String, Object>> getAllDeptId();
	List<Map<String, Object>> getAllJobId();
	List<Map<String, Object>> getAllManagerId();
}
