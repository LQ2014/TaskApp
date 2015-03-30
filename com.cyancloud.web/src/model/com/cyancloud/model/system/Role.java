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
@Table(name = "T_RES_ROLE")
public class Role extends BaseEntity{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -1602825948384084799L;
	private Long id;//PK
	private String name;//名称
	private String description;//备注
	private String type;//类型,预留
	private Date ctime;//创建时间
	private Long state;//状态:1 启用;0 禁用
	private String attr1;//预留
	private String attr2;//预留
	private String attr3;//预留
	
	@Id
	@Column(name = "id")
	@GeneratedValue(generator = "system-increment")
	@GenericGenerator(name = "system-increment", strategy = "increment")
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	@Column(name = "name")
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@Column(name = "description")
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	@Column(name = "type")
	public String getType() {
		return type;
	}
	
	public void setType(String type) {
		this.type = type;
	}
	@Column(name = "ctime")
	public Date getCtime() {
		return ctime;
	}
	public void setCtime(Date ctime) {
		this.ctime = ctime;
	}
	@Column(name = "state")
	public Long getState() {
		return state;
	}
	public void setState(Long state) {
		this.state = state;
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
