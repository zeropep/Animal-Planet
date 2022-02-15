package com.animalplanet.www.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@NoArgsConstructor
@Getter @Setter @ToString
public class UProductVO {
	private long upno;
	private String category;
	private String pname;
	private int price;
	private String description;
	private String regAt;
	private String modAt;
	private String state;
	private int hasFile;
}
