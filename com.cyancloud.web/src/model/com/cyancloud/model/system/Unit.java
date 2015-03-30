package com.cyancloud.model.system;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.cyancloud.commons.entity.BaseEntity;

@Entity
@Table(name = "T_RES_UNIT")
public class Unit extends BaseEntity{
	private static final long serialVersionUID = 2035582175152201250L;
	private Long id;//FK
	private String name;//部门名称
	//private String admin;//管理员，预留
	private Long count;//部门人数
	private Long state=1L;//状态
	private String ou;//uid
	private String parentOu;//parent uid
	private Long parentId;//父部门id,fk
	private Date updateDate;
	private String note;	
	private Employee leader;
	
	@Id
	@Column(name = "ID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
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
	@Column(name = "count")
	public Long getCount() {
		return count;
	}
	public void setCount(Long count) {
		this.count = count;
	}
	@Column(name = "state")
	public Long getState() {
		return state;
	}
	public void setState(Long state) {
		this.state = state;
	}
	@Column(name = "ou")
	public String getOu() {
		return ou;
	}
	public void setOu(String ou) {
		this.ou = ou;
	}
	@Column(name = "parent_ou")
	public String getParentOu() {
		return parentOu;
	}
	public void setParentOu(String parentOu) {
		this.parentOu = parentOu;
	}
	@Column(name = "parent_id")
	public Long getParentId() {
		return parentId;
	}
	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}
	
	@Column(name = "update_date")
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
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
	@Column(name = "note")
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	
	@ManyToOne(cascade=CascadeType.ALL,fetch=FetchType.EAGER)
	@JoinColumn(name="fk_account_id")
	public Employee getLeader() {
		return leader;
	}
	public void setLeader(Employee leader) {
		this.leader = leader;
	}
}
