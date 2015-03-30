package com.cyancloud.dao;

import java.util.List;
import java.util.Map;

import com.cyancloud.commons.dao.AbstractDao;
import com.cyancloud.model.notice.Notice;
import com.cyancloud.model.system.Account;
import com.cyancloud.service.model.NoticeBean;

public interface NoticeDao extends AbstractDao<Notice>{

	public int  executeSql(String sql,Map<String,Object> map)throws Exception;

	public List<NoticeBean> queryListByAccount(Account account);

}
