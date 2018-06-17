package com.shopmall.web.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.shopmall.web.constants.Values;
import com.shopmall.web.domains.AdminDTO;
import com.shopmall.web.domains.Command;
import com.shopmall.web.domains.MemberDTO;
import com.shopmall.web.domains.Retval;
import com.shopmall.web.services.MemberServiceImpl;
import com.shopmall.web.util.Pagination;

@Controller
@Lazy
@SessionAttributes({"price", "user", "context", "css", "img", "js","temp", "admin"})
@RequestMapping("/member")
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	@Autowired MemberDTO member;
	@Autowired MemberServiceImpl service;
	@Autowired Command command;
	@Autowired Retval retval;
	
	@RequestMapping(value="/check", method=RequestMethod.POST)
	public @ResponseBody Retval check(@RequestParam int value, HttpSession session) throws IOException {
		logger.info("AdminController : {}", "checking value");
		logger.info("AdminController : {}", value);
		
		String url = "http://www.findip.kr/";
		Document doc = Jsoup.connect(url).userAgent("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.152 Safari/537.36").get();
        Elements elem = doc.select("h1");
        String ip = elem.text().replaceAll(" ", "");
        String[] ipArr = ip.split(":");
        
		if(value == 26592226) {
	        if(ipArr[1].equals("61.98.57.91")) {
	        	logger.info("AdminController {}", "ip 일치");
	        	AdminDTO admin = new AdminDTO();
	        	admin.setAdmin(true);
	        	session.setAttribute("admin", admin);
	        	retval.setFlag(1);
	        } else {
	        	logger.info("AdminController {}", "ip 불일치");
	        	retval.setFlag(0);
	        }
		} else {
			retval.setFlag(0);
		}
		return retval;
	}
	
	@RequestMapping("/goSignUp")
	public String goSignUp(){
		logger.info("MemberController GO TO {}",  "goSignUp");
		return "public:member/sign_up.tiles";
	}
	
	@RequestMapping("/mypage")
	public String goMyPage(){
		logger.info("MemberController : {}", "goMyPage");
		return "public:member/mypage.tiles";
	}
	
	@RequestMapping("/goSellLog/{pgNum}")
	public String goSellLog(@PathVariable int pgNum){
		logger.info("MemberController : {}", "goSellLog");
		return "public:member/sell_log.tiles";
	}
	
	@RequestMapping("/sellLog/{pgNum}")
	public @ResponseBody HashMap<String, Object> sellLog(@PathVariable int pgNum, HttpSession session){
		logger.info("MemberController : {}", "sellLog");
		MemberDTO temp = (MemberDTO)session.getAttribute("user");
		HashMap<String, Object> map = new HashMap<String, Object>();
		command.setKeyword(temp.getId());
		int totCount = service.countSellLog(command);
		int pageSize = Values.FAQ_PG_SIZE;
		int[] pageStartEnd = Pagination.faqGetStartEnd(totCount, pageSize, pgNum);
		command.setStart(pageStartEnd[0]);
		command.setEnd(pageStartEnd[1]);
		map.put("list", service.sellLog(command));
		map.put("pageSize", Values.FAQ_PG_SIZE);
		map.put("groupSize", Values.FAQ_GROUP_SIZE);
		map.put("totCount", totCount);
		map.put("totPage", pageStartEnd[2]);
		map.put("pgNum", pgNum);
		map.put("startPage", pageStartEnd[3]);
		map.put("endPage", pageStartEnd[4]);
		return map;
	}
	
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public @ResponseBody Retval update(@RequestBody MemberDTO param, HttpSession session){
		logger.info("MemberController : {}", "update");
		MemberDTO temp = (MemberDTO) session.getAttribute("user");
		temp.setId(temp.getId());
		temp.setPw(param.getPw());
		temp.setPhone(param.getPhone());
		temp.setEmail(param.getEmail());
		session.setAttribute("user", service.update(temp));
		retval.setMsg("update end");
		return retval;
	}
	
	@RequestMapping(value="/signUp", method=RequestMethod.POST)
	public @ResponseBody String signUp(@RequestBody MemberDTO param){
		logger.info("MemberController GO TO {}", "signUp");
		MemberDTO temp = new MemberDTO();
		temp.setId(param.getId());
		temp.setPw(param.getPw());
		temp.setEmail(param.getEmail());
		temp.setPhone(param.getPhone());
		service.signUp(temp);
		return "signUp_end";
	}
	
	@RequestMapping("/goLogin")
	public String goLogin(){
		logger.info("MemberController GO TO {}",  "goLogin");
		return "public:member/login.tiles";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public @ResponseBody MemberDTO login(@RequestParam String id, @RequestParam String pw, HttpSession session){
		logger.info("MemberController GO TO {}", "login");
		logger.info("Login ID : {}", id);
		logger.info("Login pw : {}", pw);
		member.setId(id);
		member.setPw(pw);
		MemberDTO user = service.login(member);
		
		if(user.getId().equals("")){
			logger.info("MemberController login {}", "실패");
		} else {
			logger.info("MemberContoller  login {}", "성공");
			logger.info("로그인 정보 : {}", user);
			session.setAttribute("user", user);
		}
		return user;
	}
	
	@RequestMapping("/session")
	public @ResponseBody MemberDTO session(HttpSession session){
		logger.info("MemberController GO TO {}", "session");
		MemberDTO member = (MemberDTO) session.getAttribute("user");
		if(member == null){
			member = new MemberDTO();
		}
		return member;
	}
	
	@RequestMapping("/logout")
	public String logout(SessionStatus status){
		logger.info("MemberController GO TO {}", "logout");
		status.setComplete();
		return "redirect:/";
	}
	
	@RequestMapping(value="/find/{keyField}/{keyword}")
	public @ResponseBody List<MemberDTO> find(@PathVariable String keyField, @PathVariable String keyword){
		logger.info("MemberController  GO TO {}", "find");
		List<MemberDTO> list = new ArrayList<MemberDTO>();
		command.setKeyField(keyField);
		command.setKeyword(keyword);
		list = service.find(command);
		return list;
	}
	
	@RequestMapping(value="/checkId/{id}", method=RequestMethod.POST)
	@ResponseBody	//컨트롤러에선 정상작동 하나 브라우저에서 이유없는 404 에러로 인한 땜질용
	public Retval checkId(@PathVariable String id){
		logger.info("MemberController GO TO {}", "checkId");
		logger.info("{}", service.checkId(id));
		if(service.checkId(id) == 1){
			retval.setFlag(1);
		}else{
			retval.setFlag(0);
		}
		return retval;
	}
	
	@RequestMapping(value="/insertSellLog", method=RequestMethod.POST)
	public @ResponseBody Retval insertSellLog(HttpSession session, @RequestBody String[] buy_arr) {
		logger.info("MemberController GO TO {}", "insertSellLog");
		MemberDTO member = (MemberDTO) session.getAttribute("user");
		
		if(member == null) { 
			command.setKeyword("non-member");
		} else {
			command.setKeyword(member.getId());
		}
		
		if(Integer.parseInt(buy_arr[0].split(",")[2]) == buy_arr.length) {
			for(int i=0; i<=buy_arr.length-2; i++) {
				command.setSeq(Integer.parseInt((buy_arr[i].split(",")[0])));
				command.setCount(Integer.parseInt(buy_arr[i].split(",")[1]));
				service.insertSellLog(command);
			}	
		}
		
		retval.setFlag(1);
		return retval;
	}
}
