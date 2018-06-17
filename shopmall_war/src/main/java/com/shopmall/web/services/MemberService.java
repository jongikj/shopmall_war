package com.shopmall.web.services;

import java.util.List;

import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;

import com.shopmall.web.domains.Command;
import com.shopmall.web.domains.MemberDTO;
import com.shopmall.web.domains.MemberShopDTO;
import com.shopmall.web.domains.Retval;

@Component
@Lazy
public interface MemberService {
	public String signUp(MemberDTO member);
	public MemberDTO login(MemberDTO member);
	public List<MemberDTO> find(Command command);
	public int checkId(String id);
	public int update(MemberDTO member);
	public List<MemberShopDTO> sellLog(Command command);
	public int countSellLog(Command command);
	public int insertSellLog(Command command);
}
