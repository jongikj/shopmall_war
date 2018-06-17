package com.shopmall.web.services;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;

import com.shopmall.web.domains.DetailImageDTO;
import com.shopmall.web.domains.ShopDTO;
import com.shopmall.web.mappers.AdminMapper;

@Service
@Lazy
public class AdminServiceImpl implements AdminService {
	private static final Logger logger = LoggerFactory.getLogger(AdminMapper.class);
	@Autowired SqlSession sqlSession;
	
	@Override
	public int sellListMaxSeq() {
		AdminMapper mapper = sqlSession.getMapper(AdminMapper.class);
		return mapper.sellListMaxSeq();
	}

	@Override
	public int insertSellList(ShopDTO shop) {
		AdminMapper mapper = sqlSession.getMapper(AdminMapper.class);
		return mapper.insertSellList(shop);
	}

	@Override
	public int insertDetailImage(DetailImageDTO detail) {
		AdminMapper mapper = sqlSession.getMapper(AdminMapper.class);
		return mapper.insertDetailImage(detail);
	}
}
