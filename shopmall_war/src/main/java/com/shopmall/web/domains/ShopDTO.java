package com.shopmall.web.domains;

import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Component
@Lazy
public class ShopDTO {
	@Getter @Setter private int seq, count, price;
	@Getter @Setter private String title, image, genre, genre_eng, detail;
}
