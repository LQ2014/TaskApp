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

import com.cyancloud.commons.entity.ProtoStringModel;
@Entity
@Table(name = "T_RES_CONST")
public class EnumConst extends ProtoStringModel{	
	private static final long serialVersionUID = 1L;
	@Id
	@GenericGenerator(name="idGenerator", strategy="uuid")  //hibernate的注解
	@GeneratedValue(generator="idGenerator") 				//使用uuid的生成策略
	protected String id;
	
	@Column(name="name")
	private String name;
	
	@Column(name="code")
	private String code;
	
	@Column(name="namespace")
	private String namespace;
	
	@Column(name="is_default")
	private String isDefault;
	
	@Column(name="input_date")
	@Temporal(TemporalType.DATE)
	private Date inputDate;
	
	@Column(name="note")
	private String note;

	public EnumConst() {
		
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}	

	public String getIsDefault() {
		return isDefault;
	}

	public void setIsDefault(String isDefault) {
		this.isDefault = isDefault;
	}

	public String getNamespace() {
		return namespace;
	}

	public void setNamespace(String namespace) {
		this.namespace = namespace;
	}

	public Date getInputDate() {
		return inputDate;
	}

	public void setInputDate(Date inputDate) {
		this.inputDate = inputDate;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}	

}
