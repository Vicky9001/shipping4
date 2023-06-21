package auth.service;
import auth.mapper.RoleMapper;
import auth.mapper.UserMapper;
import auth.component.SecurityUser;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;

import com.example.entity.User.Role;
import com.example.entity.User.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.Set;


@Service
public class UserServiceImpl implements UserDetailsService {
	@Resource
	UserMapper userMapper;

	@Resource
	RoleMapper roleMapper;


	@Override
	@Transactional
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		System.out.println("loadUser,username:"+username);
		QueryWrapper q = new QueryWrapper<>();
		q.eq("username",username);
		User user = userMapper.selectOne(q);
		try {
			List<Role> role = roleMapper.selectList(new QueryWrapper<Role>().inSql("role_id","select role_id from user_role where user_id = "+user.getId() ));
			user.setRoles((Set<Role>) role);
		}catch (Exception e) {
			System.out.println("e");
			e.printStackTrace();
		}
		return SecurityUser.build(user);
	}

}
