package com.animalplanet.www.handler;

import java.io.File;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.animalplanet.www.domain.FileVO;
import com.animalplanet.www.repository.BFileDAO;
import com.animalplanet.www.repository.MemberFileDAO;
import com.animalplanet.www.repository.PFileDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class FileSweeper {
	private final String BASE_PATH = "C:\\develop\\_java\\fileUpload\\";
	
	@Inject
	private MemberFileDAO mfdao;
	
	@Scheduled(cron = "0 00 03 01 * *") // cron = "초 분 시 일 월 요일 년도(생략가능)"
	public void fileSweeper() throws Exception {
		log.info(">>> FileSweeper Running Start : {}", LocalDateTime.now());
		
		// DB에 등록된 파일 목록 가져오기
		List<FileVO> Files = mfdao.selectListAllFiles();
		
		// 저장소를 검색할 때 필요한 파일 경로 리스트
		List<String> PathList = new ArrayList<String>();
		
		for (FileVO fvo : Files) {
			String filePath = fvo.getSaveDir() + "\\" + fvo.getUuid() + "_" + fvo.getFileName();
			PathList.add(BASE_PATH + filePath);
			// 이미지 파일일 경우 썸네일 파일 경로도 추가
			if (fvo.getFileType() > 0) {
				PathList.add(BASE_PATH + fvo.getSaveDir() + "\\" + fvo.getUuid() + "_th_" + fvo.getFileName());
			}
		}
		
		// 날짜를 반영한 폴더 구조 경로 만들기
		LocalDate now = LocalDate.now(); // minusDays(1L) : 날짜변경
		String today = now.toString();
		today = today.replace("-", File.separator);
		
		// 경로를 기반으로 저장되어 있는 파일 검색
		// 파일 전용 패키지, io패키지가 아니라 nio패키지(new io)이다.
		// Paths.get(BASE_PATH + today) : 로컬 디스크 검색기능
		// .toFile() : 파일 객체로 만들어줌
		File dir = Paths.get(BASE_PATH + today).toFile();
		File[] allFileObjects = dir.listFiles();
		
		// 실제 저장되어 있는 파일과 DB에 기반하여 존재해야되는 파일을 비교하여 삭제 진행
		for (File file : allFileObjects) {
			String storedFileName = file.toPath().toString(); // 실제 저장된 파일 이름
			if (!PathList.contains(storedFileName)) {
				file.delete();
				log.info(">>> delete : {}", storedFileName);
			}
		}
		
		log.info(">>> FileSweeper Running Finish : {}", LocalDateTime.now());
	}
}
