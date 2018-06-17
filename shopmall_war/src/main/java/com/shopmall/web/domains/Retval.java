package com.shopmall.web.domains;

import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Component
@Lazy
public class Retval {
	@Getter @Setter private String msg;
	@Getter @Setter private int flag, count;
}
