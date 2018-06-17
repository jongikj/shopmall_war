package com.shopmall.web.services;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import com.shopmall.web.controllers.MemberController;
import com.shopmall.web.domains.Command;
import com.shopmall.web.domains.FaqDTO;
import com.shopmall.web.mappers.FaqMapper;

@Service
@Lazy
public class FaqServiceImpl implements FaqService {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	@Autowired SqlSession sqlSession;
	@Autowired FaqDTO faq;
	@Autowired FaqMapper mapper;
	
	@Override
	public List<FaqDTO> selectAll(Command command) {
		FaqMapper mapper = sqlSession.getMapper(FaqMapper.class);
		return mapper.selectAll(command);
	}

	@Override
	public int countAll() {
		FaqMapper mapper = sqlSession.getMapper(FaqMapper.class);
		return mapper.countAll();
	}

	@Override
	public int insertFaq(FaqDTO faq) {
		FaqMapper mapper = sqlSession.getMapper(FaqMapper.class);
		return mapper.insertFaq(faq);
	}

	@Override
	public List<FaqDTO> selectAllId(Command command) {
		FaqMapper mapper = sqlSession.getMapper(FaqMapper.class);
		return mapper.selectAllId(command);
	}

	@Override
	public int countId(Command command) {
		FaqMapper mapper = sqlSession.getMapper(FaqMapper.class);
		return mapper.countId(command);
	}
	
	@Override
	public int countTitle(Command command) {
		FaqMapper mapper = sqlSession.getMapper(FaqMapper.class);
		return mapper.countTitle(command);
	}

	@Override
	public List<FaqDTO> selectOneSeq(Command command) {
		FaqMapper mapper = sqlSession.getMapper(FaqMapper.class);
		return mapper.selectOneSeq(command);
	}

	@Override
	public FaqDTO nextSelectSeq(Command command) {
		FaqMapper mapper = sqlSession.getMapper(FaqMapper.class);
		return mapper.nextSelectSeq(command);
	}

	@Override
	public FaqDTO beforeSelectSeq(Command command) {
		FaqMapper mapper = sqlSession.getMapper(FaqMapper.class);
		return mapper.beforeSelectSeq(command);
	}

	@Override
	public FaqDTO myNextSelectSeq(Command command) {
		FaqMapper mapper = sqlSession.getMapper(FaqMapper.class);
		return mapper.myNextSelectSeq(command);
	}

	@Override
	public FaqDTO myBeforeSelectSeq(Command command) {
		FaqMapper mapper = sqlSession.getMapper(FaqMapper.class);
		return mapper.myBeforeSelectSeq(command);
	}

	@Override
	public int update(FaqDTO faq) {
		FaqMapper mapper = sqlSession.getMapper(FaqMapper.class);
		return mapper.update(faq);
	}

	@Override
	public int delete(Command command) {
		FaqMapper mapper = sqlSession.getMapper(FaqMapper.class);
		return mapper.delete(command);
	}
	
	@Override
	public List<FaqDTO> findTitle(Command command) {
		FaqMapper mapper = sqlSession.getMapper(FaqMapper.class);
		return mapper.findTitle(command);
	}
}
