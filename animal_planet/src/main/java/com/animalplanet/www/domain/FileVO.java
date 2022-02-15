package com.animalplanet.www.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
@NoArgsConstructor
@AllArgsConstructor
public class FileVO {
	private String uuid;
	private String saveDir;
	private String fileName;
	private int fileType;
	private long fileSize;
	private long mno;
	private long bno;
	private long npno;
	private String regAt;
}
