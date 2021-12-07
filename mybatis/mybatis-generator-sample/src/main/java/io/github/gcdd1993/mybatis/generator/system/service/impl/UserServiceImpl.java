package io.github.gcdd1993.mybatis.generator.system.service.impl;

import io.github.gcdd1993.mybatis.generator.system.entity.User;
import io.github.gcdd1993.mybatis.generator.system.mapper.UserMapper;
import io.github.gcdd1993.mybatis.generator.system.service.IUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 用户信息表 服务实现类
 * </p>
 *
 * @author gcdd1993
 * @since 2021-12-07
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

}
