package com.cyancloud.model.system;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.cyancloud.commons.entity.BaseEntity;

@Entity
@Table(name = "T_RES_ACCOUNT2ROLE")
public class Account2Role extends BaseEntity {

	private static final long serialVersionUID = 1210218348595298840L;
	private Long id;
	private Long accountId;
	private Long unitId;
	private Long roleId;
	
	public Account2Role(){
		
	}
	public Account2Role(Long accountId,Long roleId){
		this.accountId= accountId;
		this.roleId=roleId;
	}
	
	@Id
	@Column(name = "ELEMENT_ID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	@Column(name = "account_id")
	public Long getAccountId() {
		return accountId;
	}

	public void setAccountId(Long accountId) {
		this.accountId = accountId;
	}
	@Column(name = "role_id")
	public Long getRoleId() {
		return roleId;
	}

	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return null;
	}

	public void setUnitId(Long unitId) {
		this.unitId = unitId;
	}

	@Column(name = "unit_id")
	public Long getUnitId() {
		return unitId;
	}
	
	@Override
	public Object objId() {
		// TODO Auto-generated method stub
		return null;
	}

}
