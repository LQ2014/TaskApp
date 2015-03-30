package com.cyancloud.model.system;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.codehaus.jackson.map.annotate.JsonSerialize;
import org.hibernate.annotations.GenericGenerator;

import com.cyancloud.commons.entity.BaseEntity;
import com.cyancloud.web.util.DateJsonSerializer;

@Entity
@Table(name = "T_RES_EMPLOYEE")
@JsonSerialize(include=JsonSerialize.Inclusion.NON_NULL)
public class Employee extends BaseEntity
{
	private static final long serialVersionUID = -6928251267537760958L;
		
	private Long id;
	private String code; // 员工号/登录名
	private String name; //员工姓名
	private Long unitId; // 部门ID，PK
	private String unitOu; // 部门OU
	private Date ctime; // 创建时间
	private Date updateDate; // 更新时间
	
	private String icon; // 员工头像
	private String nickname; // 昵称
	private String phone; // 手机
	private String address; // 地址
	private String weixin; // 微信
	private String qq; // QQ
	private String email; // 邮箱
	private String resume; // 简介
	
	private Long score; // 积分
	private Long isShowScore = 0L; // 是否显示积分
	private Long state = 1L; // 状态
	
	
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
	@Column(name = "code")
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	@Column(name = "name")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	@Column(name = "email")
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	@Column(name = "ctime")
	@Temporal(TemporalType.TIMESTAMP)
	@JsonSerialize(using=DateJsonSerializer.class,include=JsonSerialize.Inclusion.NON_NULL)
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
		
	@Column(name = "update_date")
	@Temporal(TemporalType.TIMESTAMP)
	@JsonSerialize(using=DateJsonSerializer.class,include=JsonSerialize.Inclusion.NON_NULL)
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	@Column(name = "icon")
	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	@Column(name = "nickname")
	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	@Column(name = "phone")
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	@Column(name = "address")
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Column(name = "weixin")
	public String getWeixin() {
		return weixin;
	}

	public void setWeixin(String weixin) {
		this.weixin = weixin;
	}

	@Column(name = "qq")
	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	@Column(name = "resume")
	public String getResume() {
		return resume;
	}

	public void setResume(String resume) {
		this.resume = resume;
	}

	@Column(name = "score")
	public Long getScore() {
		return score;
	}

	public void setScore(Long score) {
		this.score = score;
	}

	@Column(name = "is_show_score")
	public Long getIsShowScore() {
		return isShowScore;
	}

	public void setIsShowScore(Long isShowScore) {
		this.isShowScore = isShowScore;
	}

	public enum IsShowScore {
		SHOW_PUBLIC, NOT_SHOW, SHOW_PRIVATE;
		
		public static IsShowScore get(Long index) {
			switch (index.intValue()) {
			case 0:
				return SHOW_PUBLIC;
			case 1:
				return NOT_SHOW;
			case 2:
				return SHOW_PRIVATE;
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