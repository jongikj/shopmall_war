package com.shopmall.web.domains;

import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Component
@Lazy
public class DetailImageDTO {
	@Getter @Setter private int seq, seq_sell_list;
	@Getter @Setter private String image_url;
}
