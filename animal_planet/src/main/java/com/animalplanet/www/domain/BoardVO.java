package com.animalplanet.www.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class BoardVO {
	private long bno;
	private String bCate;
	private String bTag;
	private String species;
	private String title;
	private String nickName;
	private	String content;
	private String regAt;
	private String modAt;
	private int readCount;
	private String location;
	private String gender;
	private String breed;
	private String lostDate;
	private int cmtQty;
}
