CREATE TABLE gen_table
(
    table_id          bigint AUTO_INCREMENT COMMENT '编号'
        PRIMARY KEY,
    table_name        varchar(200) DEFAULT ''     NULL COMMENT '表名称',
    table_comment     varchar(500) DEFAULT ''     NULL COMMENT '表描述',
    sub_table_name    varchar(64)                 NULL COMMENT '关联子表的表名',
    sub_table_fk_name varchar(64)                 NULL COMMENT '子表关联的外键名',
    class_name        varchar(100) DEFAULT ''     NULL COMMENT '实体类名称',
    tpl_category      varchar(200) DEFAULT 'crud' NULL COMMENT '使用的模板（crud单表操作 tree树表操作 sub主子表操作）',
    package_name      varchar(100)                NULL COMMENT '生成包路径',
    module_name       varchar(30)                 NULL COMMENT '生成模块名',
    business_name     varchar(30)                 NULL COMMENT '生成业务名',
    function_name     varchar(50)                 NULL COMMENT '生成功能名',
    function_author   varchar(50)                 NULL COMMENT '生成功能作者',
    gen_type          char         DEFAULT '0'    NULL COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
    gen_path          varchar(200) DEFAULT '/'    NULL COMMENT '生成路径（不填默认项目路径）',
    options           varchar(1000)               NULL COMMENT '其它生成选项',
    create_by         varchar(64)  DEFAULT ''     NULL COMMENT '创建者',
    create_time       datetime                    NULL COMMENT '创建时间',
    update_by         varchar(64)  DEFAULT ''     NULL COMMENT '更新者',
    update_time       datetime                    NULL COMMENT '更新时间',
    remark            varchar(500)                NULL COMMENT '备注'
)
COMMENT '代码生成业务表';

CREATE TABLE gen_table_column
(
    column_id      bigint AUTO_INCREMENT COMMENT '编号'
        PRIMARY KEY,
    table_id       varchar(64)               NULL COMMENT '归属表编号',
    column_name    varchar(200)              NULL COMMENT '列名称',
    column_comment varchar(500)              NULL COMMENT '列描述',
    column_type    varchar(100)              NULL COMMENT '列类型',
    java_type      varchar(500)              NULL COMMENT 'JAVA类型',
    java_field     varchar(200)              NULL COMMENT 'JAVA字段名',
    is_pk          char                      NULL COMMENT '是否主键（1是）',
    is_increment   char                      NULL COMMENT '是否自增（1是）',
    is_required    char                      NULL COMMENT '是否必填（1是）',
    is_insert      char                      NULL COMMENT '是否为插入字段（1是）',
    is_edit        char                      NULL COMMENT '是否编辑字段（1是）',
    is_list        char                      NULL COMMENT '是否列表字段（1是）',
    is_query       char                      NULL COMMENT '是否查询字段（1是）',
    query_type     varchar(200) DEFAULT 'EQ' NULL COMMENT '查询方式（等于、不等于、大于、小于、范围）',
    html_type      varchar(200)              NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
    dict_type      varchar(200) DEFAULT ''   NULL COMMENT '字典类型',
    sort           int                       NULL COMMENT '排序',
    create_by      varchar(64)  DEFAULT ''   NULL COMMENT '创建者',
    create_time    datetime                  NULL COMMENT '创建时间',
    update_by      varchar(64)  DEFAULT ''   NULL COMMENT '更新者',
    update_time    datetime                  NULL COMMENT '更新时间'
)
COMMENT '代码生成业务表字段';

CREATE TABLE qrtz_calendars
(
    sched_name    varchar(120) NOT NULL COMMENT '调度名称',
    calendar_name varchar(200) NOT NULL COMMENT '日历名称',
    calendar      blob         NOT NULL COMMENT '存放持久化calendar对象',
    PRIMARY KEY (sched_name, calendar_name)
)
COMMENT '日历信息表';

