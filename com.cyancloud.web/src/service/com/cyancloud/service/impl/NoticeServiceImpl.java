package com.cyancloud.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cyancloud.dao.NoticeDao;
import com.cyancloud.model.notice.Notice;
import com.cyancloud.model.system.Account;
import com.cyancloud.model.system.EnumConst;
import com.cyancloud.service.AclService;
import com.cyancloud.service.EnumConstService;
import com.cyancloud.service.NoticeService;
import com.cyancloud.service.model.NoticeBean;
import com.cyancloud.web.util.CommonUtils;
@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	private NoticeDao noticeDao;
	
	@Autowired
	private EnumConstService enumConstService;
	
	@Autowired
	private AclService aclService;

	@Override
	public List<Notice> searchNotice() {		
		return noticeDao.getAll();
	}

	@Override
	public void save(Map<String, String> map) throws Exception {
		String unitIds = map.get("unitIds");
		String employeeIds = map.get("employeeIds");
		String title = map.get("title");
		String content = map.get("content");
		String flagIsPublished = map.get("flagIsPublished");
		String sql = "";
		if(unitIds==null && StringUtils.isEmpty(unitIds)&& employeeIds==null && StringUtils.isEmpty(employeeIds)){
			throw new Exception("未选择发布的部门或者人员");
		}
		if(title==null || StringUtils.isEmpty(title)){
			throw new Exception("通知标题为空");
		}
		if(content==null || StringUtils.isEmpty(content)){
			throw new Exception("通知内容为空");
		}
		String ucode = map.get("ucode");
		Account user = aclService.getAccountByUcode(ucode);
		EnumConst enumConstIsPublished = enumConstService.getEnumConstByNamespaceAndCode("FLAG_IsPublish", (flagIsPublished.equals("true") ? "1" : "0"));
		Notice notice = new Notice();
		notice.setPublisher(user);
		notice.setContent(content);
		notice.setTitle(title);
		notice.setEnumConstByflagIsPublished(enumConstIsPublished);
		notice.setInputDate(new Date());
		notice.setCreateDate(new Date());
		noticeDao.save(notice);
		if(unitIds!=null && !StringUtils.isEmpty(unitIds)){
			String[] departmentIds = unitIds.split(",");
			sql = "insert into t_res_notice_unit(id,fk_notice_id,fk_unit_id)values  ";
			for (int i = 0; i < departmentIds.length; i++) {
				String departmentId = departmentIds[i];
				sql += "('"+CommonUtils.getUUID()+"','"+notice.getId()+"','"+departmentId+"'),";
			}
			sql = sql.substring(0,sql.lastIndexOf(","));
			noticeDao.executeSql(sql,null);
		}
		if(employeeIds!=null && !StringUtils.isEmpty(employeeIds)){
			String[] accountIds = employeeIds.split(",");
			sql = "insert into t_res_notice_employee(id,fk_notice_id,fk_employee_id)values  ";
			for (int i = 0; i < accountIds.length; i++) {
				String accountId = accountIds[i];
				sql += "('"+CommonUtils.getUUID()+"','"+notice.getId()+"','"+accountId+"'),";
			}
			sql = sql.substring(0,sql.lastIndexOf(","));
			noticeDao.executeSql(sql,null);
		}
		
		
	}

	@Override
	public void deleteNotice(String id) throws Exception {
		Map<String,Object> map = new HashMap<String, Object>();
		String sql = "delete from t_res_notice_employee where fk_notice_id =:noticeId";
		map.put("noticeId", id);
		this.noticeDao.executeSql(sql, map);
		sql = "delete from t_res_notice_unit where fk_notice_id =:noticeId";
		map = new HashMap<String, Object>();
		map.put("noticeId", id);
		this.noticeDao.executeSql(sql, map);
		sql = "delete from t_res_notice where id =:noticeId";
		map = new HashMap<String, Object>();
		map.put("noticeId", id);
		this.noticeDao.executeSql(sql, map);
		
	}

	@Override
	public void isPublishNotice(String id, String code) {
		EnumConst enumConstIsPublished = enumConstService.getEnumConstByNamespaceAndCode("FLAG_IsPublish", code);
		Notice notice = this.noticeDao.findById(id);
		notice.setEnumConstByflagIsPublished(enumConstIsPublished);
		this.noticeDao.update(notice);
		
	}

	@Override
	public List<NoticeBean> queryListByAccount(Account account) {
		return this.noticeDao.queryListByAccount(account);
	}

}
