package com.cyancloud.model.system;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.GenericGenerator;

import com.cyancloud.commons.entity.BaseEntity;

@Entity
@Table(name = "t_res_employee2unit")
public class Account2Unit extends BaseEntity
{
	private static final long serialVersionUID = -6928251267537760958L;
	@Id
	@GenericGenerator(name="idGenerator", strategy="uuid")  //hibernate的注解
	@GeneratedValue(generator="idGenerator") 				//使用uuid的生成策略
	private String id;
	
	@Column(name="KF_EMPLOYEE_ID")
	private Long employeeId;
	
	@Column(name="UNIT_ID")
	private Long unitId;
	
	@Column(name="CREATE_DATE")
	@Temporal(TemporalType.DATE)
	private Date createDate;
	

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Long getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(Long employeeId) {
		this.employeeId = employeeId;
	}

	public Long getUnitId() {
		return unitId;
	}

	public void setUnitId(Long unitId) {
		this.unitId = unitId;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
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