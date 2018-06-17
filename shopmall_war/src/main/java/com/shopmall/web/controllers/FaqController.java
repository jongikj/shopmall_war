package com.shopmall.web.controllers;

import java.util.HashMap;

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
import org.springframework.web.servlet.ModelAndView;

import com.shopmall.web.constants.Values;
import com.shopmall.web.domains.Command;
import com.shopmall.web.domains.FaqDTO;
import com.shopmall.web.domains.Retval;
import com.shopmall.web.services.FaqServiceImpl;
import com.shopmall.web.util.Pagination;

@Controller
@Lazy
@SessionAttributes({"user", "context", "css", "img", "js","temp"})
@RequestMapping("/faq")
public class FaqController {
	private static final Logger logger = LoggerFactory.getLogger(FaqController.class);
	@Autowired FaqDTO faq;
	@Autowired FaqServiceImpl service;
	@Autowired Command command;
	@Autowired Retval retval;
	
	@RequestMapping("/goFaq/{pgNum}")
	public String goFaq(@PathVariable int pgNum){
		logger.info("FaqController : {}", "goFaq");
		return "public:faq/faq.tiles";
	}
	
	@RequestMapping("/find/{keyField}/{keyword}/{pgNum}")
	public String goFaq(@PathVariable String keyField, @PathVariable String keyword, @PathVariable int pgNum){
		logger.info("FaqController : {}", "faq find by");
		return "public:faq/faq.tiles";
	}
	
	@RequestMapping("/goMyFaq/{pgNum}")
	public String goMyFaq(){
		logger.info("FaqController : {}", "goMyFaq");
		return "public:faq/faq.tiles";
	}
	
	@RequestMapping("/goFaqOne")
	public String goFaqOne(){
		logger.info("FaqController : {}", "goFaqOne");
		return "public:faq/faq_one.tiles";
	}
	
	@RequestMapping("/faqArticle/{pgNum}/{seq}")
	public String faqArticle(@PathVariable int pgNum, @PathVariable int seq) {
		logger.info("FaqController : {}", "faqArticle");
		return "public:faq/faq_article.tiles";
	}
	
	@RequestMapping("/MyFaqArticle/{pgNum}/{seq}")
	public String MyFaqArticle(@PathVariable int pgNum, @PathVariable int seq) {
		logger.info("FaqController : {}", "MyFaqArticle");
		return "public:faq/faq_article.tiles";
	}
	
	@RequestMapping("/selectAll/{pgNum}")
	public @ResponseBody HashMap<String, Object> selectAll(@PathVariable int pgNum){
		logger.info("FaqController : {}", "selectAll");
		HashMap<String, Object> map = new HashMap<String, Object>();
		int totCount = service.countAll();
		int pageSize = Values.FAQ_PG_SIZE;
		int[] pageStartEnd = Pagination.faqGetStartEnd(totCount, pageSize, pgNum);
		command.setStart(pageStartEnd[0]);
		command.setEnd(pageStartEnd[1]);
		map.put("list", service.selectAll(command));
		map.put("pageSize", Values.FAQ_PG_SIZE);
		map.put("groupSize", Values.FAQ_GROUP_SIZE);
		map.put("totCount", totCount);
		map.put("totPage", pageStartEnd[2]);
		map.put("pgNum", pgNum);
		map.put("startPage", pageStartEnd[3]);
		map.put("endPage", pageStartEnd[4]);
		return map;
	}
	
	@RequestMapping("/selectAllId/{keyword}/{pgNum}")
	public @ResponseBody HashMap<String, Object> selectAllId(@PathVariable String keyword, @PathVariable int pgNum){
		logger.info("FaqController : {}", "selectAllId");
		HashMap<String, Object> map = new HashMap<String, Object>();
		command.setKeyword(keyword);
		int totCount = service.countId(command);
		int pageSize = Values.FAQ_PG_SIZE;
		int[] pageStartEnd = Pagination.faqGetStartEnd(totCount, pageSize, pgNum);
		command.setStart(pageStartEnd[0]);
		command.setEnd(pageStartEnd[1]);
		map.put("list", service.selectAllId(command));
		map.put("pageSize", Values.FAQ_PG_SIZE);
		map.put("groupSize", Values.FAQ_GROUP_SIZE);
		map.put("totCount", totCount);
		map.put("totPage", pageStartEnd[2]);
		map.put("pgNum", pgNum);
		map.put("startPage", pageStartEnd[3]);
		map.put("endPage", pageStartEnd[4]);
		map.put("keyword", keyword);
		return map;
	}
	
