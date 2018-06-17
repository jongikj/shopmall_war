package com.shopmall.web.util;

import com.shopmall.web.constants.Values;

public class Pagination {
	public static int shopPageSize(int totCount){
		int page = 0;
		page = totCount % Values.SHOP_GROUP_SIZE == 0 ? totCount / Values.SHOP_GROUP_SIZE : (totCount / Values.SHOP_GROUP_SIZE) + 1; //총 페이지 수
		return page;
	}
	
	public static int[] shopGetStartEnd(int totCount, int pageSize, int pgNum){
		int[] arr = new int[5];
		int start = ((pgNum - 1) * Values.SHOP_GROUP_SIZE) + 1; //
		int end = Values.SHOP_GROUP_SIZE * pgNum;				//pgNum 1일 때 seq 1 ~ 12 까지
		int totPage = shopPageSize(totCount);
		int startPage = pgNum - ((pgNum - 1) % Values.SHOP_PG_SIZE);	//현재 페이지에 대응한 첫 페이지
		int endPage = (startPage + Values.SHOP_PG_SIZE - 1 <= totPage) ? startPage + Values.SHOP_PG_SIZE -1 : totPage; //현재 페이지에 대응한 마지막 페이지
		
		arr[0] = start;	
		arr[1] = end;
		arr[2] = totPage;
		arr[3] = startPage;
		arr[4] = endPage;
		return arr;
	}
	
	public static int faqPageSize(int totCount){
		int page = 0;
		page = totCount % Values.FAQ_GROUP_SIZE == 0 ? totCount / Values.FAQ_GROUP_SIZE : (totCount / Values.FAQ_GROUP_SIZE) + 1; //총 페이지 수
		return page;
	}
	
	public static int[] faqGetStartEnd(int totCount, int pageSize, int pgNum){
		int[] arr = new int[5];
		int start = ((pgNum - 1) * Values.FAQ_GROUP_SIZE) + 1; //
		int end = Values.FAQ_GROUP_SIZE * pgNum;				//pgNum 1일 때 seq 1 ~ 12 까지
		int totPage = faqPageSize(totCount);
		int startPage = pgNum - ((pgNum - 1) % Values.FAQ_PG_SIZE);	//현재 페이지에 대응한 첫 페이지
		int endPage = (startPage + Values.FAQ_PG_SIZE - 1 <= totPage) ? startPage + Values.FAQ_PG_SIZE -1 : totPage; //현재 페이지에 대응한 마지막 페이지
		
		arr[0] = start;	
		arr[1] = end;
		arr[2] = totPage;
		arr[3] = startPage;
		arr[4] = endPage;
		return arr;
	}
}