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
@Table(name = "T_TASK_INFO")
@JsonSerialize(include=JsonSerialize.Inclusion.NON_NULL)
public class TaskInfo extends BaseEntity {// 任务信息表 t_task_info

	private static final long serialVersionUID = 1457950418038507497L;
	
	private Long id; // 任务ID
	private String name; // 任务名称
	private Date createTime; // 创建时间
	private String creater; // 创建人
	private Date updateTime; // 修改日期
	private String backInfo; // 退回信息
	private Date backTime; // 退回时间
	private Date taskEndTime; // 任务完成时间
	private Date realEndTime; // 实际任务完成时间
	private Date remindTime; // 提醒时间
	private Date feedbackTime; // 反馈时间

	private String taskType; // 任务类型
	private Long issuedPeople; // 下发人
	private String issuedType; // 下发类型
	private Long acceptUnit; // 接收部门
	private Long acceptPeople; // 接收人
	private String taskState; // 任务状态
	private String isCheck; // 是否核实
	private String isRemind; // 是否提醒反馈
	private String isBack; // 是否退回
	private Long backPeople; // 退回人

	private EnumConst enumConstTaskType;
	private Employee issuedEmployee;
	private EnumConst enumConstIssuedType;
	private Unit acceptUnitBean; // 接收部门
	private Employee acceptEmployee; // 接收人
	private EnumConst enumConstState; // 任务状态
	private EnumConst enumConstIsCheck; // 是否核实
	private EnumConst enumConstIsBack; // 是否退回
	private Employee backEmployee; // 退回人
	private EnumConst enumConstIsRemind; // 是否退回
	
	public TaskInfo(){
		
	}
	
	public TaskInfo(Long taskId) {
		this.id=taskId;
	}

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

	public String getTaskType() {
		return taskType;
	}

	public void setTaskType(String taskType) {
		this.taskType = taskType;
	}

	@Column(name = "create_time")
	@Temporal(TemporalType.TIMESTAMP)
	@JsonSerialize(using=DateJsonSerializer.class,include=JsonSerialize.Inclusion.NON_NULL)
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@Column(name = "creater")
	public String getCreater() {
		return creater;
	}

	public void setCreater(String creater) {
		this.creater = creater;
	}

	public Long getIssuedPeople() {
		return issuedPeople;
	}

	public void setIssuedPeople(Long issuedPeople) {
		this.issuedPeople = issuedPeople;
	}

	public String getIssuedType() {
		return issuedType;
	}

	public void setIssuedType(String issuedType) {
		this.issuedType = issuedType;
	}

	public Long getAcceptUnit() {
		return acceptUnit;
	}

	public void setAcceptUnit(Long acceptUnit) {
		this.acceptUnit = acceptUnit;
	}

	public Long getAcceptPeople() {
		return acceptPeople;
	}

	public void setAcceptPeople(Long acceptPeople) {
		this.acceptPeople = acceptPeople;
	}

	@Column(name="update_time")
	@Temporal(TemporalType.TIMESTAMP)
	@JsonSerialize(using=DateJsonSerializer.class,include=JsonSerialize.Inclusion.NON_NULL)
	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public String getTaskState() {
		return taskState;
	}

	public void setTaskState(String taskState) {
		this.taskState = taskState;
	}

	public String getIsCheck() {
		return isCheck;
	}

	public void setIsCheck(String isCheck) {
		this.isCheck = isCheck;
	}

	public String getIsBack() {
		return isBack;
	}

	public void setIsBack(String isBack) {
		this.isBack = isBack;
	}

	@Column(name = "back_info")
	public String getBackInfo() {
		return backInfo;
	}

	public void setBackInfo(String backInfo) {
		this.backInfo = backInfo;
	}

	public Long getBackPeople() {
		return backPeople;
	}

	public void setBackPeople(Long backPeople) {
		this.backPeople = backPeople;
	}

	@Column(name = "back_time")
	@Temporal(TemporalType.TIMESTAMP)
	@JsonSerialize(using=DateJsonSerializer.class,include=JsonSerialize.Inclusion.NON_NULL)
	public Date getBackTime() {
		return backTime;
	}

	public void setBackTime(Date backTime) {
		this.backTime = backTime;
	}
	
	@Column(name = "task_end_time")
	@Temporal(TemporalType.TIMESTAMP)
	@JsonSerialize(using=DateJsonSerializer.class,include=JsonSerialize.Inclusion.NON_NULL)
	public Date getTaskEndTime() {
		return taskEndTime;
	}

