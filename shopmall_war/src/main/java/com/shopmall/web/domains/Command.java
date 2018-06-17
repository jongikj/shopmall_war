package com.shopmall.web.domains;

import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Component
@Lazy
public class Command {
	@Getter @Setter private String keyField, keyword, id;
	@Getter @Setter private int seq, count, start, end;
}
