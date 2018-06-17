package com.shopmall.web.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.shopmall.web.domains.Command;
import com.shopmall.web.domains.MemberDTO;
import com.shopmall.web.domains.MemberShopDTO;
import com.shopmall.web.domains.Retval;

@Repository
public interface MemberMapper {
	public int signUp(MemberDTO member);
	public MemberDTO login(MemberDTO member);
	public List<MemberDTO> find(Command command);
	public int checkId(String id);
	public int update(MemberDTO member);
	public List<MemberShopDTO> sellLog(Command Command);
	public int countSellLog(Command command);
	public int insertSellLog(Command command);
}
