package com.hallym.bartender;

import com.hallym.service.service;
import com.hallym.vo.attachVO;
import com.hallym.vo.boardVO;
import com.hallym.vo.bookmarkVO;
import com.hallym.vo.ciVO;
import com.hallym.vo.ingredientsVO;
import com.hallym.vo.refrigeratorVO;
import com.hallym.vo.replyVO;
import com.hallym.vo.userVO;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class HomeController {
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	service service;

	private static final String FILE_PATH = "/var/lib/tomcat8/webapps/user_no_";

	@RequestMapping(value = { "index" }, method = { RequestMethod.GET })
	public void index(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		userVO u = (userVO) session.getAttribute("member");
		if (u != null) {
			model.addAttribute("user", u);
		} else {
			model.addAttribute("user", null);
		}
	}

	@RequestMapping(value = { "writeBoard" }, method = { RequestMethod.GET })
	public void writeBoard(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		userVO u = (userVO) session.getAttribute("member");
		if (u != null) {
			model.addAttribute("user", u);
		} else {
			model.addAttribute("user", null);
		}
	}

	@RequestMapping(value = { "/" }, method = { RequestMethod.GET })
	public void home(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		userVO u = (userVO) session.getAttribute("member");
		if (u != null) {
			model.addAttribute("user", u);
		} else {
			model.addAttribute("user", null);
		}
	}

	@RequestMapping(value = { "about" }, method = { RequestMethod.GET })
	public void about(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		userVO u = (userVO) session.getAttribute("member");
		if (u != null) {
			model.addAttribute("user", u);
		} else {
			model.addAttribute("user", null);
		}
	}

	@RequestMapping(value = { "modifyBoard" }, method = { RequestMethod.GET })
	public void modifyBoard(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		userVO u = (userVO) session.getAttribute("member");
		if (u != null) {
			model.addAttribute("user", u);
		} else {
			model.addAttribute("user", null);
		}
	}
	
	@RequestMapping(value = { "modifyBoard2" }, method = { RequestMethod.GET })
	public void modifyBoard2(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		userVO u = (userVO) session.getAttribute("member");
		if (u != null) {
			model.addAttribute("user", u);
		} else {
			model.addAttribute("user", null);
		}
	}

	@RequestMapping(value = { "myPage" }, method = { RequestMethod.GET })
	public String myPage(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		userVO u = (userVO) session.getAttribute("member");
		if (u != null) {
			model.addAttribute("user", u);
			return "myPage";
		} else {
			model.addAttribute("user", null);
			model.addAttribute("msg", "잘못된 접근입니다.");
			index(request, model);
			return "index";
		}
	}

	@RequestMapping(value = { "board" }, method = { RequestMethod.GET })
	public void board(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		userVO u = (userVO) session.getAttribute("member");
		if (u != null) {
			model.addAttribute("user", u);
		} else {
			model.addAttribute("user", null);
		}
	}
	
	@RequestMapping(value = { "ca" }, method = { RequestMethod.GET })
	public void ca(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		userVO u = (userVO) session.getAttribute("member");
		if (u != null) {
			model.addAttribute("user", u);
		} else {
			model.addAttribute("user", null);
		}
	}

	@RequestMapping(value = { "boardDetail" }, method = { RequestMethod.GET })
	public void boardDetail(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		userVO u = (userVO) session.getAttribute("member");
		if (u != null) {
			model.addAttribute("user", u);
		} else {
			model.addAttribute("user", null);
		}
	}
	
	@RequestMapping(value = { "boardDetail2" }, method = { RequestMethod.GET })
	public void boardDetail2(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		userVO u = (userVO) session.getAttribute("member");
		if (u != null) {
			model.addAttribute("user", u);
		} else {
			model.addAttribute("user", null);
		}
	}

	@RequestMapping(value = { "signUp" }, method = { RequestMethod.GET })
	@ResponseBody
	public int signUp(HttpServletRequest request) throws Exception {
		userVO user = new userVO();
		user.setUser_no(0);
		user.setUser_id(request.getParameter("user_id"));
		if(user.getUser_id().equals("탈퇴한 아이디")) {
			return 0;
		}
		user.setUser_nick(request.getParameter("user_nick"));
		user.setUser_pw(request.getParameter("user_pw"));
		user.setEmail(request.getParameter("email"));
		int result = this.service.signUp(user);
		return result;
	}

	@RequestMapping(value = { "signIn" }, method = { RequestMethod.GET })
	@ResponseBody
	public userVO signIn(HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		logger.info("get login");
		HttpSession session = request.getSession();
		userVO user = new userVO();
		user.setUser_id(request.getParameter("user_id"));
		user.setUser_pw(request.getParameter("user_pw"));
		user.setUser_nick(request.getParameter("user_nick"));
		userVO result = this.service.signIn(user);
		if (result != null && result.getUser_id() != null) {
			session.setAttribute("member", result);
			return result;
		}
		return null;
	}

	@RequestMapping({ "logout" })
	@ResponseBody
	public int logout(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		session.invalidate();
		return 0;
	}

	@RequestMapping({ "srci" })
	@ResponseBody
	public List<ciVO> selectRandomCocktailInfo(Model model) throws Exception {
		List<ciVO> c = this.service.selectRandomCocktailInfo();
		Calendar cal = Calendar.getInstance();
		int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
		String spirit = "";
		switch (dayOfWeek) {
		    case 1:
		    	spirit = "럼";
		        break;
		    case 2:
		    	spirit = "테킬라";
		        break;
		    case 3:
		    	spirit = "보드카";
		        break;
		    case 4:
		    	spirit = "진";
		        break;
		    case 5:
		    	spirit = "위스키";
		        break;
		    case 6:
		    	spirit = "리큐르";
		        break;
		    case 7:
		    	spirit = "과일주";
		        break;
		}
		c.get(0).setSpirit(spirit);
		return c;
	}

	@RequestMapping({ "selectCocktail" })
	@ResponseBody
	public ciVO selectCocktail(Model model, HttpServletRequest request) throws Exception {
		String cocktail_name = request.getParameter("cocktail_name");
		ciVO c = this.service.selectCocktail(cocktail_name);
		return c;
	}
	
	@RequestMapping({ "lc" })
	@ResponseBody
	public List<ciVO> lc(Model model, HttpServletRequest request) throws Exception {
		String spirits = request.getParameter("spirit");
		List<ciVO> data = this.service.lc(spirits);
		List<ciVO> result = new ArrayList<ciVO>();
		List<Integer> arr = new ArrayList<Integer>();
		for (int i = 0; i < data.size(); i++) {
            if (!arr.contains(data.get(i).getCocktail_no())) {
                result.add(data.get(i));
                arr.add(data.get(i).getCocktail_no());
                System.out.println(data.get(i).getCocktail_no());
            }
        }
		
		return result;
	}
	
	@RequestMapping({ "searchCocktail" })
	@ResponseBody
	public List<ciVO> searchCocktail(Model model, HttpServletRequest request) throws Exception {
		String cocktail_name = request.getParameter("cocktail_name");
		List<ciVO> c = this.service.searchCocktail(cocktail_name);
		return c;
	}
	
	@RequestMapping({ "lac" })
	@ResponseBody
	public List<ciVO> lac(Model model, HttpServletRequest request) throws Exception {
		List<ciVO> c = this.service.lac();
		return c;
	}

	@RequestMapping(value = { "modifyInfo" }, method = { RequestMethod.GET })
	public void modifyInfo(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		userVO u = (userVO) session.getAttribute("member");
		if (u != null) {
			model.addAttribute("user", u);
		} else {
			model.addAttribute("user", null);
		}
	}
	
	@RequestMapping(value = { "loadBC" }, method = { RequestMethod.GET })
	@ResponseBody
	public List<ciVO> loadBC(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
		userVO u = (userVO) session.getAttribute("member");
		if (u != null) {
			model.addAttribute("user", u);
		} else {
			model.addAttribute("user", null);
		}
		
		String bookmark_no = request.getParameter("bookmark_no");
		
		if(bookmark_no != null) {
			String[] bookmark_list = bookmark_no.split(" ");
			
			List<ciVO> l = new ArrayList<ciVO>();
			
			if(bookmark_list[0] != "") {
				for(int i = 0; i < bookmark_list.length; i++) {
					
					int j = Integer.parseInt(bookmark_list[i]);
					
					ciVO c = service.loadBC(j);
					if(c!=null) {
						l.add(c);	
					}
				}
			}
			
			return l;
		}
		
		return null;
	}

	@RequestMapping(value = { "modifyInformation" }, method = { RequestMethod.GET })
	@ResponseBody
	public boolean modifyInformation(HttpServletRequest request) throws Exception {
		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");
		String email = request.getParameter("email");
		System.out.println(email);
		boolean result = this.service.modifyInfo(user_id, user_pw, email);
		return result;
	}

	@RequestMapping(value = { "igList" }, method = { RequestMethod.GET })
	@ResponseBody
	public List<ingredientsVO> ingredientsList(HttpServletRequest request) throws Exception {
		List<ingredientsVO> list = this.service.ingredientsList();
		return list;
	}

	@RequestMapping(value = { "addRefrige" }, method = { RequestMethod.GET })
	@ResponseBody
	public int addRefrige(HttpServletRequest request) throws Exception {
		String user_no = request.getParameter("user_no");
		String ig = request.getParameter("ig");
		int user_no_i = Integer.parseInt(user_no);
		int ig_i = Integer.parseInt(ig);
		int i = this.service.addRefrige(user_no_i, ig_i);
		return i;
	}

	@RequestMapping(value = { "loadRefrige" }, method = { RequestMethod.GET })
	@ResponseBody
	public refrigeratorVO loadRefrige(HttpServletRequest request) throws Exception {
		String user_no = request.getParameter("user_no");
		refrigeratorVO r = new refrigeratorVO();
		try {
			int user_no_i = Integer.parseInt(user_no);
			r = this.service.loadRefrige(user_no_i);
			return r;
		} catch (Exception exception) {
			return r;
		}
	}

	@RequestMapping(value = { "deleteRefri" }, method = { RequestMethod.GET })
	@ResponseBody
	public int deleteRefri(HttpServletRequest request) throws Exception {
		String user_no = request.getParameter("user_no");
		String ig = request.getParameter("ig");
		refrigeratorVO r = new refrigeratorVO();
		int user_no_i = Integer.parseInt(user_no);
		r.setUser_no(user_no_i);
		r.setDel(ig);
		int i = this.service.deleteRefri(r);
		return i;
	}

	@RequestMapping(value = { "searchIg" }, method = { RequestMethod.GET })
	@ResponseBody
	public List<ingredientsVO> searchIg(HttpServletRequest request) throws Exception {
		String ig_name = request.getParameter("ig_name");
		List<ingredientsVO> list = this.service.searchIg(ig_name);
		return list;
	}

	@RequestMapping(value = { "fitCocktail" }, method = { RequestMethod.GET })
	@ResponseBody
	public List<ciVO> fitCocktail(HttpServletRequest request) throws Exception {
		try {
			String user_no = request.getParameter("user_no");
			int user_no_i = Integer.parseInt(user_no);
			List<ciVO> list = this.service.fitCocktail(user_no_i);
			return list;
		} catch(Exception e) {
			
		}
		return null;
	}

	@RequestMapping(value = { "requiredIg" }, method = { RequestMethod.GET })
	@ResponseBody
	public int requiredIg(HttpServletRequest request) throws Exception {
		try {
			String user_no = request.getParameter("user_no");
			int user_no_i = Integer.parseInt(user_no);
			String ig = request.getParameter("ig");
			int ig_i = Integer.parseInt(ig);
			refrigeratorVO r = new refrigeratorVO();
			r.setIg1(ig_i);
			r.setUser_no(user_no_i);
			int result = this.service.requiredIg(r);
			System.out.println(result);
			return result;
		} catch (Exception exception) {
			return 0;
		}
	}

	@RequestMapping(value = { "loadBoardList" }, method = { RequestMethod.GET })
	@ResponseBody
	public List<boardVO> loadBoardList(HttpServletRequest request) throws Exception {
		String page_s = request.getParameter("page");
		int page = Integer.parseInt(page_s);
		if(request.getParameter("word") != null) {
			String word = request.getParameter("word");
			System.out.println(word);
			List<boardVO> result = service.loadBoardList(word, page);
			return result;
		};
		List<boardVO> result = this.service.loadBoardList(page);
		return result;
	}
	
	@RequestMapping(value = { "loadBoardList2" }, method = { RequestMethod.GET })
	@ResponseBody
	public List<boardVO> loadBoardList2(HttpServletRequest request) throws Exception {
		String page_s = request.getParameter("page");
		String user_id = request.getParameter("user_id");
		int page = Integer.parseInt(page_s);
		List<boardVO> result = this.service.loadBoardList(page, user_id);
		return result;
	}

	@RequestMapping(value = {"upload"}, method = {RequestMethod.POST})
  public String upload(HttpServletRequest request, @RequestParam("uploadFile") MultipartFile[] file, @RequestParam("title") String title, @RequestParam("content") String content, Model model) throws Exception {
    HttpSession session = request.getSession();
    userVO u = (userVO)session.getAttribute("member");
    if (u == null) {
      model.addAttribute("failMessage", "");
      return "redirect:/board";
    } 
    boardVO b = new boardVO();
    attachVO a = new attachVO();
    String user_id = u.getUser_id();
    String pattern = "yyyy-MM-dd";
    String pattern2 = "HH:mm:ss";
    String pattern3 = "ss.SSS";
    SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
    SimpleDateFormat simpleDateFormat2 = new SimpleDateFormat(pattern2);
    SimpleDateFormat simpleDateFormat3 = new SimpleDateFormat(pattern3);
    String date = simpleDateFormat.format(new Date());
    String time = simpleDateFormat2.format(new Date());
    String sss = simpleDateFormat3.format(new Date());
    b.setUser_id(u.getUser_id());
    b.setTitle(title);
    b.setTime(time);
    b.setDate(date);
    b.setContent(content);
    b.setAttach_id("");
    String attach_id = String.valueOf(u.getUser_no()) + "_" + date + "_" + time;
    String r = "";
    for (int i = 0; i < file.length; i++) {
      if (file[i].getOriginalFilename() != "") {
        String name = sss+"_"+file[i].getOriginalFilename();
        if(r.equals(name)) {
        	model.addAttribute("msg", r);
        	return "redirect:/board";
        } else {
        	r = name;
        }
        System.out.println(name);
        String path = "/var/lib/tomcat8/webapps/user_no_" + u.getUser_no() + "_" + name;
        file[i].transferTo(new File(path));
        a.setAttach_id(attach_id);
        a.setName(name);
        a.setPath(path);
        b.setAttach_id(attach_id);
        this.service.addAttach(a);
      } 
    } 
    this.service.addBoard(b);
    return "redirect:/board";
  }

	@RequestMapping(value = { "loadBoard" }, method = { RequestMethod.POST })
	@ResponseBody
	public boardVO loadBoard(HttpServletRequest request, Model model) throws Exception {
		String no_s = request.getParameter("no");
		int no = Integer.parseInt(no_s);
		boardVO b = this.service.loadBoard(no);
		b.setContent(b.getContent().replaceAll("\n", "9br9"));
		System.out.println(b.getContent());
		return b;
	}

	@RequestMapping(value = { "deleteBoard" }, method = { RequestMethod.GET })
	@ResponseBody
	public int deleteBoard(HttpServletRequest request, Model model) throws Exception {
		HttpSession session = request.getSession();
	    userVO u = (userVO)session.getAttribute("member");
		String no_s = request.getParameter("no");
		int no = Integer.parseInt(no_s);
		String attach_id = request.getParameter("attach_id");
		boardVO b = new boardVO();
		b.setNo(no);
		b.setAttach_id(attach_id);
		attachVO test = new attachVO();
		test.setAttach_id(attach_id);
		List<attachVO> testList = service.loadAttach(test);
		try {
			for(int i = 0; i < testList.size(); i++) {
				if(testList.get(i).getName()!=null) {
					Path filePath = Paths.get("/var/lib/tomcat8/webapps/user_no_" + u.getUser_no() + "_" + testList.get(i).getName());
					
					Files.delete(filePath);
				}
			}
		}catch(Exception e) {
			
		}
		int result = this.service.deleteBoard(b);
		replyVO r = new replyVO();
		r.setNo(no);
		this.service.deleteReply(r);
		
		return result;
	}

	@RequestMapping(value = { "deleteReply" }, method = { RequestMethod.GET })
	@ResponseBody
	public int deleteReply(HttpServletRequest request) throws Exception {
		String no_s = request.getParameter("no");
		int no = Integer.parseInt(no_s);
		String reply_no_s = request.getParameter("reply_no");
		int reply_no = Integer.parseInt(reply_no_s);
		replyVO r = new replyVO();
		r.setNo(no);
		r.setReply_no(reply_no);
		int result = this.service.deleteReply(r);
		return result;
	}

	@RequestMapping(value = { "download" }, method = { RequestMethod.GET })
	@ResponseBody
	public byte[] download(HttpServletResponse response, @RequestParam("attach_id") String attach_id,
			@RequestParam("name") String name) throws IOException {
		try {
		String[] attach_id_arr = attach_id.split("_");
		File file = new File("/var/lib/tomcat8/webapps/user_no_" + attach_id_arr[0] + "_" + name);
		byte[] bytes = FileCopyUtils.copyToByteArray(file);
		String fn = new String(file.getName().getBytes(), "utf-8");
		response.setHeader("Content-Disposition", "attachment;filename=\"" + fn + "\"");
		response.setContentLength(bytes.length);
		return bytes;
		} catch(Exception e) {
			
		}
		return null;
	}
	
	@RequestMapping(value = { "whence" }, method = { RequestMethod.GET })
	@ResponseBody
	public byte[] whence(HttpServletResponse response) throws IOException {
		try {
			File file = new File("/var/lib/tomcat8/webapps/whence.zip");
			byte[] bytes = FileCopyUtils.copyToByteArray(file);
			String fn = new String(file.getName().getBytes(), "utf-8");
			response.setHeader("Content-Disposition", "attachment;filename=\"" + fn + "\"");
			response.setContentLength(bytes.length);
			return bytes;
		} catch(Exception e) {
			
		}
		return null;
	}

	@RequestMapping({ "loadAttach" })
	@ResponseBody
	public List<attachVO> loadAttach(HttpServletRequest request) throws Exception {
		attachVO a = new attachVO();
		String attach_id = request.getParameter("attach_id");
		a.setAttach_id(attach_id);
		List<attachVO> result = this.service.loadAttach(a);
		return result;
	}
	
	@RequestMapping({ "getout" })
	@ResponseBody
	public int getout(HttpServletRequest request) throws Exception {
		
		String user_no_s = request.getParameter("user_no");
		
		int user_no = Integer.parseInt(user_no_s);
		
		String user_id = request.getParameter("user_id");
		
		int result = service.getout(user_no, user_id);
		
		return result;
	}

	@RequestMapping({ "modifySave" })
	@ResponseBody
	public int modifySave(HttpServletRequest request) throws Exception {
		boardVO b = new boardVO();
		b.setTitle(request.getParameter("title"));
		String no_s = request.getParameter("no");
		int no = Integer.parseInt(no_s);
		b.setNo(no);
		String pattern = "yyyy-MM-dd";
		String pattern2 = "HH:mm:ss";
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
		SimpleDateFormat simpleDateFormat2 = new SimpleDateFormat(pattern2);
		String date = simpleDateFormat.format(new Date());
		String time = simpleDateFormat2.format(new Date());
		b.setDate(date);
		b.setTime(time);
		b.setContent(request.getParameter("content"));
		int result = this.service.modifySave(b);
		return result;
	}

	@RequestMapping({ "deleteAttach" })
	@ResponseBody
	public int deleteAttach(HttpServletRequest request) throws Exception {
		attachVO a = new attachVO();
		String attach_id = request.getParameter("attach_id");
		String[] attach_id_arr = attach_id.split("_");
		a.setAttach_id(attach_id);
		String name = request.getParameter("name");
		a.setName(name);
		Path filePath = Paths.get("/var/lib/tomcat8/webapps/user_no_" + attach_id_arr[0] + "_" + name, new String[0]);
		int result = this.service.deleteAttach(a);
		Files.delete(filePath);
		return result;
	}

	@RequestMapping({ "loadReply" })
	@ResponseBody
	public List<replyVO> loadReply(HttpServletRequest request) throws Exception {
		replyVO r = new replyVO();
		String no_s = request.getParameter("no");
		int no = Integer.parseInt(no_s);
		r.setNo(no);
		List<replyVO> result = this.service.loadReply(r);
		return result;
	}
	
	@RequestMapping({ "bookmark" })
	@ResponseBody
	public int bookmark(HttpServletRequest request) throws Exception {
		String user_no_s = request.getParameter("user_no");
		int user_no = Integer.parseInt(user_no_s);
		if(service.selectBookmark(user_no) != null) {
			String bookmark_no = service.selectBookmark(user_no).getBookmark_no();
			String plusBN = request.getParameter("bookmark_no");
			String[] bookmark_list = bookmark_no.split(" ");
			String bookmark_no_edit;
			for(int i = 0; i < bookmark_list.length; i++) {
				if(bookmark_list[i].equals(plusBN)) {
					bookmark_no_edit = bookmark_no.replace(bookmark_list[i]+" ", "");
					System.out.println(bookmark_no_edit);
					int result = service.updateBookmark(user_no, bookmark_no_edit);
					return result;
				}
			}
			bookmark_no += plusBN+" ";
			int result = service.updateBookmark(user_no, bookmark_no);
			return result;
		} else {
			String plusBN = request.getParameter("bookmark_no")+" ";
			int result = service.insertBookmark(user_no, plusBN);
			return result;
		}
	}
	
	@RequestMapping({ "loadBookmark" })
	@ResponseBody
	public bookmarkVO loadBookmark(HttpServletRequest request) throws Exception {
		String user_no_s = request.getParameter("user_no");
		int user_no = Integer.parseInt(user_no_s);
		if(service.selectBookmark(user_no) != null) {
			return service.selectBookmark(user_no);
		} else {
			System.out.println("aaa");
			return new bookmarkVO();
		}
	}

	@RequestMapping({ "saveReply" })
	@ResponseBody
	public int saveReply(HttpServletRequest request) throws Exception {
		replyVO r = new replyVO();
		String no_s = request.getParameter("no");
		String user_no_s = request.getParameter("user_no");
		int user_no = Integer.parseInt(user_no_s);
		String pattern = "yyyy-MM-dd HH:mm:ss";
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
		String date = simpleDateFormat.format(new Date());
		int no = Integer.parseInt(no_s);
		r.setNo(no);
		r.setUser_no(user_no);
		r.setUser_id(request.getParameter("user_id"));
		r.setTime(date);
		r.setContent(request.getParameter("content"));
		if (request.getParameter("nreply_no") != null) {
			String nreply_no_s = request.getParameter("nreply_no");
			int nreply_no = Integer.parseInt(nreply_no_s);
			r.setNreply_no(nreply_no);
		}
		System.out.println(r.getContent());
		int result = this.service.saveReply(r);
		return result;
	}
}
