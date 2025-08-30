package app.labs.ex08.mybatis.hr.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import app.labs.ex08.mybatis.hr.dao.IEmpRepository;
import app.labs.ex08.mybatis.hr.model.Emp;

@Service
public class EmpService implements IEmpService {
	
	@Autowired
	IEmpRepository empRepository;

	@Override
	public int getEmpCount() {
		return empRepository.getEmpCount();
	}

	@Override
	public int getEmpCount(int deptId) {
		return empRepository.getEmpCount(deptId);
	}

	@Override
	public List<Emp> getEmpList() {
		return empRepository.getEmpList();
	}

	@Override
	public Emp getEmpInfo(int empId) {
		return empRepository.getEmpInfo(empId);
	}

	@Override
	public void insertEmp(Emp emp) {
		empRepository.insertEmp(emp);

	}

	@Override
	public void updateEmp(Emp emp) {
		empRepository.updateEmp(emp);

	}

	@Override
	@Transactional
	public int deleteEmp(int empId, String email) {
		empRepository.deleteJobHistory(empId);
		int cnt = empRepository.deleteEmp(empId, email);
		
		return cnt;

	}

	@Override
	public List<Map<String, Object>> getAllDeptId() {
		return empRepository.getAllDeptId();
	}

	@Override
	public List<Map<String, Object>> getAllJobId() {
		// TODO Auto-generated method stub
		return empRepository.getAllJobId();
	}

	@Override
	public List<Map<String, Object>> getAllManagerId() {
		// TODO Auto-generated method stub
		return empRepository.getAllManagerId();
	}
}
