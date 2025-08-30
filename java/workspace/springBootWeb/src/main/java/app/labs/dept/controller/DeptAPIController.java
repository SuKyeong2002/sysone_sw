package app.labs.dept.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import app.labs.dept.model.Dept;
import app.labs.dept.service.DeptService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
// Controller -> RestController
@RestController
@RequestMapping("api/depts")
public class DeptAPIController {
	
	// 타입 1개 -> 자동 Autowired, 명확히 하고자 기입
	private DeptService deptService;
	
	// 생성자
	public DeptAPIController(DeptService deptService) {
		this.deptService = deptService;
		
	}
	
	@GetMapping({"index", "main"})
	public ModelAndView getViews(Model model) {
		ModelAndView mv = new ModelAndView("api/list");
		return mv;
	}
	
	// return 자원 위주로 생각하기
	@GetMapping("/")
	Map<String, Object>  getAllDepts() {
		Map<String, Object> resultMap = new HashMap<>();
	
		List<Dept> deptList = deptService.getDeptList();
		
		resultMap.put("deptList", deptList);

		return resultMap;
	}
	
	@GetMapping("/{deptno}")
	Dept getDeptInfo(@PathVariable("deptno") int deptno) {
		Dept dept = deptService.getDeptInfo(deptno);
		
		return dept;
	}
	
	// post = insert
	@PostMapping("/")
	Map<String, Object> insertDept(Dept dept) {
		// ResponseEntity
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			deptService.insertDept(dept);
			// 코드랑 같이 보내기도 함
			// resultMap.put("code", 200);
			resultMap.put("message", dept.getDeptNo() + "번 부서가 등록되었습니다.");
		}
		catch(RuntimeException ex) {
			resultMap.put("message", ex.getMessage());
		}
		
		return resultMap;
	}
	
	// update = put
	@PutMapping("/")
	Map<String, Object> updateDept(Dept dept) {
		Map<String, Object> resultMap = new HashMap<>();

		try {
			deptService.updateDept(dept);
			resultMap.put("message", dept.getDeptNo() + "번 부서가 수정되었습니다.");
		}
		catch(RuntimeException ex) {
			resultMap.put("message", ex.getMessage());
		}
		
		return resultMap;
	}
	
	@DeleteMapping("/{deptno}")
	Map<String, Object> deleteDept(@PathVariable("deptno") int deptno, Model model) {
		Map<String, Object> resultMap = new HashMap<>();

		try {
			int cnt = deptService.deleteDept(deptno);
			
			if (cnt > 0) {
				resultMap.put("message", deptno + "번 부서가 삭제되었습니다.");
			}
			else {
				resultMap.put("message", "부서번호가 다릅니다.");
			}
		}
		catch(RuntimeException ex) {
			resultMap.put("message", ex.getMessage());
		}
		
		return resultMap;
	}
}
