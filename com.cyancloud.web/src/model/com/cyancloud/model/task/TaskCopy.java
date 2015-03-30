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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.codehaus.jackson.map.annotate.JsonSerialize;
import org.hibernate.annotations.GenericGenerator;

import com.cyancloud.commons.entity.BaseEntity;
import com.cyancloud.model.system.Employee;
import com.cyancloud.model.system.EnumConst;
import com.cyancloud.web.util.DateJsonSerializer;

@Entity
@Table(name = "T_TASK_COPY")
@JsonSerialize(include=JsonSerialize.Inclusion.NON_NULL)
public class TaskCopy extends BaseEntity {// 任务抄送表 t_task_copy

	private static final long serialVersionUID = 1082713637886790858L;

	private Long id; // ID
	private TaskInfo taskInfo; // 任务ID
	private EnumConst enumConstFlagIsRemind;
	private Date remindTime; // 提醒时间
	private String remindInfo; // 提醒内容
	private Date feedbackTime; // 反馈时间
	private String feedbackInfo; // 反馈内容
    private Employee remindEmployee; // 提醒人 
    private Date copyTime; // 抄送时间
    private String note; // 备注
    private Employee copyEmployee; // 抄送人
    
    private Long taskId;
    private String IsRemind;
    private Long remindPeople;
    private Long copyPeople;
    
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

	@Transient
	public Long getCopyPeople() {
		return copyPeople;
	}

	public void setCopyPeople(Long copyPeople) {
		this.copyPeople = copyPeople;
	}

	@ManyToOne(cascade=CascadeType.REFRESH,fetch=FetchType.EAGER)
	@JoinColumn(name="is_remind")
	public EnumConst getEnumConstFlagIsRemind() {
		return enumConstFlagIsRemind;
	}

	public void setEnumConstFlagIsRemind(EnumConst enumConstFlagIsRemind) {
		this.enumConstFlagIsRemind = enumConstFlagIsRemind;
	}

	@ManyToOne(cascade=CascadeType.REFRESH,fetch=FetchType.EAGER)
	@JoinColumn(name="remind_people")
	public Employee getRemindEmployee() {
		return remindEmployee;
	}

	public void setRemindEmployee(Employee remindEmployee) {
		this.remindEmployee = remindEmployee;
	}

	@Column(name = "copy_time")
	@Temporal(TemporalType.TIMESTAMP)
	@JsonSerialize(using=DateJsonSerializer.class,include=JsonSerialize.Inclusion.NON_NULL)
	public Date getCopyTime() {
		return copyTime;
	}

	public void setCopyTime(Date copyTime) {
		this.copyTime = copyTime;
	}

	@Column(name = "note")
	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}
	
	@Column(name = "remind_time")
	@Temporal(TemporalType.TIMESTAMP)
	@JsonSerialize(using=DateJsonSerializer.class,include=JsonSerialize.Inclusion.NON_NULL)
	public Date getRemindTime() {
		return remindTime;
	}

	public void setRemindTime(Date remindTime) {
		this.remindTime = remindTime;
	}

	@Column(name = "remind_info")
	public String getRemindInfo() {
		return remindInfo;
	}

	public void setRemindInfo(String remindInfo) {
		this.remindInfo = remindInfo;
	}

	@Column(name = "feedback_time")
	@Temporal(TemporalType.TIMESTAMP)
	@JsonSerialize(using=DateJsonSerializer.class,include=JsonSerialize.Inclusion.NON_NULL)
	public Date getFeedbackTime() {
		return feedbackTime;
	}

	public void setFeedbackTime(Date feedbackTime) {
		this.feedbackTime = feedbackTime;
	}

	@Column(name = "feedback_info")
	public String getFeedbackInfo() {
		return feedbackInfo;
	}

	public void setFeedbackInfo(String feedbackInfo) {
		this.feedbackInfo = feedbackInfo;
	}

	@Override
	public Object objId() {
		return id;
	}
	
	@Override
	public String toString() {
		return getClass() + "@" + id;
	}

	@Transient
	public Long getTaskId() {
		return taskId;
	}

	public void setTaskId(Long taskId) {
		this.taskId = taskId;
	}

	@Transient
	public String getIsRemind() {
		return IsRemind;
	}

	public void setIsRemind(String isRemind) {
		IsRemind = isRemind;
	}

	@Transient
	public Long getRemindPeople() {
		return remindPeople;
	}

	public void setRemindPeople(Long remindPeople) {
		this.remindPeople = remindPeople;
	}

	@ManyToOne(cascade=CascadeType.REFRESH,fetch=FetchType.EAGER)
	@JoinColumn(name="copy_people")
	public Employee getCopyEmployee() {
		return copyEmployee;
	}

	public void setCopyEmployee(Employee copyEmployee) {
		this.copyEmployee = copyEmployee;
	}

	
}
