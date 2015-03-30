package com.cyancloud.service;

import java.util.List;

import com.cyancloud.model.system.EnumConst;

public interface EnumConstService {

	public List<EnumConst> getEnumConstsByNamespace(String namespace);

	public EnumConst getEnumConstByNamespaceAndCode(String namespace, String code);
	
	public List<EnumConst> getAllEnumConsts();

}
