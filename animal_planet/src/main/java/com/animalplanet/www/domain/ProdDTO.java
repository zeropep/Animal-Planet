package com.animalplanet.www.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
@RequiredArgsConstructor
@AllArgsConstructor
public class ProdDTO {
	private NProductVO npvo;
	private UProductVO upvo;
	private List<FileVO> FList;
	
	public ProdDTO(NProductVO npvo, List<FileVO> FList) {
		this.npvo = npvo;
		this.FList = FList;
	}
	
	public ProdDTO(UProductVO upvo, List<FileVO> FList) {
		this.upvo = upvo;
		this.FList = FList;
	}
}
