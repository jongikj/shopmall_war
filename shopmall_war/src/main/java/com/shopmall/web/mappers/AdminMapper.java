package com.shopmall.web.mappers;

import org.springframework.stereotype.Repository;

import com.shopmall.web.domains.DetailImageDTO;
import com.shopmall.web.domains.ShopDTO;

@Repository
public interface AdminMapper {
	public int sellListMaxSeq();
	public int insertSellList(ShopDTO shop);
	public int insertDetailImage(DetailImageDTO detail);
}
