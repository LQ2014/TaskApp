package com.cyancloud.service;

import java.util.List;
import java.util.Map;

import com.cyancloud.model.notice.Notice;
import com.cyancloud.model.system.Account;
import com.cyancloud.service.model.NoticeBean;

public interface NoticeService {

	public List<Notice> searchNotice();

	public void save(Map<String, String> map)throws Exception;

	public void deleteNotice(String id) throws Exception;

	public void isPublishNotice(String id, String code);

	public List<NoticeBean> queryListByAccount(Account account);

}