CREATE TABLE qrtz_fired_triggers
(
    sched_name        varchar(120) NOT NULL COMMENT '调度名称',
    entry_id          varchar(95)  NOT NULL COMMENT '调度器实例id',
    trigger_name      varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
    trigger_group     varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
    instance_name     varchar(200) NOT NULL COMMENT '调度器实例名',
    fired_time        bigint(13)   NOT NULL COMMENT '触发的时间',
    sched_time        bigint(13)   NOT NULL COMMENT '定时器制定的时间',
    priority          int          NOT NULL COMMENT '优先级',
    state             varchar(16)  NOT NULL COMMENT '状态',
    job_name          varchar(200) NULL COMMENT '任务名称',
    job_group         varchar(200) NULL COMMENT '任务组名',
    is_nonconcurrent  varchar(1)   NULL COMMENT '是否并发',
    requests_recovery varchar(1)   NULL COMMENT '是否接受恢复执行',
    PRIMARY KEY (sched_name, entry_id)
)
COMMENT '已触发的触发器表';

CREATE TABLE qrtz_job_details
(
    sched_name        varchar(120) NOT NULL COMMENT '调度名称',
    job_name          varchar(200) NOT NULL COMMENT '任务名称',
    job_group         varchar(200) NOT NULL COMMENT '任务组名',
    description       varchar(250) NULL COMMENT '相关介绍',
    job_class_name    varchar(250) NOT NULL COMMENT '执行任务类名称',
    is_durable        varchar(1)   NOT NULL COMMENT '是否持久化',
    is_nonconcurrent  varchar(1)   NOT NULL COMMENT '是否并发',
    is_update_data    varchar(1)   NOT NULL COMMENT '是否更新数据',
    requests_recovery varchar(1)   NOT NULL COMMENT '是否接受恢复执行',
    job_data          blob         NULL COMMENT '存放持久化job对象',
    PRIMARY KEY (sched_name, job_name, job_group)
)
COMMENT '任务详细信息表';

CREATE TABLE qrtz_locks
(
    sched_name varchar(120) NOT NULL COMMENT '调度名称',
    lock_name  varchar(40)  NOT NULL COMMENT '悲观锁名称',
    PRIMARY KEY (sched_name, lock_name)
)
COMMENT '存储的悲观锁信息表';

CREATE TABLE qrtz_paused_trigger_grps
(
    sched_name    varchar(120) NOT NULL COMMENT '调度名称',
    trigger_group varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
    PRIMARY KEY (sched_name, trigger_group)
)
COMMENT '暂停的触发器表';

CREATE TABLE qrtz_scheduler_state
(
    sched_name        varchar(120) NOT NULL COMMENT '调度名称',
    instance_name     varchar(200) NOT NULL COMMENT '实例名称',
    last_checkin_time bigint(13)   NOT NULL COMMENT '上次检查时间',
    checkin_interval  bigint(13)   NOT NULL COMMENT '检查间隔时间',
    PRIMARY KEY (sched_name, instance_name)
)
COMMENT '调度器状态表';

CREATE TABLE qrtz_triggers
(
    sched_name     varchar(120) NOT NULL COMMENT '调度名称',
    trigger_name   varchar(200) NOT NULL COMMENT '触发器的名字',
    trigger_group  varchar(200) NOT NULL COMMENT '触发器所属组的名字',
    job_name       varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
    job_group      varchar(200) NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
    description    varchar(250) NULL COMMENT '相关介绍',
    next_fire_time bigint(13)   NULL COMMENT '上一次触发时间（毫秒）',
    prev_fire_time bigint(13)   NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
    priority       int          NULL COMMENT '优先级',
    trigger_state  varchar(16)  NOT NULL COMMENT '触发器状态',
    trigger_type   varchar(8)   NOT NULL COMMENT '触发器的类型',
    start_time     bigint(13)   NOT NULL COMMENT '开始时间',
    end_time       bigint(13)   NULL COMMENT '结束时间',
    calendar_name  varchar(200) NULL COMMENT '日程表名称',
    misfire_instr  smallint(2)  NULL COMMENT '补偿执行的策略',
    job_data       blob         NULL COMMENT '存放持久化job对象',
    PRIMARY KEY (sched_name, trigger_name, trigger_group),
    CONSTRAINT qrtz_triggers_ibfk_1
        FOREIGN KEY (sched_name, job_name, job_group) REFERENCES qrtz_job_details (sched_name, job_name, job_group)
)
COMMENT '触发器详细信息表';

