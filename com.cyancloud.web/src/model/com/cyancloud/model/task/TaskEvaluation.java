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

import org.codehaus.jackson.map.annotate.JsonSerialize;
import org.hibernate.annotations.GenericGenerator;

import com.cyancloud.commons.entity.BaseEntity;
import com.cyancloud.model.system.Employee;
import com.cyancloud.web.util.DateJsonSerializer;

@Entity
@Table(name = "T_TASK_EVALUATION")
@JsonSerialize(include=JsonSerialize.Inclusion.NON_NULL)
public class TaskEvaluation extends BaseEntity { // 任务评价表 t_task_evaluation

	private static final long serialVersionUID = -3197911581998143966L;

	private Long id; // ID
	private TaskInfo taskInfo;
	private Long taskId; // 任务ID
	private Employee evaluaEmployee;
	private Long evaluaPeople; // 评价人 
	private Date evaluaTime; // 评价时间 
	private Long evaluaScore; //评价分数 
	private String evaluaInfo; // 评价信息
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
	
	@ManyToOne(cascade=CascadeType.REFRESH,fetch=FetchType.EAGER)
	@JoinColumn(name="task_id")
	public TaskInfo getTaskInfo() {
		return taskInfo;
	}

	public void setTaskInfo(TaskInfo taskInfo) {
		this.taskInfo = taskInfo;
	}

	@ManyToOne(cascade=CascadeType.REFRESH,fetch=FetchType.EAGER)
	@JoinColumn(name="evalua_people")
	public Employee getEvaluaEmployee() {
		return evaluaEmployee;
	}

	public void setEvaluaEmployee(Employee evaluaEmployee) {
		this.evaluaEmployee = evaluaEmployee;
	}

	public Long getTaskId() {
		return taskId;
	}

	public void setTaskId(Long taskId) {
		this.taskId = taskId;
	}

	public Long getEvaluaPeople() {
		return evaluaPeople;
	}

	public void setEvaluaPeople(Long evaluaPeople) {
		this.evaluaPeople = evaluaPeople;
	}

	@Column(name = "evalua_time")
	@Temporal(TemporalType.TIMESTAMP)
	@JsonSerialize(using=DateJsonSerializer.class,include=JsonSerialize.Inclusion.NON_NULL)
	public Date getEvaluaTime() {
		return evaluaTime;
	}

	public void setEvaluaTime(Date evaluaTime) {
		this.evaluaTime = evaluaTime;
	}

	@Column(name = "evalua_score")
	public Long getEvaluaScore() {
		return evaluaScore;
	}

	public void setEvaluaScore(Long evaluaScore) {
		this.evaluaScore = evaluaScore;
	}

	@Column(name = "evalua_info")
	public String getEvaluaInfo() {
		return evaluaInfo;
	}

	public void setEvaluaInfo(String evaluaInfo) {
		this.evaluaInfo = evaluaInfo;
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
		return id;
	}
	
	@Override
	public String toString() {
		return getClass() + "@" + id;
	}
	
}
