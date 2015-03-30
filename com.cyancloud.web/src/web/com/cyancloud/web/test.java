package com.cyancloud.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
public class test {
	public static ApplicationContext ctx;
	
	public static void main(String[] args) {
		
		/*POIServiceImpl service = new POIServiceImpl();
		service.setAllowBlank(false);
		File file = new File("E:\\service_item_import.xls");
		List<List<String>> list = new ArrayList<List<String>>();
		try {
			service.initial(file, "xls");
			list = service.getCurrentSheetData(0, 1);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		for (List<String> list2 : list) {
			for (String string : list2) {
				if(string.equals("")){
					System.out.print("空,");
				}else{
					System.out.print(string+",");
				}
			}
			System.out.println();
		}
		*/
	/*	Double d = 1.000;
		int x=5;
		x= x+(x++)+(++x);
		System.out.println(x);
		String[] temp = d.toString().split("\\.");
		System.out.println(temp[0]);System.out.println(temp[1].equals("0"));*/
//		POIServiceImpl service = new POIServiceImpl();
//		service.setAllowBlank(false);
//		File file = new File("E:\\服务目录管理 (t_res_service_item).xls");
//		List<List<String>> list = new ArrayList<List<String>>();
//		try {
//			service.initial(file, "xls");
//			list = service.getCurrentSheetData(0);
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		for (List<String> list2 : list) {
//			for (String string : list2) {
//				if(string.equals("")){
//					System.out.print("空,");
//				}else{
//					System.out.print(string+",");
//				}
//			}
//			System.out.println();
//		}
	}
}
