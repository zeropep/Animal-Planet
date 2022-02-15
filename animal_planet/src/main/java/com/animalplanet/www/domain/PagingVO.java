package com.animalplanet.www.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Getter @Setter @ToString
public class PagingVO {
	private int pageNo; 
	private int qty; 
	
	private String type;
	private String keyword;
	
	// for shop
	private String category1;
	private String category2;
	
	// for board
	private String bCate;
	private String bTag;
	private String species;
	
	public PagingVO() {
		this(1, 10);
	}
	
	public PagingVO(int pageNo, int qty) {
		this.pageNo = pageNo;
		this.qty = qty;
	}
	
	public int getPageStart() {
		return (this.pageNo - 1) * qty;
	}
	
	public String[] getTypeToArray() {
		return this.type == null ? new String[] {} : this.type.split("");
	}
}
