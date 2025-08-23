package app.labs.ex06.mvc02.hr;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

	/*
	 * 일반 메서드
	 * HandlerMapping에게 url/controller:Method 등록
	 */
	@RequestMapping(value="/")
	public String home(Model model, Locale locale) {
		model.addAttribute("severTime", "서버시간");
		
		return "home";
	}
}
