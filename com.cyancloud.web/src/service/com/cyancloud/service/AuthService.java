package com.cyancloud.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.cyancloud.model.system.Account2Unit;
import com.cyancloud.model.system.Right;
import com.cyancloud.model.system.Role2Right;
import com.cyancloud.service.model.RightBean;

public interface AuthService {
	
	public void addRight(Right right);
	
	public void editRight(Right right);
	
	public void deleteRight(Long id);
	
	public List<RightBean> listAuth(Long parentId);
	
	public Right getRightById(Long id);
	
	public List<RightBean> listAuthTree();
	
	public List<Role2Right> getR2RByRigthId(Long rightId);
	
	public void importAuth(MultipartFile myfile);
	
}
