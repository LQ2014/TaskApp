drop table if exists t_res_contacts;
create table t_res_contacts (
	acc_id bigint primary key,
	mobile char(20),
	phone char(20),
	qq char(20),
	email char(100),
	weixin char(20),
	address text
);


drop table if exists t_res_employee;
create table t_res_employee (
	id bigint primary key,
	code varchar(255) not null,
	name varchar(255),
	unit_id bigint,
	ctime datatime,
	update_date datatime,
	
	icon varchar(255),
	nickname varchar(255),
	phone varchar(255),
	address varchar(255),
	weixin varchar(255),
	qq varchar(255),
	email varchar(255),
	resume varchar(255),
	
	score varchar(255),
	is_show_score varchar(255),
	state bigint
);

drop table if exists t_res_config;
create table t_res_config (
	id bigint primary key,
	cfg_key varchar(255),
	cfg_value varchar(255),
	cfg_desc varchar(255),
	is_edit bigint,
	note varchar(255)
);

