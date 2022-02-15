package com.animalplanet.www.service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.animalplanet.www.domain.FileVO;
import com.animalplanet.www.domain.NProductVO;
import com.animalplanet.www.domain.PagingVO;
import com.animalplanet.www.domain.ProdDTO;
import com.animalplanet.www.repository.NProductDAO;
import com.animalplanet.www.repository.PCommentDAO;
import com.animalplanet.www.repository.PFileDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class NProductServiceImpl implements NProductService {
	@Inject
	private NProductDAO npdao;
	
	@Inject
	private PCommentDAO pcdao;
	
	@Inject
	private PFileDAO pfdao;
	
	@Transactional
	@Override
	public int register(ProdDTO dto) {
		int isUp = npdao.insertNProduct(dto.getNpvo());
		if (dto.getFList() != null) {
			if (isUp > 0 && dto.getFList().size() > 0) {
				long npno = npdao.selectOnePno();
				for (FileVO fvo : dto.getFList()) {
					fvo.setNpno(npno);
					pfdao.insertPFile(fvo);
				}
			}
			
		}
		return isUp;
	}

	@Transactional
	@Override
	public ProdDTO getDetail(long npno) {
		return new ProdDTO(npdao.selectOneNProduct(npno), pfdao.selectListPFile(npno));
	}

	@Override
	public ProdDTO selectForMod(long npno) {
		return new ProdDTO(npdao.selectOneNProduct(npno), pfdao.selectListPFile(npno));
	}

	@Override
	public int modify(ProdDTO dto) {
		int isUp = npdao.updateNProduct(dto.getNpvo());
		if (dto.getFList() != null) {
			if (isUp > 0 && dto.getFList().size() > 0) {
				for (FileVO fvo : dto.getFList()) {
					fvo.setNpno(dto.getNpvo().getNpno());
					pfdao.insertPFile(fvo);
				}
			}
		}
		return isUp;
	}

	@Override
	public int remove(long npno) {
		pcdao.deleteAllPComment(npno);
		return npdao.deleteProduct(npno);
	}

	@Override
	public List<ProdDTO> getList(PagingVO pgvo) {
		List<ProdDTO> pdtoList = new ArrayList<ProdDTO>();
		List<NProductVO> list = npdao.selectProductListPaging(pgvo);
		for (NProductVO npvo : list) {
			pdtoList.add(new ProdDTO(npvo, pfdao.selectListPFile(npvo.getNpno())));
		}
		return pdtoList;
	}

	@Override
	public int getTotalCount(PagingVO pgvo) {
		return npdao.selectOneTotalCount(pgvo);
	}
	
	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public int removeFile(String uuid) {
		return pfdao.deletePFile(uuid);
	}

	@Override
	public List<NProductVO> getList() {
		return null;
	}
	
}
