package app.labs.ex06.mvc01;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

@WebServlet("/DispatcherServlet")
public class DispatcherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private Map<String, CommandHandler> commandHandlerMap = new HashMap<>();
       
    public DispatcherServlet() {
        super();
    }
    
    public void init() throws ServletException {
    	String configFile = getInitParameter("configFile");

    		// 프로퍼티 객체 생성 
        Properties prop = new Properties();

        // 설정 파일의 절대경로를 찾기
        String configFilePath = getServletContext().getRealPath(configFile);

        // 파일에서 스트림을 통해 프로퍼티를 읽어들인다.
        try (FileReader inStream = new FileReader(configFilePath)) {
            prop.load(inStream);        
        } catch (IOException e) {
        	 throw new ServletException(e);
        }

        // 프로퍼티에서 키 집합을 나열객체로 반환
        Iterator<?> keys = prop.keySet().iterator();
        while (keys.hasNext()) { // 키의 개수만큼 실행

            // 설정 파일 예 /hello.do=mvc.command.hello.HelloHandler
            String command = (String) keys.next(); // 커맨드(URL)
            String handlerClassName = prop.getProperty(command); // 클래스명
            try {
                // 클래스 이름으로 객체를 생성한다.
                Class<?> handlerClass = Class.forName(handlerClassName);
                CommandHandler handlerInstance = (CommandHandler) handlerClass.newInstance();

                // 커맨드와 커맨드객체를 맵에 키, 벨류 쌍으로 저장
                commandHandlerMap.put(command, handlerInstance);
            } catch (ClassNotFoundException | InstantiationException | IllegalAccessException e) {
                throw new ServletException(e);
            }
        }
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
