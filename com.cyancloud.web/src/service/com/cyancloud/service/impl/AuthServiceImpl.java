package com.cyancloud.service.impl;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.cyancloud.dao.RightDao;
import com.cyancloud.dao.Role2RightDao;
import com.cyancloud.model.system.Right;
import com.cyancloud.model.system.Role2Right;
import com.cyancloud.service.AuthService;
import com.cyancloud.service.model.RightBean;

@Service("authService")
public class AuthServiceImpl implements AuthService {

	@Autowired
	private RightDao rightDao;

	@Autowired
	private Role2RightDao r2rDao;	
	
	@Override
	public void addRight(Right right) {
		if (right != null) {
			if (right.getId() == null) {
				Long id = this.rightDao.getNextId();
				right.setId(id);
			}
		}

		rightDao.addRight(right);
	}

	@Override
	public void editRight(Right right) {
		// TODO Auto-generated method stub
		rightDao.editRight(right);
	}

	@Override
	public void deleteRight(Long id) {
		Right r = rightDao.findById(id);
		List<Right> rightList = this.getRightChilds(r.getId());
		rightList.add(r);

		// 删除自己和子权限
		this.rightDao.deleteAll(rightList);
		// rightDao.deleteRight(id);
	}

	@Override
	public List<RightBean> listAuth(Long parentId) {
		List<RightBean> result = new ArrayList<RightBean>();
		HashMap<Long, String> map = new HashMap<Long, String>();
		HashMap<Long, String> map2 = new HashMap<Long, String>();
		List<Right> allList = this.rightDao.getAll();
		List<Right> list = this.rightDao.listAuth(parentId);
		for (Right r : allList) {
			map.put(r.getId(), r.getName());

		}
		for (Right r : list) {
			String isLeaf = "true";
			List<Right> childs = this.rightDao.listAuth(r.getId());
			if (childs != null && childs.size() > 0) {
				isLeaf = "false";
			}
			map2.put(r.getId(), isLeaf);
		}
		for (Right r : list) {
			RightBean rb = new RightBean();
			try {
				BeanUtils.copyProperties(rb, r);
				if (rb.getParentId() != null) {
					rb.setParentName(map.get(rb.getParentId()));
				}
				rb.setIsLeaf(map2.get(rb.getId()));
				result.add(rb);
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
		}
		return result;
	}

	@Override
	public Right getRightById(Long id) {
		return rightDao.findById(id);
	}

	@Override
	public List<RightBean> listAuthTree() {
		List<RightBean> result = new ArrayList<RightBean>();
		List<Right> rights = this.rightDao.getAllInOrder("name");
		for (Right r : rights) {
			if (r.getParentId() == null) {
				RightBean bean = new RightBean();
				try {
					BeanUtils.copyProperties(bean, r);
					this.cascadeAuthTree(bean, rights);
					result.add(bean);
				} catch (IllegalAccessException e) {
					// TODO Auto-generated catch block
					// e.printStackTrace();
				} catch (InvocationTargetException e) {
					// TODO Auto-generated catch block
					// e.printStackTrace();
				}

			}
		}

		return result;
	}

	private List<Right> getRightChilds(Long id) {
		List<Right> result = new ArrayList<Right>();
		List<Right> rights = this.rightDao.getAll();
		for (Right r : rights) {
			if (r.getParentId() != null) {
				Long pId = r.getParentId();
				try {
					if (pId.longValue() == id) {
						result.add(r);
						this.cascadeChildAuth(result, r, rights);
					}
				} catch (IllegalAccessException e) {
					// TODO Auto-generated catch block
					// e.printStackTrace();
				} catch (InvocationTargetException e) {
					// TODO Auto-generated catch block
					// e.printStackTrace();
				}
			}
		}

		return result;
	}

	private void cascadeChildAuth(List<Right> result, Right right,
			List<Right> rights) throws IllegalAccessException,
			InvocationTargetException {
		for (Right r : rights) {
			if (r.getParentId() != null) {
				Long pId = r.getParentId();
				try {
					if (pId.longValue() == right.getId().longValue()) {
						result.add(r);
						this.cascadeChildAuth(result, r, rights);
					}
				} catch (IllegalAccessException e) {
					// TODO Auto-generated catch block
					// e.printStackTrace();
				} catch (InvocationTargetException e) {
					// TODO Auto-generated catch block
					// e.printStackTrace();
				}
			}
		}
	}

	private void cascadeAuthTree(RightBean bean, List<Right> rights)
			throws IllegalAccessException, InvocationTargetException {
		List<RightBean> childs = new ArrayList<RightBean>();
		for (Right r : rights) {
			if (r.getParentId() != null
					&& r.getParentId().intValue() == bean.getId().intValue()) {
				RightBean cb = new RightBean();
				BeanUtils.copyProperties(cb, r);
				if (cb.getParentId() != null && cb.getParentId() != 0) {
					Right pr = this.rightDao.findById(cb.getParentId());
					cb.setParentName(pr.getName());
				}
				childs.add(cb);
				this.cascadeAuthTree(cb, rights);
			}
		}
		bean.setChilds(childs);
	}

	public List<Role2Right> getR2RByRigthId(Long rightId) {
		return this.r2rDao.getR2RByRigthId(rightId);
	}

	@Override
	public void importAuth(MultipartFile myfile) {
	
		
	}	

}
