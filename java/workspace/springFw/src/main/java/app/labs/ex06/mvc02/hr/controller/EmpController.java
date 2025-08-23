package app.labs.ex06.mvc02.hr.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import app.labs.ex06.mvc02.hr.model.Emp;
import app.labs.ex06.mvc02.hr.service.IEmpService;

@Controller
public class EmpController {
	
	@Autowired
	IEmpService empService;
	
	@RequestMapping(value="/hr/count")
	public String empCount(@RequestParam(value="deptid", required=false, defaultValue="0") int deptId, Model model) {
		
		int cnt = 0;
		
		if (deptId == 0) {
			cnt = empService.getEmpCount();
		} 
		else {
			cnt = empService.getEmpCount(deptId);
		}
		
		// Request Scope
		model.addAttribute("count", cnt);
		
		return "hr/count";
	}
	
	
	/*
	 * POJO 메서드 
	 * 사원 전체 조회
	 */
	@RequestMapping(value="/hr/list")
	public String getAllEmps(Model model) {
		
		List<Emp> list = empService.getEmpList();
		model.addAttribute("empList", list);
		
		return "hr/list";
	}
	
	/*
	 * 사원 상세 조회
	 * 사원번호 변수로 받음 (employeeId)
	 * @PathVariable: 자원의 위치를 uri로 표현 (요즘 많이 사용)
	 */
	@RequestMapping(value="/hr/{employeeId}")
	public String getEmpInfo(@PathVariable int employeeId, Model model) {
		
		Emp emp = empService.getEmpInfo(employeeId);
		model.addAttribute("emp", emp);
		
		return "hr/view";
	}
	
	/*
	 * 신규 사원 등록
	 */
	@RequestMapping(value="/hr/insert")
	public String insertEmp(Model model) {
		return "hr/insertForm";
	}
}