	public void setTaskEndTime(Date taskEndTime) {
		this.taskEndTime = taskEndTime;
	}

	@Column(name = "real_end_time")
	@Temporal(TemporalType.TIMESTAMP)
	@JsonSerialize(using=DateJsonSerializer.class,include=JsonSerialize.Inclusion.NON_NULL)
	public Date getRealEndTime() {
		return realEndTime;
	}

	public void setRealEndTime(Date realEndTime) {
		this.realEndTime = realEndTime;
	}
	
	public String getIsRemind() {
		return isRemind;
	}

	public void setIsRemind(String isRemind) {
		this.isRemind = isRemind;
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

	@Column(name = "feedback_time")
	@Temporal(TemporalType.TIMESTAMP)
	@JsonSerialize(using=DateJsonSerializer.class,include=JsonSerialize.Inclusion.NON_NULL)
	public Date getFeedbackTime() {
		return feedbackTime;
	}

	public void setFeedbackTime(Date feedbackTime) {
		this.feedbackTime = feedbackTime;
	}
	
	@ManyToOne(cascade=CascadeType.MERGE,fetch=FetchType.EAGER)
	@JoinColumn(name="task_type")
	public EnumConst getEnumConstTaskType() {
		return enumConstTaskType;
	}

	public void setEnumConstTaskType(EnumConst enumConstTaskType) {
		this.enumConstTaskType = enumConstTaskType;
	}

	@ManyToOne(cascade=CascadeType.REFRESH,fetch=FetchType.EAGER)
	@JoinColumn(name="issued_people")
	public Employee getIssuedEmployee() {
		return issuedEmployee;
	}

	public void setIssuedEmployee(Employee issuedEmployee) {
		this.issuedEmployee = issuedEmployee;
	}

	@ManyToOne(cascade=CascadeType.MERGE,fetch=FetchType.EAGER)
	@JoinColumn(name="issued_type")
	public EnumConst getEnumConstIssuedType() {
		return enumConstIssuedType;
	}

	public void setEnumConstIssuedType(EnumConst enumConstIssuedType) {
		this.enumConstIssuedType = enumConstIssuedType;
	}

	@ManyToOne(cascade=CascadeType.REFRESH,fetch=FetchType.EAGER)
	@JoinColumn(name="accept_unit")
	public Unit getAcceptUnitBean() {
		return acceptUnitBean;
	}

	public void setAcceptUnitBean(Unit acceptUnitBean) {
		this.acceptUnitBean = acceptUnitBean;
	}

	@ManyToOne(cascade=CascadeType.REFRESH,fetch=FetchType.EAGER)
	@JoinColumn(name="accept_people")
	public Employee getAcceptEmployee() {
		return acceptEmployee;
	}

	public void setAcceptEmployee(Employee acceptEmployee) {
		this.acceptEmployee = acceptEmployee;
	}

	@ManyToOne(cascade=CascadeType.MERGE,fetch=FetchType.EAGER)
	@JoinColumn(name="state")
	public EnumConst getEnumConstState() {
		return enumConstState;
	}

	public void setEnumConstState(EnumConst enumConstState) {
		this.enumConstState = enumConstState;
	}

	@ManyToOne(cascade=CascadeType.MERGE,fetch=FetchType.EAGER)
	@JoinColumn(name="is_check")
	public EnumConst getEnumConstIsCheck() {
		return enumConstIsCheck;
	}

	public void setEnumConstIsCheck(EnumConst enumConstIsCheck) {
		this.enumConstIsCheck = enumConstIsCheck;
	}

	@ManyToOne(cascade=CascadeType.MERGE,fetch=FetchType.EAGER)
	@JoinColumn(name="is_back")
	public EnumConst getEnumConstIsBack() {
		return enumConstIsBack;
	}

	public void setEnumConstIsBack(EnumConst enumConstIsBack) {
		this.enumConstIsBack = enumConstIsBack;
	}

	@ManyToOne(cascade=CascadeType.REFRESH,fetch=FetchType.EAGER)
	@JoinColumn(name="back_people")
	public Employee getBackEmployee() {
		return backEmployee;
	}

	public void setBackEmployee(Employee backEmployee) {
		this.backEmployee = backEmployee;
	}

	@ManyToOne(cascade=CascadeType.MERGE,fetch=FetchType.EAGER)
	@JoinColumn(name="is_remind")
	public EnumConst getEnumConstIsRemind() {
		return enumConstIsRemind;
	}
	
	public void setEnumConstIsRemind(EnumConst enumConstIsRemind) {
		this.enumConstIsRemind = enumConstIsRemind;
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
