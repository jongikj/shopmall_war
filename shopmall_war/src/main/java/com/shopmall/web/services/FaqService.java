package com.shopmall.web.services;

import java.util.List;

import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;

import com.shopmall.web.domains.Command;
import com.shopmall.web.domains.FaqDTO;

@Component
@Lazy
public interface FaqService {
	public int countAll();
	public int countId(Command command);
	public int countTitle(Command command);
	public List<FaqDTO> selectAll(Command command);
	public int insertFaq(FaqDTO faq);
	public List<FaqDTO> selectAllId(Command command);
	public List<FaqDTO> selectOneSeq(Command command);
	public FaqDTO nextSelectSeq(Command command);
	public FaqDTO beforeSelectSeq(Command command);
	public FaqDTO myNextSelectSeq(Command command);
	public FaqDTO myBeforeSelectSeq(Command command);
	public int update(FaqDTO faq);
	public int delete(Command command);
	public List<FaqDTO> findTitle(Command command);
}
