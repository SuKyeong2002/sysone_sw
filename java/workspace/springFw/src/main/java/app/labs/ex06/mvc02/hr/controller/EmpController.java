package app.labs.ex06.mvc02.hr.controller;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import app.labs.ex06.mvc02.hr.model.Emp;
import app.labs.ex06.mvc02.hr.service.IEmpService;
import groovy.util.logging.Slf4j;
import jakarta.servlet.http.HttpServletRequest;

@Slf4j
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
	 * 신규 사원 등록 입력폼
	 * method=RequestMethod.GET 추가
	 */
	@RequestMapping(value="/hr/insert", method=RequestMethod.GET)
	public String insertEmp(Model model) {
		
		model.addAttribute("deptList", empService.getAllDeptId());
		model.addAttribute("jobList", empService.getAllJobId());
		model.addAttribute("managerList", empService.getAllManagerId());
		
		return "hr/insertForm";
	}
	
	/*
	 * 신규 사원 등록 요청
	 */
	@RequestMapping(value="/hr/insert", method=RequestMethod.POST)
	public String insertEmp(Emp emp, RedirectAttributes redirectAttributes) {
		
		try {
			empService.insertEmp(emp);
			redirectAttributes.addFlashAttribute("message", emp.getEmployeeId() + "번 사원정보가 등록되었습니다.");
		} catch(RuntimeException ex) {
			redirectAttributes.addFlashAttribute("message", ex);
		}
		
		return "redirect:/hr/list";
	}
	
	/*
	 * 신규 사원 수정 
	 */
	@RequestMapping(value="/hr/update",method=RequestMethod.GET)
	public String updateEmp(int empid, Model model) {
		
		model.addAttribute("emp", empService.getEmpInfo(empid));
		model.addAttribute("deptList", empService.getAllDeptId());
		model.addAttribute("jobList", empService.getAllJobId());
		model.addAttribute("managerList", empService.getAllManagerId());
		
		return "hr/updateForm";
	}
	
	/*
	 * 신규 사원 수정 요청
	 */
	@RequestMapping(value="/hr/update", method=RequestMethod.POST)
	public String updateEmp(Emp emp, RedirectAttributes redirectAttributes) {
		
		try {
			empService.updateEmp(emp);
			redirectAttributes.addFlashAttribute("message", emp.getEmployeeId() + "번 사원정보가 수정되었습니다.");
		} catch(RuntimeException ex) {
			redirectAttributes.addFlashAttribute("message", ex);
		}
		
		return "redirect:/hr/list";
	}
	
	/*
	 * 신규 사원 삭제 
	 */
	@RequestMapping(value="/hr/delete", method=RequestMethod.GET)
	public String deleteEmp(int empid, Model model) {
		
		model.addAttribute("emp", empService.getEmpInfo(empid));
		
		return "hr/deleteForm";
	}
	
	/*
	 * 신규 사원 수정 요청
	 */
	@RequestMapping(value="/hr/delete", method=RequestMethod.POST)
	public String deleteEmp(int employeeId, String email, Model model, RedirectAttributes redirectAttributes) {
		
		try {
			int cnt = empService.deleteEmp(employeeId, email);
			
			if (cnt > 0) {
				redirectAttributes.addFlashAttribute("message", employeeId+ "번 사원정보가 삭제되었습니다.");
			} else {
				model.addAttribute("emp", empService.getEmpInfo(employeeId));
				model.addAttribute("message", "사번 또는 이메일 주소가 다릅니다.");
				
				return "hr/deleteForm";
			}
			
		} catch(RuntimeException ex) {
			redirectAttributes.addFlashAttribute("message", ex);
		}
		
		return "redirect:/hr/list";
	}
	
	/*
	 * 에러 페이지 
	@ExceptionHandler({SQLException.class, RuntimeException.class})
	public String runtimeException(HttpServletRequest request, Exception ex, Model model) {
		model.addAttribute("url", request.getRequestURI());
		model.addAttribute("exception", ex);
		
		return "error/runtime";
	}
	*/
		
	/*
	 * json로 사원 목록 조회
	 */
	@RequestMapping(value="/hr/json")
	public @ResponseBody List<Emp> getEmpListJson() {
		return empService.getEmpList();
	}
	
	/*
	 * json로 특정 사원 조회
	 */
	@RequestMapping(value="/hr/json/{employeeId}")
	public @ResponseBody Emp getEmpInfoJson(@PathVariable int employeeId, Model model) {	
		Emp emp = empService.getEmpInfo(employeeId);
		
		return emp;
	}
}
