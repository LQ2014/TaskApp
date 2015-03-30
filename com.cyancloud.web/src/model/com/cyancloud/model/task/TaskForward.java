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
import com.cyancloud.web.util.DateJsonSerializer;

@Entity
@Table(name = "T_TASK_FORWARD")
@JsonSerialize(include=JsonSerialize.Inclusion.NON_NULL)
public class TaskForward extends BaseEntity {// 任务转发信息表 t_task_forward

	private static final long serialVersionUID = -546268419268623419L;
	
	private Long id; // ID
	private TaskInfo taskInfo;
	private String forwardPeople; // 转发人
	private String forwardType; // 转发类型
	private Long toUnit; // 转发至部门
	private Long toPeople; // 转发至员工
	private Date forwardTime; // 转发时间
	private Long taskId;
	
	
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

	@Column(name = "forward_people")
	public String getForwardPeople() {
		return forwardPeople;
	}

	public void setForwardPeople(String forwardPeople) {
		this.forwardPeople = forwardPeople;
	}

	@Column(name = "forward_type")
	public String getForwardType() {
		return forwardType;
	}

	public void setForwardType(String forwardType) {
		this.forwardType = forwardType;
	}

	@Column(name = "to_unit")
	public Long getToUnit() {
		return toUnit;
	}

	public void setToUnit(Long toUnit) {
		this.toUnit = toUnit;
	}

	@Column(name = "to_people")
	public Long getToPeople() {
		return toPeople;
	}

	public void setToPeople(Long toPeople) {
		this.toPeople = toPeople;
	}

	@Column(name = "forward_time")
	@Temporal(TemporalType.TIMESTAMP)
	@JsonSerialize(using=DateJsonSerializer.class,include=JsonSerialize.Inclusion.NON_NULL)
	public Date getForwardTime() {
		return forwardTime;
	}

	public void setForwardTime(Date forwardTime) {
		this.forwardTime = forwardTime;
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
	
}
