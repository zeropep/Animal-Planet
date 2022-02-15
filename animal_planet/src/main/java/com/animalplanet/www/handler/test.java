package com.animalplanet.www.handler;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.apache.commons.io.IOUtils;
import org.json.XML;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.animalplanet.www.domain.HospitalVO;
import com.animalplanet.www.service.HospitalService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.mchange.v2.cfg.PropertiesConfigSource.Parse;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class test {
	
	public void insertTest(HospitalService hsv) throws Exception {
		int count = 600;
		String reqUrl = "";
		for (int i = 0; i < 4; i++) {
			try {
				if (i < 3) {
					reqUrl = "http://openapi.seoul.go.kr:8088/5342736959706a6b3536796278744b/json/LOCALDATA_020301/" + (i * count + 1) + "/" + ((i + 1) * count) + "/";
				}
				URL url = new URL(reqUrl);
				BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
				
				String result = br.readLine();
				
				
//				log.debug(">> response : {}", result);
				
				JSONParser parser = new JSONParser();
				JSONObject jsonObj = (JSONObject) parser.parse(result);
				
				JSONObject localdata = (JSONObject) jsonObj.get("LOCALDATA_020301");
				int total = (int) ((long) localdata.get("list_total_count"));
				JSONArray row = (JSONArray) localdata.get("row");
				log.debug(reqUrl);
				for (int j = 0; j < (i == 3 ? total-(count*i) : count); j++) {
					HospitalVO hvo = new HospitalVO();
					JSONObject tempObj = (JSONObject) row.get(j);
					if (Integer.parseInt(tempObj.get("TRDSTATEGBN").toString()) < 3) {
						hvo.setOpnsfteamcode(Long.parseLong(tempObj.get("OPNSFTEAMCODE").toString()));
						hvo.setMgtno(tempObj.get("MGTNO").toString());
						hvo.setTrdstategbn(Integer.parseInt(tempObj.get("TRDSTATEGBN").toString()));
						hvo.setTrdstatenm(tempObj.get("TRDSTATENM").toString());
						hvo.setDcbymd((tempObj.get("DCBYMD").toString().length()) < 2 ? null : tempObj.get("DCBYMD").toString());
						hvo.setClgstdt((tempObj.get("CLGSTDT").toString().length()) < 2 ? null : tempObj.get("CLGSTDT").toString());
						hvo.setClgenddt((tempObj.get("CLGENDDT").toString().length()) < 2 ? null : tempObj.get("CLGENDDT").toString());
						hvo.setRopnymd((tempObj.get("ROPNYMD").toString().length()) < 2 ? null : tempObj.get("ROPNYMD").toString());
						hvo.setSitetel(tempObj.get("SITETEL").toString());
						hvo.setSitewhladdr(tempObj.get("SITEWHLADDR").toString());
						hvo.setRdnwhladdr(tempObj.get("RDNWHLADDR").toString());
						hvo.setBplcnm(tempObj.get("BPLCNM").toString());
						hvo.setUpdatedt(tempObj.get("UPDATEDT").toString().length() < 2 ? null : tempObj.get("UPDATEDT").toString().substring(0, 10));
						hvo.setLat(tempObj.get("Y").toString());
						hvo.setLon(tempObj.get("X").toString());
//						log.debug(hvo.toString());
						hsv.register(hvo);
					}
				}
				if (i == 2) {
					reqUrl = "http://openapi.seoul.go.kr:8088/5342736959706a6b3536796278744b/json/LOCALDATA_020301/" + (i * count + 2) + "/" + total + "/";
				}
				
				
				br.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
