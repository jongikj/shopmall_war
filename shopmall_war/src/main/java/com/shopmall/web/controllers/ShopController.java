package com.shopmall.web.controllers;

import java.net.InetAddress;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionAttributeStore;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shopmall.web.constants.Values;
import com.shopmall.web.domains.Command;
import com.shopmall.web.domains.MemberShopDTO;
import com.shopmall.web.domains.Retval;
import com.shopmall.web.domains.ShopDTO;
import com.shopmall.web.services.ShopServiceImpl;
import com.shopmall.web.util.Pagination;

@Controller
@Lazy
@SessionAttributes({"price", "result", "user", "context", "css", "img", "js", "temp"})
@RequestMapping("/shop")
public class ShopController {
	private static final Logger logger = LoggerFactory.getLogger(ShopController.class);
	@Autowired ShopDTO shop;
	@Autowired ShopServiceImpl service;
	@Autowired Command command;
	@Autowired Retval retval;
	
	@RequestMapping("/buy")
	public String goBuy(){
		logger.info("shopController : {}", "goBuy");
		return "public:shop/buy.tiles";
	}
	
	@RequestMapping("buyFin")
	public String goBuyFin() {
		logger.info("shopController : {}", "goBuyFin");
		return "public:shop/buy_fin.tiles";
	}
	
	@RequestMapping("/wishlist")
	public String goWishlist() {
		logger.info("shopController : {}", "goWishlist");
		return "public:shop/wishlist.tiles";
	}
	
	@RequestMapping("/selectDesc")
	public @ResponseBody HashMap<String, Object> selectDesc(){
		logger.info("ShopController GO TO {}", "selectDesc");
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("list", service.selectDesc());
		return map;
	}
	
	@RequestMapping("/selectGenre")
	public @ResponseBody HashMap<String, Object> selectGenre(){
		logger.info("shopController GO TO {}",  "selectGenre");
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("list", service.selectGenere());
		return map;
	}

	@RequestMapping("/selectGenreDesc/{keyword}")
	public @ResponseBody HashMap<String, Object> selectGenreDesc(@RequestParam String keyword){
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("list", service.selectGenreDesc());
		return map;
	}
	
	@RequestMapping("/selectOneSeq/{keyword}")
	public String selectOneSeq(@PathVariable String keyword, Model model){
		logger.info("shopController GO TO {}", "selectOneSeq");
		command.setKeyword(keyword);
		shop = service.selectOneSeq(command);
		
		model.addAttribute("seq", shop.getSeq());
		model.addAttribute("title", shop.getTitle());
		model.addAttribute("price", shop.getPrice());
		model.addAttribute("count", shop.getCount());
		model.addAttribute("detail", shop.getDetail());
		model.addAttribute("genre", shop.getGenre());
		model.addAttribute("genre_eng", shop.getGenre_eng());
		model.addAttribute("image", shop.getImage());
		return "public:shop/detail.tiles";
	}
	
	@RequestMapping("/readBuy")
	public @ResponseBody ShopDTO readBuy(@RequestParam int seq){
		logger.info("shopController : {}", "readBuy");
		command.setSeq(seq);
		shop = service.readBuy(command);
		return shop; 
	}
	
	@RequestMapping("/selectAll")
	public @ResponseBody HashMap<String, Object> selectAll(){
		logger.info("shopController GO TO {}", "selectAll");
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("list", service.selectAll());
		return map;
	}
	
	@RequestMapping("/selectSearchAll/{keyField}/{keyword}")
	public @ResponseBody HashMap<String, Object> selectSearchAll(@PathVariable String keyField, @PathVariable String keyword){
		logger.info("shopController GO TO {}", "selectSerachAll");
		logger.info("shopController keyField {}", keyField);
		logger.info("shopController keyword {}", keyword);
		command.setKeyField(keyField);
		command.setKeyword(keyword);
		
		HashMap<String,Object> map = new HashMap<String, Object>();
		map.put("list", service.selectSearchAll(command));
		return map;
	}
	
	@RequestMapping("/countImage/{seq}")
	@ResponseBody	//404 에러로 인한 어노테이션
	public Retval countImage(@PathVariable int seq){
		logger.info("shopController GO TO {}", "countImage");
		command.setSeq(seq);
		retval.setCount(service.countImage(command));
		return retval;
	}
	
	@RequestMapping("/selectDetailImage/{seqSellList}")
	@ResponseBody	//404 에러로 인한 어노테이션
	public HashMap<String, Object> selectDetailImage(@PathVariable int seqSellList){
		logger.info("shopController GO TO {}", "selectDetailImage");
		HashMap<String, Object> map = new HashMap<String, Object>(); 
		command.setSeq(seqSellList);
		map.put("list", service.selectDetailImage(command));
		return map;
	}
	
	@RequestMapping("/goGenre/{keyword}/{pgNum}")
	public String goGenre(@PathVariable String keyword, @PathVariable String pgNum, Model model){
		logger.info("shopController GO TO {}", "goGenre");
		command.setKeyField("genre_eng");
		command.setKeyword(keyword);
		model.addAttribute("genre", service.selectSearchAll(command).get(0).getGenre());
		return "public:shop/shop.tiles";
	}
	
