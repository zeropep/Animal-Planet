package com.animalplanet.www.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class HospitalVO {
	private long hno;
	private long opnsfteamcode;
	private String mgtno;
	private int trdstategbn;
	private String trdstatenm;
	private String dcbymd;
	private String clgstdt;
	private String clgenddt;
	private String ropnymd;
	private String sitetel;
	private String sitewhladdr;
	private String rdnwhladdr;
	private String bplcnm;
	private String updatedt;
	private String lat;
	private String lon;
	
}
