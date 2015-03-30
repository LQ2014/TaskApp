package com.cyancloud.model.system;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.cyancloud.commons.entity.BaseEntity;

@Entity
@Table(name = "T_RES_CONTACTS")
public class Contacts extends BaseEntity {

	private static final long serialVersionUID = 8080464173852314093L;

	private Long accId; // 用户的主键
	private String mobile; // 手机
	private String phone; // 电话
	private String qq; // qq
	private String email; // 邮箱
	private String weixin; // 微信
	private String address; // 地址
	
	@Id
	@Column(name = "acc_id")
	public Long getAccId() {
		return accId;
	}

	public void setAccId(Long accId) {
		this.accId = accId;
	}

	@Column(name = "mobile")
	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	@Column(name = "phone")
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	@Column(name = "qq")
	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	@Column(name = "email")
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name = "weixin")
	public String getWeixin() {
		return weixin;
	}

	public void setWeixin(String weixin) {
		this.weixin = weixin;
	}

	@Column(name = "address")
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Override
	public Object objId() {
		return accId;
	}

	@Override
	public String toString() {
		return null;
	}
}
