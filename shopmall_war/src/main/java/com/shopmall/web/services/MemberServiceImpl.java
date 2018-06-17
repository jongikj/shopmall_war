package com.shopmall.web.services;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import com.shopmall.web.controllers.MemberController;
import com.shopmall.web.domains.Command;
import com.shopmall.web.domains.MemberDTO;
import com.shopmall.web.domains.MemberShopDTO;
import com.shopmall.web.domains.Retval;
import com.shopmall.web.mappers.MemberMapper;

@Service
@Lazy
public class MemberServiceImpl implements MemberService {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	@Autowired SqlSession sqlSession;
	@Autowired MemberDTO member;
	@Autowired MemberMapper memberMapper;
	
	@Override
	public String signUp(MemberDTO member) {
		System.out.println("MemberServiceImpl 진입");
		System.out.println("ID : " + member.getId());
		System.out.println("PW : " + member.getPw());
		System.out.println("EMAIL : " + member.getEmail());
		System.out.println("PHONE : " + member.getPhone());
		return (sqlSession.getMapper(MemberMapper.class).signUp(member) != 0) ? "SUCCESS" : "FAIL";
	}

	@Override
	public MemberDTO login(MemberDTO member) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		List<MemberDTO> list = new ArrayList<MemberDTO>();
		Command command = new Command();
		command.setKeyField("id");
		command.setKeyword(member.getId());
		list = mapper.find(command);
		
		if(list.size() == 0) {
			logger.info("MemberServiceImpl : 로그인 하려는 ID가 없습니다");
			member.setId("");
			member.setPw("");
			list.add(member);
			return list.get(0);
		}
		
		String id = list.get(0).getId();
		String pw = list.get(0).getPw();
		
		if(id.equals(member.getId()) && pw.equals(member.getPw())){
			logger.info("MemberServiceImpl : {}", "로그인 성공");
			return list.get(0);
			
		} else {
			logger.info("MemberServiceImpl : {}", "로그인 실패");
			list.get(0).setId("");
			list.get(0).setPw("");
			return list.get(0);
		}
	}

	@Override
	public List<MemberDTO> find(Command command) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.find(command);
	}

	@Override
	public int checkId(String id) {
		logger.info("MemberServiceImpl checkId : {}", id);
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.checkId(id);
	}

	@Override
	public int update(MemberDTO member) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.update(member);
	}

	@Override
	public List<MemberShopDTO> sellLog(Command command) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.sellLog(command);
	}

	@Override
	public int countSellLog(Command command) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.countSellLog(command);
	}

	@Override
	public int insertSellLog(Command command) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		return mapper.insertSellLog(command);
	}
}
