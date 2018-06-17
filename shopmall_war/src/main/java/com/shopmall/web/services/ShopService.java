package com.shopmall.web.services;

import java.util.List;

import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;

import com.shopmall.web.domains.Command;
import com.shopmall.web.domains.DetailImageDTO;
import com.shopmall.web.domains.MemberShopDTO;
import com.shopmall.web.domains.Retval;
import com.shopmall.web.domains.ShopDTO;

@Component
@Lazy
public interface ShopService {
	public int count(Command command);
	public List<ShopDTO> selectDesc();
	public List<ShopDTO> selectGenere();
	public List<ShopDTO> selectGenreDesc();
	public List<ShopDTO> selectAll();
	public List<ShopDTO> selectSearchAll(Command command);
	public List<ShopDTO> genre(Command command);
	public ShopDTO selectOneSeq(Command command);
	public ShopDTO readBuy(Command command);
	public int countImage(Command command);
	public List<DetailImageDTO> selectDetailImage(Command command);
	public int checkCount(Command command);
	public int updateCount(Command command);
	public int addWishlist(Command command);
	public MemberShopDTO selectWishOne(Command command);
	public List<MemberShopDTO> selectWishAll(Command command);
	public int wishCount(Command command);
	public int deleteWish(Command command);
}
