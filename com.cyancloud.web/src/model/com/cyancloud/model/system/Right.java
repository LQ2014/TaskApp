package com.cyancloud.model.system;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import com.cyancloud.commons.entity.BaseEntity;
@Entity
@Table(name = "T_RES_RIGHT")
public class Right extends BaseEntity{

	/**
	 * 
	 */
	private static final long serialVersionUID = -3952407442721422866L;
	private Long id;
	private String name;
	private String code;//url
	private Long parentId;//父权限id
	private Long type;//类型
	private Long list;//显示顺序
	private Boolean isMenu;//是否为功能菜单
	private String remark;//标注
	private String css;
	
	@Id
	@Column(name = "id")
	@GeneratedValue(generator = "idGenerator")
	@GenericGenerator(name = "idGenerator", strategy = "assigned")
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

	@Column(name = "code")
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	@Column(name = "parent_id")
	public Long getParentId() {
		return parentId;
	}

	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}
	@Column(name = "type")
	public Long getType() {
		return type;
	}

	public void setType(Long type) {
		this.type = type;
	}
	@Column(name = "remark")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	@Column(name = "list")
	public Long getList() {
		return list;
	}

	public void setList(Long list) {
		this.list = list;
	}

	@Column(name = "is_menu")
	public Boolean getIsMenu() {
		return isMenu;
	}

	public void setIsMenu(Boolean isMenu) {
		this.isMenu = isMenu;
	}
	
	@Column(name = "css")
	public String getCss() {
		return css;
	}

	public void setCss(String css) {
		this.css = css;
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
}
