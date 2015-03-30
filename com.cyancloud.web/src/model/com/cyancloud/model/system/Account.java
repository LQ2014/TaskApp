package com.cyancloud.model.system;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import com.cyancloud.commons.entity.BaseEntity;

@Entity
@Table(name = "T_RES_ACCOUNT")
public class Account extends BaseEntity
{
	private static final long serialVersionUID = -6928251267537760958L;
	private Long id;
	private String ucode;//登录名
	private String uname;//姓名
	private String uid;//uid from AD
	private Long unitId;// 部门ID,PK
	private Long customerId;// 所属单位ID,PK
	private String unitOu;// 部门ou;
	private String password;//密码
	private String email;//邮箱
	private Date ctime;//创建时间
	private Long state=1L;//状态
	private Long type;//状态
	private String phone;// 电话
	private Date updateDate;
	private String domain;
	
	private Long employeeId; // 员工ID
	
	private String attr1;//预留
	private String attr2;//预留
	private String attr3;//预留
	
	private Date dateline; // 账户截至日期
	
	@Id
	@Column(name = "id")
	@GeneratedValue(generator = "system-increment")
	@GenericGenerator(name = "system-increment", strategy = "increment")
	public Long getId()
	{
		return id;
	}
	
	public void setId(Long id)
	{
		this.id = id;
	}
	@Column(name = "ucode")
	public String getUcode() {
		return ucode;
	}

	public void setUcode(String ucode) {
		this.ucode = ucode;
	}
	@Column(name = "uname")
	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}
	@Column(name = "uid")
	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}
	@Column(name = "unit_id")
	public Long getUnitId() {
		return unitId;
	}

	public void setUnitId(Long unitId) {
		this.unitId = unitId;
	}
	
	@Column(name = "unit_ou")
	public String getUnitOu() {
		return unitOu;
	}

	public void setUnitOu(String unitOu) {
		this.unitOu = unitOu;
	}
	@Column(name = "password")
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	@Column(name = "email")
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	@Column(name = "ctime")
	public Date getCtime() {
		return ctime;
	}

	public void setCtime(Date ctime) {
		this.ctime = ctime;
	}
	@Column(name = "State")
	public Long getState() {
		return state;
	}

	public void setState(Long state) {
		this.state = state;
	}
	@Column(name = "type")
	public Long getType() {
		return type;
	}

	public void setType(Long type) {
		this.type = type;
	}
	@Column(name = "phone")
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	@Column(name = "update_date")
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	@Column(name = "attr1")
	public String getAttr1() {
		return attr1;
	}
	public void setAttr1(String attr1) {
		this.attr1 = attr1;
	}
	@Column(name = "attr2")
	public String getAttr2() {
		return attr2;
	}
	public void setAttr2(String attr2) {
		this.attr2 = attr2;
	}
	@Column(name = "attr3")
	public String getAttr3() {
		return attr3;
	}
	public void setAttr3(String attr3) {
		this.attr3 = attr3;
	}
	
	@Column(name = "customer_id")
	public Long getCustomerId() {
		return customerId;
	}
	
	@Column
	public String getDomain() {
		return domain;
	}

	public void setDomain(String domain) {
		this.domain = domain;
	}

	public void setCustomerId(Long customerId) {
		this.customerId = customerId;
	}

	@Column(name = "dateline")
	public Date getDateline() {
		return dateline;
	}

	public void setDateline(Date dateline) {
		this.dateline = dateline;
	}

	@Column(name = "employee_id")
	public Long getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(Long employeeId) {
		this.employeeId = employeeId;
	}



	public static class State
	{
		public static final Long LOCK = Long.valueOf(0);
		public static final Long NORMAL = Long.valueOf(1);
		public static final Long STOP = Long.valueOf(2);
		public static final Long DELETE = Long.valueOf(3);

	}
	
	public enum Type
	{
		SUPER_ADMIN, POOL_ADMIN,DESKTOP_ADMIN, COMMON,TEMP;

		public static Type get(Long index) {
			switch (index.intValue()) {
			case 0:
				return SUPER_ADMIN;
			case 1:
				return POOL_ADMIN;
			case 2:
				return DESKTOP_ADMIN;
			case 3:
				return COMMON;
			case 4:
				return TEMP;
			default:
				throw new AssertionError("Unknown op: " + index);

			}
		}
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