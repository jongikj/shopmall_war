package com.shopmall.web.controllers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.shopmall.web.domains.Command;
import com.shopmall.web.domains.DetailImageDTO;
import com.shopmall.web.domains.Retval;
import com.shopmall.web.domains.ShopDTO;
import com.shopmall.web.services.AdminServiceImpl;

@Controller
@Lazy
@SessionAttributes({"price", "result", "user", "context", "css", "img", "js", "temp"})
@RequestMapping("/admin")
public class AdminController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	@Autowired AdminServiceImpl service;
	@Autowired ShopDTO shop;
	@Autowired Command command;
	@Autowired Retval retval;
	
/*	@RequestMapping(value="/check", method=RequestMethod.POST)
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
	} */
	
/*	@RequestMapping("/ipCheck")
	public @ResponseBody Retval ipCheck(HttpSession session) throws IOException {
		String url = "http://www.findip.kr/";
		Document doc = Jsoup.connect(url).userAgent("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.152 Safari/537.36").get();
        Elements elem = doc.select("h1");
        String ip = elem.text().replaceAll(" ", "");
        String[] ipArr = ip.split(":");
        
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
		return retval;
	} */
	
	@RequestMapping("/")
	public String goHome() {
		logger.info("AdminController : {}", "go admin home");
		return "admin:admin/home.tiles";
	}
	
	@RequestMapping("/sellListMaxSeq")
	public @ResponseBody Retval sellListMaxSeq() {
		Retval retval = new Retval();
		retval.setCount(service.sellListMaxSeq());
		return retval;
	}
	
	@RequestMapping(value="/insertSellList", method=RequestMethod.POST)
	public @ResponseBody Retval insertSellList(@RequestBody ShopDTO param) {
		ShopDTO shop = new ShopDTO();
		shop.setCount(param.getCount());
		shop.setDetail(param.getDetail());
		shop.setGenre(param.getGenre());
		shop.setGenre_eng(param.getGenre_eng());
		shop.setImage(param.getImage());
		shop.setPrice(param.getPrice());
		shop.setTitle(param.getTitle());
		service.insertSellList(shop);
		retval.setMsg("insert sell list end");
		return retval;
	}
	
	@RequestMapping(value="/insertDetailImage", method=RequestMethod.POST)
	public @ResponseBody Retval insertDetailImage(@RequestParam String image_url, @RequestParam int seq_sell_list) {
		DetailImageDTO detail = new DetailImageDTO();
		detail.setImage_url(image_url);
		detail.setSeq_sell_list(seq_sell_list);
		service.insertDetailImage(detail);
		retval.setMsg("insert detail image end");
		return retval;
	}
}
