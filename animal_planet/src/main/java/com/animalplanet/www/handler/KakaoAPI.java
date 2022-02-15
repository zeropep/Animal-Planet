package com.animalplanet.www.handler;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Component;

import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@NoArgsConstructor
@Component
public class KakaoAPI {
	
	public HashMap<String, Object> getUserInfo(String accessToken) {
		HashMap<String, Object> userInfo = new HashMap<>();
		String reqUrl = "https://kapi.kakao.com/v2/user/me";
		try {
			URL url = new URL(reqUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "Bearer " + accessToken);
			int responseCode = conn.getResponseCode();
			log.info("responseCode : {}", Integer.toString(responseCode));
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			
			String line = "";
			String result = "";
			
			while ((line = br.readLine()) != null) {
				result += line;
			}
			log.info("response body : {}", result);
			
			JSONParser parser = new JSONParser();
			JSONObject jsonObj = (JSONObject) parser.parse(result.toString());
			JSONObject kakao_account = (JSONObject) parser.parse(jsonObj.get("kakao_account").toString());
			
			String id = jsonObj.get("id").toString();
			String email = kakao_account.get("email").toString();
			
			userInfo.put("id", id);
			userInfo.put("email", email);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userInfo;
	}
	
	public String getAccessToken(String code) {
		String accessToken = "";
		String refreshToken = "";
		String reqUrl = "https://kauth.kakao.com/oauth/token";
		try {
			URL url = new URL(reqUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=4e5eb59040c6799cc2937663ddcad8ec");
			sb.append("&redirect_uri=http://localhost:8088/member/kakaologin");
			sb.append("&code=" + code);
			
			bw.write(sb.toString());
			bw.flush();
			
			int responseCode = conn.getResponseCode();
			log.info("response code : {}", responseCode);
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			
			String line = "";
			String result = "";
			
			while ((line = br.readLine()) != null) {
				result += line;
			}
			log.info("response body : {}", result);
			
			JSONParser parser = new JSONParser();
			JSONObject jsonObj = (JSONObject) parser.parse(result.toString());
			
			accessToken = jsonObj.get("access_token").toString();
			refreshToken = jsonObj.get("refresh_token").toString();
			
			br.close();
			bw.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return accessToken;
	}

	public void kakaoLogout(String accessToken) {
		String reqUrl = "https://kapi.kakao.com/v1/user/logout";
		try {
			URL url = new URL(reqUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "Bearer " + accessToken);
			int responseCode = conn.getResponseCode();
			log.info("responseCode : {}", Integer.toString(responseCode));
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			
			String line = "";
			String result = "";
			
			while ((line = br.readLine()) != null) {
				result += line;
			}
			log.info("id " + result + " is logged out");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	

	public void kakaoUnlink(String accessToken) {
		String reqUrl = "https://kapi.kakao.com/v1/user/unlink";
		try {
			URL url = new URL(reqUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "Bearer " + accessToken);
			int responseCode = conn.getResponseCode();
			log.info("responseCode : {}", Integer.toString(responseCode));
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			
			String line = "";
			String result = "";
			
			while ((line = br.readLine()) != null) {
				result += line;
			}
			log.info("id " + result + " is unlinked");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
