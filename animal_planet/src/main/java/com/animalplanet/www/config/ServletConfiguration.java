package com.animalplanet.www.config;

import java.io.IOException;
import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@EnableGlobalMethodSecurity(prePostEnabled = true, securedEnabled = true) // add 1
@EnableWebMvc
@ComponentScan(basePackages = {"com.animalplanet.www.ctrl", "com.animalplanet.www.handler"})
public class ServletConfiguration implements WebMvcConfigurer {

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
		registry.addResourceHandler("/upload/**").addResourceLocations("file:///C:/develop/_java/fileUpload/");
		// 파일위치 각자에 맞게 수정 바랍니다.
	}

	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		InternalResourceViewResolver viewResolver
			= new InternalResourceViewResolver();
		viewResolver.setViewClass(JstlView.class);
		viewResolver.setPrefix("/WEB-INF/views/");
		viewResolver.setSuffix(".jsp");
		registry.viewResolver(viewResolver);
	}
	@Bean(name = "multipartResolver")
	public MultipartResolver getMultipartResolver() throws IOException {
		StandardServletMultipartResolver multipartResolver = new StandardServletMultipartResolver();
		return multipartResolver;
	}
	
	// gmail 발송 
		@Bean(name = "mailSender")
		public static JavaMailSender mailSender() {
			JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
			mailSender.setHost("smtp.gmail.com");
			mailSender.setPort(587);
			mailSender.setUsername("animalplanet1224@gmail.com");
			mailSender.setPassword("animal1224!");
			mailSender.setDefaultEncoding("UTF-8");

			Properties javaMailProps = new Properties();
			javaMailProps.put("mail.smtp.auth", true);
			javaMailProps.put("mail.smtp.starttls.enable", true);
			javaMailProps.put("mail.transport.protocol", "smtp");
			javaMailProps.put("mail.debug", true);
			javaMailProps.put("mail.smtp.ssl.trust", "smtp.gmail.com");
			javaMailProps.put("mail.smtp.ssl.protocols", "TLSv1.2");
			mailSender.setJavaMailProperties(javaMailProps);

			return mailSender;
		}
}
