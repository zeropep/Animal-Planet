package com.animalplanet.www.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Getter @Setter @ToString
@NoArgsConstructor
public class CartVO {
	private long cartno;
	private String owner;
	private long npno;
	private String pname;
	private int cartStock;
	private int price;
	private String regAt;
	private String image;
}