CREATE TABLE qrtz_blob_triggers
(
    sched_name    varchar(120) NOT NULL COMMENT '调度名称',
    trigger_name  varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
    trigger_group varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
    blob_data     blob         NULL COMMENT '存放持久化Trigger对象',
    PRIMARY KEY (sched_name, trigger_name, trigger_group),
    CONSTRAINT qrtz_blob_triggers_ibfk_1
        FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES qrtz_triggers (sched_name, trigger_name, trigger_group)
)
COMMENT 'Blob类型的触发器表';

CREATE TABLE qrtz_cron_triggers
(
    sched_name      varchar(120) NOT NULL COMMENT '调度名称',
    trigger_name    varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
    trigger_group   varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
    cron_expression varchar(200) NOT NULL COMMENT 'cron表达式',
    time_zone_id    varchar(80)  NULL COMMENT '时区',
    PRIMARY KEY (sched_name, trigger_name, trigger_group),
    CONSTRAINT qrtz_cron_triggers_ibfk_1
        FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES qrtz_triggers (sched_name, trigger_name, trigger_group)
)
COMMENT 'Cron类型的触发器表';

CREATE TABLE qrtz_simple_triggers
(
    sched_name      varchar(120) NOT NULL COMMENT '调度名称',
    trigger_name    varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
    trigger_group   varchar(200) NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
    repeat_count    bigint(7)    NOT NULL COMMENT '重复的次数统计',
    repeat_interval bigint(12)   NOT NULL COMMENT '重复的间隔时间',
    times_triggered bigint(10)   NOT NULL COMMENT '已经触发的次数',
    PRIMARY KEY (sched_name, trigger_name, trigger_group),
    CONSTRAINT qrtz_simple_triggers_ibfk_1
        FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES qrtz_triggers (sched_name, trigger_name, trigger_group)
)
COMMENT '简单触发器的信息表';

CREATE TABLE qrtz_simprop_triggers
(
    sched_name    varchar(120)   NOT NULL COMMENT '调度名称',
    trigger_name  varchar(200)   NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
    trigger_group varchar(200)   NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
    str_prop_1    varchar(512)   NULL COMMENT 'String类型的trigger的第一个参数',
    str_prop_2    varchar(512)   NULL COMMENT 'String类型的trigger的第二个参数',
    str_prop_3    varchar(512)   NULL COMMENT 'String类型的trigger的第三个参数',
    int_prop_1    int            NULL COMMENT 'int类型的trigger的第一个参数',
    int_prop_2    int            NULL COMMENT 'int类型的trigger的第二个参数',
    long_prop_1   bigint         NULL COMMENT 'long类型的trigger的第一个参数',
    long_prop_2   bigint         NULL COMMENT 'long类型的trigger的第二个参数',
    dec_prop_1    decimal(13, 4) NULL COMMENT 'decimal类型的trigger的第一个参数',
    dec_prop_2    decimal(13, 4) NULL COMMENT 'decimal类型的trigger的第二个参数',
    bool_prop_1   varchar(1)     NULL COMMENT 'Boolean类型的trigger的第一个参数',
    bool_prop_2   varchar(1)     NULL COMMENT 'Boolean类型的trigger的第二个参数',
    PRIMARY KEY (sched_name, trigger_name, trigger_group),
    CONSTRAINT qrtz_simprop_triggers_ibfk_1
        FOREIGN KEY (sched_name, trigger_name, trigger_group) REFERENCES qrtz_triggers (sched_name, trigger_name, trigger_group)
)
COMMENT '同步机制的行锁表';

CREATE INDEX sched_name
    ON qrtz_triggers (sched_name, job_name, job_group);

CREATE TABLE sys_config
(
    config_id    int(5) AUTO_INCREMENT COMMENT '参数主键'
        PRIMARY KEY,
    config_name  varchar(100) DEFAULT ''  NULL COMMENT '参数名称',
    config_key   varchar(100) DEFAULT ''  NULL COMMENT '参数键名',
    config_value varchar(500) DEFAULT ''  NULL COMMENT '参数键值',
    config_type  char         DEFAULT 'N' NULL COMMENT '系统内置（Y是 N否）',
    create_by    varchar(64)  DEFAULT ''  NULL COMMENT '创建者',
    create_time  datetime                 NULL COMMENT '创建时间',
    update_by    varchar(64)  DEFAULT ''  NULL COMMENT '更新者',
    update_time  datetime                 NULL COMMENT '更新时间',
    remark       varchar(500)             NULL COMMENT '备注'
)
COMMENT '参数配置表';

