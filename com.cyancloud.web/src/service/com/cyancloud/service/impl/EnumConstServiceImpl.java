package com.cyancloud.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cyancloud.dao.EnumConstDao;
import com.cyancloud.model.system.EnumConst;
import com.cyancloud.service.EnumConstService;
@Service("enumConstService")
public class EnumConstServiceImpl implements EnumConstService {
	@Autowired
	private EnumConstDao enumConstDao;
	
	@Override
	public List<EnumConst> getEnumConstsByNamespace(String namespace){		
		return enumConstDao.searchEnumConstByNamespace(namespace);
	}
	
	@Override
	public EnumConst getEnumConstByNamespaceAndCode(String namespace,String code){
		return enumConstDao.getEnumConstByNamespaceAndCode(namespace,code);
	}

	@Override
	public List<EnumConst> getAllEnumConsts() {
		return enumConstDao.getAll();
	}
}
