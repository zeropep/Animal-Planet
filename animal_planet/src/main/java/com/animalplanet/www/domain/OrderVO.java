package com.animalplanet.www.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Getter @Setter @ToString
@NoArgsConstructor
public class OrderVO {
	private long ohno;
	private long cartno;
	private String buyer;
	private int price;
	private int totalPrice;
	private String pname;
	private long npno;
	private long upno;
	private String payment;
	private String method;
	private String payWith;
	private String request;
	private int amount;
	private String regAt;
}
