package com.myweb.www.repos;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.inject.Inject;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.animalplanet.www.repository.HospitalDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.animalplanet.www.config.RootConfig.class})
public class HosTest {
	@Inject
	private HospitalDAO hdao;
	
	@Test
	public void insertTest() throws Exception {
		String reqUrl = "http://openapi.seoul.go.kr:8088/5342736959706a6b3536796278744b/json/LOCALDATA_020301_DJ/1/5/";
		try {
			URL url = new URL(reqUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setDoOutput(true);
			
			int responseCode = conn.getResponseCode();
			log.debug("response code : {}", responseCode);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			
			String line = "";
			String result = "";
			
			while ((line = br.readLine()) != null) {
				result += line;
			}
			log.debug("response body : {}", result);
			
			br.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
