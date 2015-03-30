package com.cyancloud.model.task;

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

import org.codehaus.jackson.map.annotate.JsonSerialize;
import org.hibernate.annotations.GenericGenerator;

import com.cyancloud.commons.entity.BaseEntity;
import com.cyancloud.web.util.DateJsonSerializer;

@Entity
@Table(name = "T_TASK_CONSULT")
@JsonSerialize(include=JsonSerialize.Inclusion.NON_NULL)
public class TaskConsult extends BaseEntity { // 任务咨询表 t_task_consult
	
	private static final long serialVersionUID = -5262871094586333108L;
	
	private Long id; // ID
	private TaskInfo taskInfo;
	private Long taskId; // 任务ID
	private Long consultPeople; // 咨询人
	private String consultContent; // 咨询内容
	private Date consultTime; // 咨询时间
	private Long replyPeople; // 回复人
	private String replyContent; // 回复内容
	private Date replyTime; // 回复时间
	
	
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

	@ManyToOne(cascade=CascadeType.REFRESH,fetch=FetchType.EAGER)
	@JoinColumn(name="task_id")
	public TaskInfo getTaskInfo() {
		return taskInfo;
	}

	public void setTaskInfo(TaskInfo taskInfo) {
		this.taskInfo = taskInfo;
	}

	public Long getTaskId() {
		return taskId;
	}

	public void setTaskId(Long taskId) {
		this.taskId = taskId;
	}

	@Column(name = "consult_people")
	public Long getConsultPeople() {
		return consultPeople;
	}

	public void setConsultPeople(Long consultPeople) {
		this.consultPeople = consultPeople;
	}

	@Column(name = "consult_content")
	public String getConsultContent() {
		return consultContent;
	}

	public void setConsultContent(String consultContent) {
		this.consultContent = consultContent;
	}

	@Column(name = "consult_time")
	@JsonSerialize(using=DateJsonSerializer.class,include=JsonSerialize.Inclusion.NON_NULL)
	public Date getConsultTime() {
		return consultTime;
	}

	public void setConsultTime(Date consultTime) {
		this.consultTime = consultTime;
	}

	@Column(name = "reply_people")
	public Long getReplyPeople() {
		return replyPeople;
	}

	public void setReplyPeople(Long replyPeople) {
		this.replyPeople = replyPeople;
	}

	@Column(name = "reply_content")
	public String getReplyContent() {
		return replyContent;
	}

	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	@Column(name = "reply_time")
	@JsonSerialize(using=DateJsonSerializer.class,include=JsonSerialize.Inclusion.NON_NULL)
	public Date getReplyTime() {
		return replyTime;
	}

	public void setReplyTime(Date replyTime) {
		this.replyTime = replyTime;
	}
	
	@Override
	public Object objId() {
		return id;
	}

	@Override
	public String toString() {
		return getClass() + "@" + id;
	}
	
}
