package com.cyancloud.model.system;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.cyancloud.commons.entity.BaseEntity;

@Entity
@Table(name = "T_RES_ROLE2SERVICE")
public class Role2Service extends BaseEntity{
	private static final long serialVersionUID = 1210218348595298840L;
	private Long id;
	private Long serviceId;
	private Long roleId;

	@Id
	@Column(name = "ID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@Column(name = "role_id")
	public Long getRoleId() {
		return roleId;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}

	@Column(name = "service_id")
	public Long getServiceId() {
		return serviceId;
	}

	public void setServiceId(Long serviceId) {
		this.serviceId = serviceId;
	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public Object objId() {
		// TODO Auto-generated method stub
		return null;
	}
}
