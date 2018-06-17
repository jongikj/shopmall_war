package com.shopmall.web.services;

import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;

import com.shopmall.web.domains.DetailImageDTO;
import com.shopmall.web.domains.ShopDTO;

@Component
@Lazy
public interface AdminService {
	public int sellListMaxSeq();
	public int insertSellList(ShopDTO shop);
	public int insertDetailImage(DetailImageDTO detail);
}
