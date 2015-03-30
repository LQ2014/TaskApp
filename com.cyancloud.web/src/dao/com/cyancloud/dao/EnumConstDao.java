package com.cyancloud.dao;

import java.util.List;

import com.cyancloud.commons.dao.AbstractDao;
import com.cyancloud.model.system.EnumConst;

public interface EnumConstDao extends AbstractDao<EnumConst>{

	public List<EnumConst> searchEnumConstByNamespace(String namespace);

	public EnumConst getEnumConstByNamespaceAndCode(String namespace,
			String code);

}
