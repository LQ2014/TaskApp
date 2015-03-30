package com.cyancloud.model.notice;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.GenericGenerator;

import com.cyancloud.commons.entity.ProtoStringModel;
import com.cyancloud.model.system.Account;
import com.cyancloud.model.system.EnumConst;
@Entity
@Table(name = "t_res_notice")
public class Notice extends ProtoStringModel{
	private static final long serialVersionUID = 1L;
	@Id
	@GenericGenerator(name="idGenerator", strategy="uuid")  //hibernate的注解
	@GeneratedValue(generator="idGenerator") 				//使用uuid的生成策略
	protected String id;

	@Column(name="title")
	private String title;
	
	@Column(name="content")
	private String content;
	
	@Column(name="create_date")
	@Temporal(TemporalType.TIMESTAMP)
	private Date createDate;
	
	@Column(name="input_date")
	@Temporal(TemporalType.DATE)
	private Date inputDate;
	
	@ManyToOne(cascade=CascadeType.PERSIST,fetch=FetchType.EAGER)
	@JoinColumn(name="FK_ACCOUNT_PUBLISHER")
	private Account publisher;
	
	@ManyToOne(cascade=CascadeType.MERGE,fetch=FetchType.EAGER)
	@JoinColumn(name="FLAG_ISPUBLISHED")
	private EnumConst enumConstByflagIsPublished;	

	public Notice() {		
		
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getInputDate() {
		return inputDate;
	}

	public void setInputDate(Date inputDate) {
		this.inputDate = inputDate;
	}	

	public Account getPublisher() {
		return publisher;
	}

	public EnumConst getEnumConstByflagIsPublished() {
		return enumConstByflagIsPublished;
	}

	public void setEnumConstByflagIsPublished(EnumConst enumConstByflagIsPublished) {
		this.enumConstByflagIsPublished = enumConstByflagIsPublished;
	}

	public void setPublisher(Account publisher) {
		this.publisher = publisher;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	
}
