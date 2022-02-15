package com.animalplanet.www.handler;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.tika.Tika;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.animalplanet.www.domain.FileVO;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnails;

@Slf4j
@AllArgsConstructor
@Component
public class FileHandler {
	private final String UP_DIR = "C:\\develop\\_java\\fileUpload";
	
	public FileVO summernoteImage(MultipartFile file) {
		LocalDate date = LocalDate.now();
		String today = date.toString(); // 2022-01-10
		today = today.replace("-", File.separator); // 2022\01\10(win), 2022/01/10(linux)
		
		File folders = new File(UP_DIR, today);
		
		if (!folders.exists()) {
			folders.mkdirs();
		}
		
		FileVO fvo = new FileVO();
		fvo.setSaveDir(today);
		fvo.setFileSize(file.getSize());
		
		String originalFileName = file.getOriginalFilename();	//오리지날 파일명
		log.debug(">>> originalFileName : {}", originalFileName);
		String onlyFileName = originalFileName.substring(originalFileName.lastIndexOf("\\")+1);
		
		fvo.setFileName(onlyFileName);
		
		UUID uuid = UUID.randomUUID();
		fvo.setUuid(uuid.toString());
		
		String fullFileName = uuid.toString() + "_" + onlyFileName;
		File storeFile = new File(folders, fullFileName);
		
		
		try {
			file.transferTo(storeFile); //원본객체를 저장을 위한 형태로 만든 객체로 복사
			String mimeType = new Tika().detect(storeFile);		
			if (mimeType.startsWith("image")) {
				fvo.setFileType(1);
				File thumbNail = new File(folders,
						uuid.toString() + "_th_" + onlyFileName);
				Thumbnails.of(storeFile).size(100, 100).toFile(thumbNail);
			}
		} catch (Exception e) {
			log.debug(">>> File 생성 오류!!!");
			e.printStackTrace();
		}
		return fvo;
	}
	
	public List<FileVO> uploadFiles(MultipartFile[] files) {
		LocalDate date = LocalDate.now();
		String today = date.toString(); // 2022-01-10
		today = today.replace("-", File.separator); // 2022\01\10
		
		File folders = new File(UP_DIR, today);
		
		if (!folders.exists()) {
			folders.mkdirs();
		}
		List<FileVO> FList = new ArrayList<FileVO>();
		
		for (MultipartFile file : files) {
			// fvo에 저장할 파일 정보 생성 => DB로 간다
			FileVO fvo = new FileVO();
			fvo.setSaveDir(today);
			fvo.setFileSize(file.getSize());
			
			String originalFileName = file.getOriginalFilename();
			log.debug(">>> {}", originalFileName);
			String onlyFileName = originalFileName.substring(originalFileName.lastIndexOf("\\") + 1); // 확장자를 포함한 파일네임.
			log.debug(">>> {}", onlyFileName);
			fvo.setFileName(onlyFileName);
			
			UUID uuid = UUID.randomUUID();
			fvo.setUuid(uuid.toString());
			
			// 실제로 저장공간에 저장할 파일 객체 생성
			String fullFileName = uuid.toString() + "_" + onlyFileName;
			File storeFile = new File(folders, fullFileName);
			
			try {
				file.transferTo(storeFile); // 원본객체를 저장을 위한 형태로 만든 객체로 복사
				// apache.tika lib 파일의 header를 열 수 있다.
				if (isImageFile(storeFile)) {
					fvo.setFileType(1); // 이미지는 파일타입을 1이라고 정한다.
					File thumbNail = new File(folders, uuid.toString() + "_th_" + onlyFileName);
					Thumbnails.of(storeFile).size(100, 100).toFile(thumbNail);
				}
			} catch (Exception e) {
				log.debug(">>> File 생성 오류");
				e.printStackTrace();
			}
			FList.add(fvo);
		}
		
		return FList;
	}

	private boolean isImageFile(File storeFile) throws IOException {
		String mimeType = new Tika().detect(storeFile); 
		// mimeType : 멀티미디어 파일타입을 지칭하는 용어
		// tika lib를 통해서 파일의 타입을 알 수 있다.
		return mimeType.startsWith("image") ? true : false;
	}
	
}
