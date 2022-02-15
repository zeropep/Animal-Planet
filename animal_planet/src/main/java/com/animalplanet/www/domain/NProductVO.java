package com.animalplanet.www.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@NoArgsConstructor
@Getter @Setter @ToString
public class NProductVO {
	private long npno;
	private String category1;
	private String category2;
	private String pname;
	private int price;
	private int stock;
	private String description;
	private String regAt;
	private String madeIn;
	private int hasFile;
}
