package com.cyancloud.web.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.cyancloud.commons.web.BaseAbstractController;
import com.cyancloud.model.system.Account;
import com.cyancloud.web.util.ConfigUtil;

@Controller
@RequestMapping("/upload")
public class IconUploadController extends BaseAbstractController {
	private File icon;
	private String iconContentType;
	private String iconFileName;

	public File getIcon() {
		return icon;
	}

	public void setIcon(File icon) {
		this.icon = icon;
	}

	public String getIconContentType() {
		return iconContentType;
	}

	public void setIconContentType(String iconContentType) {
		this.iconContentType = iconContentType;
	}

	public String getIconFileName() {
		return iconFileName;
	}

	public void setIconFileName(String iconFileName) {
		this.iconFileName = iconFileName;
	}

	/**
	 * 用户上传图像
	 */
	@RequestMapping("/uploadIcon.do")
	public void uploadIcon(MultipartFile icon, HttpServletRequest request, HttpServletResponse response,
			Model model){
		try {
			response.setCharacterEncoding("UTF-8");
			File f = new File(ConfigUtil.getCfg("icon-path"), icon.getOriginalFilename());
			FileUtils.copyInputStreamToFile(icon.getInputStream(), f);
			setIconFileName(f.getName());
			setIcon(f);
			FileInputStream fis2 = new FileInputStream(getIcon());        //判断文件

			int i = this.checkImage(fis2);
			if(i==1){
				response.getWriter().print("1");
			}
			else if(i==2){
				response.getWriter().print("2");
			}
			else if(i==3){
				response.getWriter().print("3");
			}
			else {   //文件正确、上传
				//得到文件名
				String iconName = getIconName(request, response, getIconFileName());
				
				//处理文件路径,便于在前台显示
				String imagPathString = dealPath(getSavePath()+"\\"+iconName);
				System.out.println(imagPathString);
				response.getWriter().print(imagPathString);
				
			}
		} 
		catch (IOException e) {
			e.printStackTrace();
		}
	
	}
	
	/**
	 * 重新命名头像名称:用户编号+头像后缀
	 * @param response 
	 * @param request 
	 */
	public String getIconName(HttpServletRequest request, HttpServletResponse response, String iconName){
		//获取用户
		//Account account = (Account) request.getSession().getAttribute("ACCOUNT");
		
		//获取文件的后缀
		String[] strings = iconName.split("\\.");
		String hz = strings[1];
		
		//构建文件名
		String fileName = System.currentTimeMillis() + "." + hz;
		return fileName;
	}
	
	/**
	 * 获取上传路径
	 */
	public String getSavePath(){
		return ConfigUtil.getCfg("icon-path");
	}
	
	/**
	 * 判断上传的头像是否合法
	 * 规则：宽度和高度大于200、宽高比小于2、大小小于2M
	 * 宽度或者高度<200 返回1
	 * 宽高比>2 返回2
	 * 大小大于2M 返回 3
	 * 正确 返回 0
	 */
	public int checkImage(FileInputStream fis){
		try {
			BufferedImage image = ImageIO.read(fis);
			double width = image.getWidth();
			double height = image.getHeight();
			if(width<200||height<200){
				return 1;
			}
			else if(width/height>2){
				return 2;
			}
			else if(fis.available()/(1024*1024)>2){
				return 3;
			}
			else {
				return 0;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return 1;
	}
	
	/**
	 * 处理头像路径
	 */
	public String dealPath(String path){
		String[] strings = path.split("\\\\");
		String string2 = "/";
		for (int i = strings.length-4; i < strings.length; i++) {
			if(i==strings.length-1){
				string2 = string2+strings[i];
			}
			else {
				string2 = string2+strings[i]+"/";
			}
				
		}
		return string2;
	}
}
