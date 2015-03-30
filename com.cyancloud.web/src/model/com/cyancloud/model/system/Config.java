package com.cyancloud.model.system;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import com.cyancloud.commons.entity.BaseEntity;

@Entity
@Table(name = "T_RES_CONFIG")
public class Config extends BaseEntity {

	private static final long serialVersionUID = 4015603857545544179L;
	
	private Long id;
	
	private String key; // 配置键
	
	private String value; // 配置值
	
	private String desc; // 描述
	
	private Long isEdit = 1L; // 是否可编辑，默认可编辑
	
	private String note; // 备注
	
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

	@Column(name = "cfg_desc")
	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	@Column(name = "cfg_key")
	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	@Column(name = "cfg_value")
	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	@Column(name = "is_edit")
	public Long getIsEdit() {
		return isEdit;
	}

	public void setIsEdit(Long isEdit) {
		this.isEdit = isEdit;
	}

	@Column(name = "note")
	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	@Override
	public Object objId() {
		return null;
	}

	@Override
	public String toString() {
		return null;
	}

}
