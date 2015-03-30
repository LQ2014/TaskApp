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
import com.cyancloud.model.system.EnumConst;
import com.cyancloud.model.system.Unit;
import com.cyancloud.web.util.DateJsonSerializer;

@Entity
@Table(name = "T_TASK_APPLAY")
@JsonSerialize(include=JsonSerialize.Inclusion.NON_NULL)
public class TaskApplay extends BaseEntity { // 任务申请表 t_task_applay

	private static final long serialVersionUID = -8590241349546164009L;

	private Long id; // ID
	private TaskInfo taskInfo;
	private Long taskId; // 任务ID
	private Employee applayEmployee;
	private Long applayPeople; // 申请人
	private EnumConst enumConstApplayType;
	private String applayType; // 申请类型
	private Unit toUnitBean;
	private Long toUnit; // 申请到部门
	private Employee toEmployee;
	private Long toPeople; // 申请到人
	private EnumConst enumConstIsLeader;
	private String isLeader; // 是否告知领导
	private Date applayTime; // 申请时间
	
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

	public Long getApplayPeople() {
		return applayPeople;
	}

	public void setApplayPeople(Long applayPeople) {
		this.applayPeople = applayPeople;
	}

	public String getApplayType() {
		return applayType;
	}

	public void setApplayType(String applayType) {
		this.applayType = applayType;
	}

	public Long getToUnit() {
		return toUnit;
	}

	public void setToUnit(Long toUnit) {
		this.toUnit = toUnit;
	}

	public Long getToPeople() {
		return toPeople;
	}

	public void setToPeople(Long toPeople) {
		this.toPeople = toPeople;
	}

	public String getIsLeader() {
		return isLeader;
	}

	public void setIsLeader(String isLeader) {
		this.isLeader = isLeader;
	}

	@Column(name = "applay_time")
	@Temporal(TemporalType.TIMESTAMP)
	@JsonSerialize(using=DateJsonSerializer.class,include=JsonSerialize.Inclusion.NON_NULL)
	public Date getApplayTime() {
		return applayTime;
	}

	public void setApplayTime(Date applayTime) {
		this.applayTime = applayTime;
	}

	@ManyToOne(cascade=CascadeType.REFRESH,fetch=FetchType.EAGER)
	@JoinColumn(name="applay_people")
	public Employee getApplayEmployee() {
		return applayEmployee;
	}

	public void setApplayEmployee(Employee applayEmployee) {
		this.applayEmployee = applayEmployee;
	}

	@ManyToOne(cascade=CascadeType.REFRESH,fetch=FetchType.EAGER)
	@JoinColumn(name="applay_type")
	public EnumConst getEnumConstApplayType() {
		return enumConstApplayType;
	}

	public void setEnumConstApplayType(EnumConst enumConstApplayType) {
		this.enumConstApplayType = enumConstApplayType;
	}

	@ManyToOne(cascade=CascadeType.REFRESH,fetch=FetchType.EAGER)
	@JoinColumn(name="to_unit")
	public Unit getToUnitBean() {
		return toUnitBean;
	}

	public void setToUnitBean(Unit toUnitBean) {
		this.toUnitBean = toUnitBean;
	}

	@ManyToOne(cascade=CascadeType.REFRESH,fetch=FetchType.EAGER)
	@JoinColumn(name="to_people")
	public Employee getToEmployee() {
		return toEmployee;
	}

	public void setToEmployee(Employee toEmployee) {
		this.toEmployee = toEmployee;
	}

	@ManyToOne(cascade=CascadeType.REFRESH,fetch=FetchType.EAGER)
	@JoinColumn(name="is_leader")
	public EnumConst getEnumConstIsLeader() {
		return enumConstIsLeader;
	}

	public void setEnumConstIsLeader(EnumConst enumConstIsLeader) {
		this.enumConstIsLeader = enumConstIsLeader;
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
