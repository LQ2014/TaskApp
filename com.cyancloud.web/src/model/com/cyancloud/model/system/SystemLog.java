package com.cyancloud.model.system;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.hibernate.annotations.GenericGenerator;

import com.cyancloud.commons.entity.LongSequenceIdEntity;

@Entity
@Table(name = "T_RES_LOG")
public class SystemLog extends LongSequenceIdEntity {
	/**
	 * 
	 */
	private static final long serialVersionUID = 3356135404052369757L;
	private Long id;// PK
	private String ip;// 登陆IP
	private String inpath;// 访问路径
	private String mcode;// 功能代码
	private String description;// 描述
	private Date optime;// 操作时间
	private String ucode;// 用户登录名
	private String uid;// 用户表示From AD
	private String deptid;// 部门ID from AD
	private String deptname;// 部门名称

	private String sessionid;// session id
	private Long result;// 结果 1：成功；0失败

	/** default constructor */
	public SystemLog() {
	}

	/** full constructor */
	public SystemLog(Date optime, String ucode, String ip, String inpath,
			Long result, String demo) {
		this.optime = optime;
		this.inpath = inpath;
		this.result = result;
		this.description = demo;
		this.ucode = ucode;
		this.ip = ip;
	}

	@Column(name = "MCODE")
	public String getMcode() {
		return this.mcode;
	}

	public void setMcode(String mcode) {
		this.mcode = mcode;
	}

	@Column(name = "op_time")
	public Date getOptime() {
		return this.optime;
	}

	public void setOptime(Date optime) {
		this.optime = optime;
	}

	@Column(name = "sessionid")
	public String getSessionid() {
		return this.sessionid;
	}

	public void setSessionid(String sessionid) {
		this.sessionid = sessionid;
	}

	@Column(name = "inpath")
	public String getInpath() {
		return this.inpath;
	}

	public void setInpath(String inpath) {
		this.inpath = inpath;
	}

	@Column(name = "result")
	public Long getResult() {
		return this.result;
	}

	public void setResult(Long result) {
		this.result = result;
	}

	@Column(name = "description")
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Column(name = "ucode")
	public String getUcode() {
		return this.ucode;
	}

	public void setUcode(String ucode) {
		this.ucode = ucode;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	@Column(name = "uid")
	public String getUid() {
		return uid;
	}

	@Column(name = "ip")
	public String getIp() {
		return this.ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	@Column(name = "dept_name")
	public String getDeptname() {
		return deptname;
	}

	public void setDeptname(String deptname) {
		this.deptname = deptname;
	}

	@Column(name = "dept_id")
	public String getDeptid() {
		return deptid;
	}

	public void setDeptid(String deptId) {
		this.deptid = deptId;
	}

	@Override
	public String toString() {
		ToStringBuilder sb = new ToStringBuilder(this,
				ToStringStyle.SHORT_PREFIX_STYLE);
		sb.append("mcode", mcode);
		sb.append("ip", ip);
		return sb.toString();
	}
	@Override
	public Object objId() {
		// TODO Auto-generated method stub
		return null;
	}
}