package app.labs.ex06.mvc01;

import jakarta.servlet.RequestDispatcher;
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
		processServlet(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processServlet(request, response);
	}
	
	private void processServlet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); // 인코딩설정

        // 요청 URI를 반환 
        String command = request.getRequestURI();

        // URI에서 컨텍스트 이름 제거
        if (command.indexOf(request.getContextPath()) == 0) {
            command = command.substring(request.getContextPath().length());
        }

        // URI를 이용해서 맵으로부터 커맨드핸들러 객체를 찾는다.
        CommandHandler handler = commandHandlerMap.get(command);
        if (handler == null) {
            handler = new NullHandler();
        }

        String viewPage = null;
        try {
            // process()는 명령을 처리하고 뷰페이지를 반환한다.
            viewPage = handler.process(request, response);
            if ((viewPage != null) && (viewPage.indexOf("redirect:") == 0)) {
                // 뷰 이름 앞에 redirect:가 붙으면 sendRedirect 한다.
                viewPage = viewPage.substring(9);
                response.sendRedirect(request.getContextPath() + viewPage);
                return;
            }
        } catch (Throwable e) {
            throw new ServletException(e);
        }

        // 뷰로 포워드 시킨다.
        if (viewPage != null) {
            viewPage = "/WEB-INF/views/mvc01/" + viewPage;
        } else {
            viewPage = "index.jsp";
        }
        
        RequestDispatcher disp = request.getRequestDispatcher(viewPage);
        disp.forward(request, response);
	}

}
