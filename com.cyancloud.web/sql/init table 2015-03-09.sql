insert into t_res_right(id, code, css, is_menu, list, name, parent_id, remark, target, type)
values(33, 'acl/listEmployee', '', 1, 33, '员工管理', 8, '', 'normal', 1);
insert into t_res_right(id, code, css, is_menu, list, name, parent_id, remark, target, type)
values(34, 'acl/listConfig', '', 1, 34, '参数配置', 8, '', 'normal', 1);




INSERT INTO t_res_config(id,cfg_key,cfg_value,cfg_desc,is_edit,note) VALUES (1,'icon-path','D:\\\\employee\\\\icons','员工头像存放路径',1,'');
INSERT INTO t_res_config(id,cfg_key,cfg_value,cfg_desc,is_edit,note) VALUES (2,'account-type','1','超级管理员',1,'顶级管理权限');
INSERT INTO t_res_config(id,cfg_key,cfg_value,cfg_desc,is_edit,note) VALUES (3,'account-type','2','公司管理员',1,'二级用户');
INSERT INTO t_res_config(id,cfg_key,cfg_value,cfg_desc,is_edit,note) VALUES (4,'account-type','3','公司员工',1,'公司员工');



insert into t_res_const (id, name, code, namespace, is_default, input_date, note) 
values(replace(uuid(), '-', ''), '未接收', '0', 'FLAG_TaskState', '0', '2015-03-21', '任务状态-未接收');
insert into t_res_const (id, name, code, namespace, is_default, input_date, note) 
values(replace(uuid(), '-', ''), '正在完成', '5', 'FLAG_TaskState', '1', '2015-03-21', '任务状态-正在完成');
insert into t_res_const (id, name, code, namespace, is_default, input_date, note) 
values(replace(uuid(), '-', ''), '已完成', '9', 'FLAG_TaskState', '1', '2015-03-21', '任务状态-已完成');

insert into t_res_const (id, name, code, namespace, is_default, input_date, note) 
values(replace(uuid(), '-', ''), '公开', '0', 'FLAG_TaskType', '0', '2015-03-21', '任务类型-公开');
insert into t_res_const (id, name, code, namespace, is_default, input_date, note) 
values(replace(uuid(), '-', ''), '私密', '1', 'FLAG_TaskType', '1', '2015-03-21', '任务类型-私密');

insert into t_res_const (id, name, code, namespace, is_default, input_date, note) 
values(replace(uuid(), '-', ''), '部门', '0', 'FLAG_IssuedType', '0', '2015-03-21', '下发类型-部门');
insert into t_res_const (id, name, code, namespace, is_default, input_date, note) 
values(replace(uuid(), '-', ''), '员工', '1', 'FLAG_IssuedType', '1', '2015-03-21', '下发类型-员工');

insert into t_res_const (id, name, code, namespace, is_default, input_date, note) 
values(replace(uuid(), '-', ''), '否', '0', 'FLAG_IsCheck', '0', '2015-03-21', '是否核实');
insert into t_res_const (id, name, code, namespace, is_default, input_date, note) 
values(replace(uuid(), '-', ''), '是', '1', 'FLAG_IsCheck', '1', '2015-03-21', '是否核实');

insert into t_res_const (id, name, code, namespace, is_default, input_date, note) 
values(replace(uuid(), '-', ''), '否', '0', 'FLAG_IsBack', '0', '2015-03-21', '是否退回');
insert into t_res_const (id, name, code, namespace, is_default, input_date, note) 
values(replace(uuid(), '-', ''), '是', '1', 'FLAG_IsBack', '1', '2015-03-21', '是否退回');

insert into t_res_const (id, name, code, namespace, is_default, input_date, note) 
values(replace(uuid(), '-', ''), '否', '0', 'FLAG_IsRemind', '0', '2015-03-21', '是否提醒反馈');
insert into t_res_const (id, name, code, namespace, is_default, input_date, note) 
values(replace(uuid(), '-', ''), '是', '1', 'FLAG_IsRemind', '1', '2015-03-21', '是否提醒反馈');

insert into t_res_const (id, name, code, namespace, is_default, input_date, note) 
values(replace(uuid(), '-', ''), '否', '0', 'FLAG_IsLeader', '0', '2015-03-21', '是否告知领导');
insert into t_res_const (id, name, code, namespace, is_default, input_date, note) 
values(replace(uuid(), '-', ''), '是', '1', 'FLAG_IsLeader', '1', '2015-03-21', '是否告知领导');

insert into t_res_const (id, name, code, namespace, is_default, input_date, note) 
values(replace(uuid(), '-', ''), '部门', '0', 'FLAG_ApplayType', '0', '2015-03-21', '申请类型');
insert into t_res_const (id, name, code, namespace, is_default, input_date, note) 
values(replace(uuid(), '-', ''), '员工', '1', 'FLAG_ApplayType', '1', '2015-03-21', '申请类型');

insert into t_res_const (id, name, code, namespace, is_default, input_date, note) 
values(replace(uuid(), '-', ''), '部门', '0', 'FLAG_ForwardType', '0', '2015-03-21', '转发类型');
insert into t_res_const (id, name, code, namespace, is_default, input_date, note) 
values(replace(uuid(), '-', ''), '员工', '1', 'FLAG_ForwardType', '1', '2015-03-21', '转发类型');

