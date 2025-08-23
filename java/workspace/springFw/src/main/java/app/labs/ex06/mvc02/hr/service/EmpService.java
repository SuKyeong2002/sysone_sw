package app.labs.ex06.mvc02.hr.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import app.labs.ex06.mvc02.hr.dao.IEmpRepository;
import app.labs.ex06.mvc02.hr.model.Emp;

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
		// TODO Auto-generated method stub
		return empRepository.getEmpCount(deptId);
	}

	@Override
	public List<Emp> getEmpList() {
		// TODO Auto-generated method stub
		return empRepository.getEmpList();
	}

	@Override
	public Emp getEmpInfo(int empId) {
		// TODO Auto-generated method stub
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
		// TODO Auto-generated method stub
		return empRepository.getAllDeptId();
	}

	@Override
	public List<Map<String, Object>> getAllJobId() {
		// TODO Auto-generated method stub
		return empRepository.getAllManagerId();
	}

	@Override
	public List<Map<String, Object>> getAllManagerId() {
		// TODO Auto-generated method stub
		return empRepository.getAllManagerId();
	}
}