	@RequestMapping("findTitle/{keyword}/{pgNum}")
	public @ResponseBody HashMap<String, Object> findTitle(@PathVariable String keyword, @PathVariable int pgNum){
		logger.info("FaqController : {}", "findTitle");
		command.setKeyword(keyword);
		HashMap<String, Object> map = new HashMap<String, Object>();
		int totCount = service.countTitle(command);
		int pageSize = Values.FAQ_PG_SIZE;
		int[] pageStartEnd = Pagination.faqGetStartEnd(totCount, pageSize, pgNum);
		command.setStart(pageStartEnd[0]);
		command.setEnd(pageStartEnd[1]);
		map.put("list", service.findTitle(command));
		map.put("pageSize", Values.FAQ_PG_SIZE);
		map.put("groupSize", Values.FAQ_GROUP_SIZE);
		map.put("totCount", totCount);
		map.put("totPage", pageStartEnd[2]);
		map.put("pgNum", pgNum);
		map.put("startPage", pageStartEnd[3]);
		map.put("endPage", pageStartEnd[4]);
		map.put("keyword", keyword);
		return map;
	}
	
	@RequestMapping("/selectOneSeq/{pgNum}/{seq}")
	public @ResponseBody HashMap<String, Object> selectOneSeq(@PathVariable int seq, @PathVariable int pgNum){
		logger.info("FaqController : {}", "selectOneSeq");
		HashMap<String, Object> map = new HashMap<String, Object>();
		command.setSeq(seq);
		map.put("obj", service.selectOneSeq(command));
		map.put("pgNum", pgNum);
		return map;
	}
	
	@RequestMapping(value="/insertFaq", method=RequestMethod.POST)
	public @ResponseBody Retval insertFaq(@RequestBody FaqDTO faq){
		logger.info("FaqController : {}", "insertFaq");
		logger.info("title : {}", faq.getTitle());
		logger.info("article : {}", faq.getArticle());
		logger.info("id : {}", faq.getId());
		FaqDTO obj = new FaqDTO();
		obj.setTitle(faq.getTitle());
		obj.setArticle(faq.getArticle());
		obj.setId(faq.getId());
		service.insertFaq(obj);
		retval.setMsg("success");
		return retval;	
	}
	
	@RequestMapping("updateFaq/{seq}")
	public String goUpdateFaq(@PathVariable int seq){
		logger.info("FaqController : {}", "goUpdateFaq");
		return "public:faq/faq_one.tiles";
	}
	
	@RequestMapping(value="update", method={RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody Retval update(@RequestBody FaqDTO faq){
		logger.info("FaqController : {}", "update");
		FaqDTO temp = new FaqDTO();
/*		temp.setTitle(faq.getTitle());
		temp.setArticle(faq.getArticle());
		temp.setSeq(faq.getSeq());*/
		retval.setMsg("success");
		service.update(faq);
		return retval;
	}
	
	@RequestMapping("delete")
	public @ResponseBody int delete(@RequestParam int seq){
		logger.info("FaqController : {}", "delete");
		command.setSeq(seq);
		return service.delete(command);
	}
	
	@RequestMapping("/nextSelectSeq/{seq}")
	public @ResponseBody FaqDTO nextSelectSeq(@PathVariable int seq){
		logger.info("FaqController : {}", "nextSelectSeq");
		command.setSeq(seq);
		return service.nextSelectSeq(command);
	}
	
	@RequestMapping("/beforeSelectSeq/{seq}")
	public @ResponseBody FaqDTO beforeSelectSeq(@PathVariable int seq){
		logger.info("FaqController : {}", "beforeSelectSeq");
		command.setSeq(seq);
		return service.beforeSelectSeq(command);
	}
	
	@RequestMapping("/myNextSelectSeq/{seq}/{keyword}")
	public @ResponseBody FaqDTO myNextSelectSeq(@PathVariable int seq, @PathVariable String keyword){
		logger.info("FaqController : {}", "myNextSelectSeq");
		command.setSeq(seq);
		command.setKeyword(keyword);
		return service.myNextSelectSeq(command);
	}
	
	@RequestMapping("/myBeforeSelectSeq/{seq}/{keyword}")
	public @ResponseBody FaqDTO myBeforeSelectSeq(@PathVariable int seq, @PathVariable String keyword){
		logger.info("FaqController : {}", "myBeforeSelectSeq");
		command.setSeq(seq);
		command.setKeyword(keyword);
		return service.myBeforeSelectSeq(command);
	}
}
