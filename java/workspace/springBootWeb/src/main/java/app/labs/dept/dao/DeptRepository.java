package app.labs.dept.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import app.labs.dept.model.Dept;

@Mapper
public interface DeptRepository {
	int getDeptCount();
	int getDeptCount(int deptNo);
	
	List<Dept> getDeptList();
	Dept getDeptInfo(int deptNo);

	// CRUD
	void insertDept(Dept dept);
	void updateDept(Dept dept);
	int deleteDept(@Param("deptNo") int deptNo);
}
