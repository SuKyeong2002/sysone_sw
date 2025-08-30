package app.labs.ex01;

import java.util.List;
import java.util.Map;

public interface TemplateService {
	List<String> getList();
	Map<String, String> getMap();
	UserAccount getUserAccount();
}