CREATE TABLE sys_dept
(
    dept_id     bigint AUTO_INCREMENT COMMENT '部门id'
        PRIMARY KEY,
    parent_id   bigint      DEFAULT 0   NULL COMMENT '父部门id',
    ancestors   varchar(50) DEFAULT ''  NULL COMMENT '祖级列表',
    dept_name   varchar(30) DEFAULT ''  NULL COMMENT '部门名称',
    order_num   int(4)      DEFAULT 0   NULL COMMENT '显示顺序',
    leader      varchar(20)             NULL COMMENT '负责人',
    phone       varchar(11)             NULL COMMENT '联系电话',
    email       varchar(50)             NULL COMMENT '邮箱',
    status      char        DEFAULT '0' NULL COMMENT '部门状态（0正常 1停用）',
    del_flag    char        DEFAULT '0' NULL COMMENT '删除标志（0代表存在 2代表删除）',
    create_by   varchar(64) DEFAULT ''  NULL COMMENT '创建者',
    create_time datetime                NULL COMMENT '创建时间',
    update_by   varchar(64) DEFAULT ''  NULL COMMENT '更新者',
    update_time datetime                NULL COMMENT '更新时间'
)
COMMENT '部门表';

CREATE TABLE sys_dict_data
(
    dict_code   bigint AUTO_INCREMENT COMMENT '字典编码'
        PRIMARY KEY,
    dict_sort   int(4)       DEFAULT 0   NULL COMMENT '字典排序',
    dict_label  varchar(100) DEFAULT ''  NULL COMMENT '字典标签',
    dict_value  varchar(100) DEFAULT ''  NULL COMMENT '字典键值',
    dict_type   varchar(100) DEFAULT ''  NULL COMMENT '字典类型',
    css_class   varchar(100)             NULL COMMENT '样式属性（其他样式扩展）',
    list_class  varchar(100)             NULL COMMENT '表格回显样式',
    is_default  char         DEFAULT 'N' NULL COMMENT '是否默认（Y是 N否）',
    status      char         DEFAULT '0' NULL COMMENT '状态（0正常 1停用）',
    create_by   varchar(64)  DEFAULT ''  NULL COMMENT '创建者',
    create_time datetime                 NULL COMMENT '创建时间',
    update_by   varchar(64)  DEFAULT ''  NULL COMMENT '更新者',
    update_time datetime                 NULL COMMENT '更新时间',
    remark      varchar(500)             NULL COMMENT '备注'
)
COMMENT '字典数据表';

CREATE TABLE sys_dict_type
(
    dict_id     bigint AUTO_INCREMENT COMMENT '字典主键'
        PRIMARY KEY,
    dict_name   varchar(100) DEFAULT ''  NULL COMMENT '字典名称',
    dict_type   varchar(100) DEFAULT ''  NULL COMMENT '字典类型',
    status      char         DEFAULT '0' NULL COMMENT '状态（0正常 1停用）',
    create_by   varchar(64)  DEFAULT ''  NULL COMMENT '创建者',
    create_time datetime                 NULL COMMENT '创建时间',
    update_by   varchar(64)  DEFAULT ''  NULL COMMENT '更新者',
    update_time datetime                 NULL COMMENT '更新时间',
    remark      varchar(500)             NULL COMMENT '备注',
    CONSTRAINT dict_type
        UNIQUE (dict_type)
)
COMMENT '字典类型表';

