package com.shopmall.web.mappers;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.shopmall.web.domains.Command;
import com.shopmall.web.domains.FaqDTO;

@Repository
public interface FaqMapper {
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