	@RequestMapping("/genre/{keyword}/{pgNum}")
	@ResponseBody
	public HashMap<String, Object> genre(@PathVariable String keyword, @PathVariable String pgNum){
		logger.info("shopController GO TO {}", "genre");
		command.setKeyword(keyword);
		int totCount = service.count(command);
		int pageSize = Pagination.shopPageSize(totCount);
		int[] pageStartEnd = Pagination.shopGetStartEnd(totCount, pageSize, Integer.parseInt(pgNum));
		command.setStart(pageStartEnd[0]);
		command.setEnd(pageStartEnd[1]);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("list", service.genre(command));
		map.put("pageSize", Values.SHOP_PG_SIZE);
		map.put("groupSize", Values.SHOP_GROUP_SIZE);
		map.put("totCount", totCount);
		map.put("totPage", pageStartEnd[2]);
		map.put("pgNum", Integer.parseInt(pgNum));
		map.put("startPage", pageStartEnd[3]);
		map.put("endPage", pageStartEnd[4]);
		logger.info("pgNum {}", pgNum);
		return map;
	}
	
	@RequestMapping("/checkCount")
	public @ResponseBody Retval checkCount(@RequestParam int seq) {
		logger.info("shopController GO TO {}", "checkCount");
		command.setSeq(seq);
		retval.setCount(service.checkCount(command));
		return retval;
	}
	
	@RequestMapping("/resultPrice")
	public @ResponseBody Retval resultPrice(HttpSession session, @RequestParam int price) {
		try{
	      InetAddress local = InetAddress.getLocalHost();
	      logger.info(local.getHostAddress() + " total price : {}", price);
	    }catch(Exception e){
	      System.out.println(e.getMessage());
	    }

		retval.setCount(price);
		session.setAttribute("price", retval);
		return (Retval)session.getAttribute("price");
	}
	
	@RequestMapping("/getResultPrice")
	public @ResponseBody Retval getResultPrice(HttpSession session) {
		logger.info("shopController : {}", "getResultPrice");
		return retval;
	}
	
	@RequestMapping("goBuyFinList")
	public String buyFinList() {
		logger.info("shopController : {}", "goBuyFinList");
		return "public:shop/buy_fin.tiles";
	}
	
	@RequestMapping(value="/setBuyList", method=RequestMethod.POST)
	public String setBuyList(@RequestBody String[] buy_arr, RedirectAttributes redirect) {
		logger.info("shopController : {}", "setBuyList");		
		String[] temp = new String[3];
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		for(int i=0; i<=buy_arr.length-2; i++) { // put seq, count
			temp = buy_arr[i].split(",");
			ShopDTO obj = new ShopDTO();
			command.setSeq(Integer.parseInt(temp[0]));
			obj.setTitle(service.readBuy(command).getTitle());
			obj.setCount(Integer.parseInt(temp[1]));
			obj.setPrice(service.readBuy(command).getPrice() * obj.getCount());	
			obj.setImage(service.readBuy(command).getImage());	
			map.put("item" + i, obj.getTitle() + "|" + obj.getCount() + "|" + obj.getPrice() + "|" + obj.getImage() + "|" + i);
		}	
		 
		map.put("total_price", buy_arr[buy_arr.length - 1]); // put total price
		
		for(int i=0; i<=map.size()-2; i++) {
			System.out.println(i + "번 : " + map.get("item" + i));
		}
		
		System.out.println("가격  : " + map.get("total_price"));
		redirect.addFlashAttribute("result", map);
		return "redirect:/shop/goBuyFinList";
	}

	@RequestMapping("/getBuyList")
	public @ResponseBody HashMap<String, Object> getBuyList(HttpSession session) {
		logger.info("shopController : {}", "getBuyList");
		HashMap<String, Object> map = new HashMap<String, Object>();
		map = (HashMap<String, Object>) session.getAttribute("result");
		return map;
	}
	
	@RequestMapping("/updateCount")
	public @ResponseBody Retval updateCount(@RequestParam int count, @RequestParam int seq) {
		logger.info("shopController : {}", "updateCount");
		command.setCount(count);
		command.setSeq(seq);
		
		if(service.updateCount(command) == 1) {
			retval.setMsg("updateCount success");
		} else {
			retval.setMsg("updateCount fail");
		}
		
		return retval;
	}
	
	@RequestMapping("/initPrice")
	public @ResponseBody Retval initPrice(HttpSession session) {
		retval.setCount(0);
		retval.setMsg("price init");
		session.setAttribute("price", retval);
		return retval;
	}
	
	@RequestMapping(value="/addWishlist", method=RequestMethod.POST)
	public @ResponseBody Retval addWishlist(@RequestParam String id, @RequestParam int seq) {
		logger.info("shopController : {}", "addWishlist");
		command.setSeq(seq);
		command.setId(id);
		service.addWishlist(command);
		retval.setMsg("addWishlist end");
		return retval;
	}
	
	@RequestMapping(value="selectWishOne", method=RequestMethod.POST)
	public @ResponseBody MemberShopDTO selectWishOne(@RequestParam String id, @RequestParam int seq) {
		logger.info("shopController : {}", "selectWishOne");
		MemberShopDTO obj = new MemberShopDTO();
		command.setId(id);
		command.setSeq(seq);
		obj = service.selectWishOne(command);
		System.out.println(obj);
		return obj;
	}
	
	@RequestMapping("/selectWishAll/{id}")
	public @ResponseBody HashMap<String, Object> selectWishAll(@PathVariable String id) {
		logger.info("shopController : {}", "selectWishAll");
		HashMap<String, Object> map = new HashMap<String, Object>();
		command.setId(id);
		map.put("list", service.selectWishAll(command));
		map.put("size", service.wishCount(command));
		return map;
	}
	
	@RequestMapping(value="/deleteWish", method=RequestMethod.POST)
	public @ResponseBody Retval deleteWish(@RequestParam String id, @RequestParam int seq) {
		logger.info("shopController : {}", "deleteWish");
		command.setId(id);
		command.setSeq(seq);
		service.deleteWish(command);
		retval.setMsg("deleteWish End");
		return retval;
	}
}