CREATE TABLE sys_job
(
    job_id          bigint AUTO_INCREMENT COMMENT '任务ID',
    job_name        varchar(64)  DEFAULT ''        NOT NULL COMMENT '任务名称',
    job_group       varchar(64)  DEFAULT 'DEFAULT' NOT NULL COMMENT '任务组名',
    invoke_target   varchar(500)                   NOT NULL COMMENT '调用目标字符串',
    cron_expression varchar(255) DEFAULT ''        NULL COMMENT 'cron执行表达式',
    misfire_policy  varchar(20)  DEFAULT '3'       NULL COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
    concurrent      char         DEFAULT '1'       NULL COMMENT '是否并发执行（0允许 1禁止）',
    status          char         DEFAULT '0'       NULL COMMENT '状态（0正常 1暂停）',
    create_by       varchar(64)  DEFAULT ''        NULL COMMENT '创建者',
    create_time     datetime                       NULL COMMENT '创建时间',
    update_by       varchar(64)  DEFAULT ''        NULL COMMENT '更新者',
    update_time     datetime                       NULL COMMENT '更新时间',
    remark          varchar(500) DEFAULT ''        NULL COMMENT '备注信息',
    PRIMARY KEY (job_id, job_name, job_group)
)
COMMENT '定时任务调度表';

CREATE TABLE sys_job_log
(
    job_log_id     bigint AUTO_INCREMENT COMMENT '任务日志ID'
        PRIMARY KEY,
    job_name       varchar(64)               NOT NULL COMMENT '任务名称',
    job_group      varchar(64)               NOT NULL COMMENT '任务组名',
    invoke_target  varchar(500)              NOT NULL COMMENT '调用目标字符串',
    job_message    varchar(500)              NULL COMMENT '日志信息',
    status         char          DEFAULT '0' NULL COMMENT '执行状态（0正常 1失败）',
    exception_info varchar(2000) DEFAULT ''  NULL COMMENT '异常信息',
    create_time    datetime                  NULL COMMENT '创建时间'
)
COMMENT '定时任务调度日志表';

CREATE TABLE sys_logininfor
(
    info_id        bigint AUTO_INCREMENT COMMENT '访问ID'
        PRIMARY KEY,
    login_name     varchar(50)  DEFAULT ''  NULL COMMENT '登录账号',
    ipaddr         varchar(128) DEFAULT ''  NULL COMMENT '登录IP地址',
    login_location varchar(255) DEFAULT ''  NULL COMMENT '登录地点',
    browser        varchar(50)  DEFAULT ''  NULL COMMENT '浏览器类型',
    os             varchar(50)  DEFAULT ''  NULL COMMENT '操作系统',
    status         char         DEFAULT '0' NULL COMMENT '登录状态（0成功 1失败）',
    msg            varchar(255) DEFAULT ''  NULL COMMENT '提示消息',
    login_time     datetime                 NULL COMMENT '访问时间'
)
COMMENT '系统访问记录';

CREATE TABLE sys_menu
(
    menu_id     bigint AUTO_INCREMENT COMMENT '菜单ID'
        PRIMARY KEY,
    menu_name   varchar(50)              NOT NULL COMMENT '菜单名称',
    parent_id   bigint       DEFAULT 0   NULL COMMENT '父菜单ID',
    order_num   int(4)       DEFAULT 0   NULL COMMENT '显示顺序',
    url         varchar(200) DEFAULT '#' NULL COMMENT '请求地址',
    target      varchar(20)  DEFAULT ''  NULL COMMENT '打开方式（menuItem页签 menuBlank新窗口）',
    menu_type   char         DEFAULT ''  NULL COMMENT '菜单类型（M目录 C菜单 F按钮）',
    visible     char         DEFAULT '0' NULL COMMENT '菜单状态（0显示 1隐藏）',
    is_refresh  char         DEFAULT '1' NULL COMMENT '是否刷新（0刷新 1不刷新）',
    perms       varchar(100)             NULL COMMENT '权限标识',
    icon        varchar(100) DEFAULT '#' NULL COMMENT '菜单图标',
    create_by   varchar(64)  DEFAULT ''  NULL COMMENT '创建者',
    create_time datetime                 NULL COMMENT '创建时间',
    update_by   varchar(64)  DEFAULT ''  NULL COMMENT '更新者',
    update_time datetime                 NULL COMMENT '更新时间',
    remark      varchar(500) DEFAULT ''  NULL COMMENT '备注'
)
COMMENT '菜单权限表';

