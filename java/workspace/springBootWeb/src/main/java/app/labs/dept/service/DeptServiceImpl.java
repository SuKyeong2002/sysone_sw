package app.labs.dept.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import app.labs.dept.dao.DeptRepository;
import app.labs.dept.model.Dept;

@Service
public class DeptServiceImpl implements DeptService {

	@Autowired
	DeptRepository deptRepository;
	
	@Override
	public int getDeptCount() {
		return deptRepository.getDeptCount();
	}

	@Override
	public int getDeptCount(int deptNo) {
		return deptRepository.getDeptCount(deptNo);
	}

	@Override
	public List<Dept> getDeptList() {
		return deptRepository.getDeptList();
	}

	@Override
	public Dept getDeptInfo(int deptNo) {
		return deptRepository.getDeptInfo(deptNo);
	}

	@Override
	public void insertDept(Dept dept) {
		deptRepository.insertDept(dept);
	}

	@Override
	public void updateDept(Dept dept) {
		deptRepository.updateDept(dept);
	}

	@Override
	public int deleteDept(int deptNo) {
		return deptRepository.deleteDept(deptNo);
	}

}
