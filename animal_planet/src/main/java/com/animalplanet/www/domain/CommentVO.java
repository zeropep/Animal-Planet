package com.animalplanet.www.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter @Setter @ToString
public class CommentVO {
	private long cno;
	private long npno;
	private long upno;
	private long bno;
	private long hno;
	private String nickName;
	private String content;
	private String regAt;
	private String modAt;
}