CREATE TABLE sys_notice
(
    notice_id      int(4) AUTO_INCREMENT COMMENT '公告ID'
        PRIMARY KEY,
    notice_title   varchar(50)             NOT NULL COMMENT '公告标题',
    notice_type    char                    NOT NULL COMMENT '公告类型（1通知 2公告）',
    notice_content varchar(2000)           NULL COMMENT '公告内容',
    status         char        DEFAULT '0' NULL COMMENT '公告状态（0正常 1关闭）',
    create_by      varchar(64) DEFAULT ''  NULL COMMENT '创建者',
    create_time    datetime                NULL COMMENT '创建时间',
    update_by      varchar(64) DEFAULT ''  NULL COMMENT '更新者',
    update_time    datetime                NULL COMMENT '更新时间',
    remark         varchar(255)            NULL COMMENT '备注'
)
COMMENT '通知公告表';

CREATE TABLE sys_oper_log
(
    oper_id        bigint AUTO_INCREMENT COMMENT '日志主键'
        PRIMARY KEY,
    title          varchar(50)   DEFAULT '' NULL COMMENT '模块标题',
    business_type  int(2)        DEFAULT 0  NULL COMMENT '业务类型（0其它 1新增 2修改 3删除）',
    method         varchar(100)  DEFAULT '' NULL COMMENT '方法名称',
    request_method varchar(10)   DEFAULT '' NULL COMMENT '请求方式',
    operator_type  int(1)        DEFAULT 0  NULL COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
    oper_name      varchar(50)   DEFAULT '' NULL COMMENT '操作人员',
    dept_name      varchar(50)   DEFAULT '' NULL COMMENT '部门名称',
    oper_url       varchar(255)  DEFAULT '' NULL COMMENT '请求URL',
    oper_ip        varchar(128)  DEFAULT '' NULL COMMENT '主机地址',
    oper_location  varchar(255)  DEFAULT '' NULL COMMENT '操作地点',
    oper_param     varchar(2000) DEFAULT '' NULL COMMENT '请求参数',
    json_result    varchar(2000) DEFAULT '' NULL COMMENT '返回参数',
    status         int(1)        DEFAULT 0  NULL COMMENT '操作状态（0正常 1异常）',
    error_msg      varchar(2000) DEFAULT '' NULL COMMENT '错误消息',
    oper_time      datetime                 NULL COMMENT '操作时间'
)
COMMENT '操作日志记录';

CREATE TABLE sys_post
(
    post_id     bigint AUTO_INCREMENT COMMENT '岗位ID'
        PRIMARY KEY,
    post_code   varchar(64)            NOT NULL COMMENT '岗位编码',
    post_name   varchar(50)            NOT NULL COMMENT '岗位名称',
    post_sort   int(4)                 NOT NULL COMMENT '显示顺序',
    status      char                   NOT NULL COMMENT '状态（0正常 1停用）',
    create_by   varchar(64) DEFAULT '' NULL COMMENT '创建者',
    create_time datetime               NULL COMMENT '创建时间',
    update_by   varchar(64) DEFAULT '' NULL COMMENT '更新者',
    update_time datetime               NULL COMMENT '更新时间',
    remark      varchar(500)           NULL COMMENT '备注'
)
COMMENT '岗位信息表';

CREATE TABLE sys_role
(
    role_id     bigint AUTO_INCREMENT COMMENT '角色ID'
        PRIMARY KEY,
    role_name   varchar(30)             NOT NULL COMMENT '角色名称',
    role_key    varchar(100)            NOT NULL COMMENT '角色权限字符串',
    role_sort   int(4)                  NOT NULL COMMENT '显示顺序',
    data_scope  char        DEFAULT '1' NULL COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
    status      char                    NOT NULL COMMENT '角色状态（0正常 1停用）',
    del_flag    char        DEFAULT '0' NULL COMMENT '删除标志（0代表存在 2代表删除）',
    create_by   varchar(64) DEFAULT ''  NULL COMMENT '创建者',
    create_time datetime                NULL COMMENT '创建时间',
    update_by   varchar(64) DEFAULT ''  NULL COMMENT '更新者',
    update_time datetime                NULL COMMENT '更新时间',
    remark      varchar(500)            NULL COMMENT '备注'
)
COMMENT '角色信息表';

