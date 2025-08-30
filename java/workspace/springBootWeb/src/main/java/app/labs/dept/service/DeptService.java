package app.labs.dept.service;

import java.util.List;
import app.labs.dept.model.Dept;

public interface DeptService {
	int getDeptCount();
	int getDeptCount(int deptNo);
	
	List<Dept> getDeptList();
	Dept getDeptInfo(int deptNo);

	// CRUD
	void insertDept(Dept dept);
	void updateDept(Dept dept);
	int deleteDept(int deptNo);
}