CREATE TABLE sys_role_dept
(
    role_id bigint NOT NULL COMMENT '角色ID',
    dept_id bigint NOT NULL COMMENT '部门ID',
    PRIMARY KEY (role_id, dept_id)
)
COMMENT '角色和部门关联表';

CREATE TABLE sys_role_menu
(
    role_id bigint NOT NULL COMMENT '角色ID',
    menu_id bigint NOT NULL COMMENT '菜单ID',
    PRIMARY KEY (role_id, menu_id)
)
COMMENT '角色和菜单关联表';

CREATE TABLE sys_user
(
    user_id         bigint AUTO_INCREMENT COMMENT '用户ID'
        PRIMARY KEY,
    dept_id         bigint                    NULL COMMENT '部门ID',
    login_name      varchar(30)               NOT NULL COMMENT '登录账号',
    user_name       varchar(30)  DEFAULT ''   NULL COMMENT '用户昵称',
    user_type       varchar(2)   DEFAULT '00' NULL COMMENT '用户类型（00系统用户 01注册用户）',
    email           varchar(50)  DEFAULT ''   NULL COMMENT '用户邮箱',
    phonenumber     varchar(11)  DEFAULT ''   NULL COMMENT '手机号码',
    sex             char         DEFAULT '0'  NULL COMMENT '用户性别（0男 1女 2未知）',
    avatar          varchar(100) DEFAULT ''   NULL COMMENT '头像路径',
    password        varchar(50)  DEFAULT ''   NULL COMMENT '密码',
    salt            varchar(20)  DEFAULT ''   NULL COMMENT '盐加密',
    status          char         DEFAULT '0'  NULL COMMENT '帐号状态（0正常 1停用）',
    del_flag        char         DEFAULT '0'  NULL COMMENT '删除标志（0代表存在 2代表删除）',
    login_ip        varchar(128) DEFAULT ''   NULL COMMENT '最后登录IP',
    login_date      datetime                  NULL COMMENT '最后登录时间',
    pwd_update_date datetime                  NULL COMMENT '密码最后更新时间',
    create_by       varchar(64)  DEFAULT ''   NULL COMMENT '创建者',
    create_time     datetime                  NULL COMMENT '创建时间',
    update_by       varchar(64)  DEFAULT ''   NULL COMMENT '更新者',
    update_time     datetime                  NULL COMMENT '更新时间',
    remark          varchar(500)              NULL COMMENT '备注'
)
COMMENT '用户信息表';

CREATE TABLE sys_user_online
(
    sessionId        varchar(50)  DEFAULT '' NOT NULL COMMENT '用户会话id'
        PRIMARY KEY,
    login_name       varchar(50)  DEFAULT '' NULL COMMENT '登录账号',
    dept_name        varchar(50)  DEFAULT '' NULL COMMENT '部门名称',
    ipaddr           varchar(128) DEFAULT '' NULL COMMENT '登录IP地址',
    login_location   varchar(255) DEFAULT '' NULL COMMENT '登录地点',
    browser          varchar(50)  DEFAULT '' NULL COMMENT '浏览器类型',
    os               varchar(50)  DEFAULT '' NULL COMMENT '操作系统',
    status           varchar(10)  DEFAULT '' NULL COMMENT '在线状态on_line在线off_line离线',
    start_timestamp  datetime                NULL COMMENT 'session创建时间',
    last_access_time datetime                NULL COMMENT 'session最后访问时间',
    expire_time      int(5)       DEFAULT 0  NULL COMMENT '超时时间，单位为分钟'
)
COMMENT '在线用户记录';

CREATE TABLE sys_user_post
(
    user_id bigint NOT NULL COMMENT '用户ID',
    post_id bigint NOT NULL COMMENT '岗位ID',
    PRIMARY KEY (user_id, post_id)
)
COMMENT '用户与岗位关联表';

CREATE TABLE sys_user_role
(
    user_id bigint NOT NULL COMMENT '用户ID',
    role_id bigint NOT NULL COMMENT '角色ID',
    PRIMARY KEY (user_id, role_id)
)
COMMENT '用户和角色关联表';

