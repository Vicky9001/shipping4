package com.example.controllers;

import com.example.entity.User.ERole;
import com.example.entity.User.Role;
import com.example.entity.User.User;
import com.example.payload.request.UserRequest;
import com.example.repository.RoleRepository;
import com.example.repository.UserRepository;
import com.example.utils.JwtUtils;
import com.example.utils.Result;
import com.example.utils.ResultCode;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/user")
public class UserController {

	@Resource
	UserRepository userRepository;

	@Resource
	RoleRepository roleRepository;

	@Resource
	PasswordEncoder encoder;

	@Resource
	JwtUtils jwtUtils;

	ResultCode resultCode;

	@PostMapping("/login")
	public Result login(@RequestBody User user){
		Result res = new Result();
		Map<String, Object> map = new HashMap<>();
		System.out.println("username"+user.getUsername()+"password"+user.getPassword());
		try {
			User info = userRepository.findByUsernameAndPassword(user.getUsername(),user.getPassword()).get();
			if(info!=null){
				String token = JwtUtils.generateToken(user.getUsername());
				map.put("token",token);
				res.setMessage("登录成功");
				res.setData(map);
			}else {
				res.setCode(ResultCode.LOGINERR);
				res.setMessage(resultCode.getMsg(ResultCode.LOGINERR));
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setCode(ResultCode.ERROR);
			res.setMessage(resultCode.getMsg(ResultCode.ERROR));
		}

		return res;
	}



	/**
	 * 用户查询
	 * @param userName
	 * @param realName
	 * @return
	 */
	@GetMapping("/userList")
	public Result queryUserList(@RequestParam(required = false,name = "userName") String userName,
								@RequestParam(required = false,name = "realName") String realName){
		Result res = new Result();
		Map<String, Object> map = new HashMap<>();
		try{
			Set<Role> roleSet=new HashSet<>();
			Role shipperRole = roleRepository.findByRoleName(ERole.ROLE_SHIPPER)
					.orElseThrow(() -> new RuntimeException("Error: Role is not found."));
			roleSet.add(shipperRole);
				List<User> list = userRepository.findByUsernameContainingAndRealNameContaining(userName,realName);
				List<User> userList = new ArrayList<>();
					// 去除重复查询
				list = list.stream().distinct().collect(Collectors.toList());
				for(User u : list) {
					if(u.getRoles().contains(shipperRole)) {
						userList.add(u);
					}
				}
				map.put("userList",userList);
				res.setMessage("返回成功");
				res.setData(map);
		} catch (Exception e) {
			e.printStackTrace();
			res.setCode(resultCode.ERROR);
			res.setMessage(resultCode.getMsg(resultCode.ERROR));
		}
		return res;
	}

	@GetMapping("/carrierList")
	public Result queryCarrierList(@RequestParam(required = false,name = "userName") String userName,
								@RequestParam(required = false,name = "realName") String realName){
		Result res = new Result();
		Map<String, Object> map = new HashMap<>();
		try{
			Set<Role> roleSet=new HashSet<>();
			Role carrierRole = roleRepository.findByRoleName(ERole.ROLE_CARRIER)
					.orElseThrow(() -> new RuntimeException("Error: Role is not found."));
			roleSet.add(carrierRole);
			List<User> list = userRepository.findByUsernameContainingAndRealNameContaining(userName,realName);
			List<User> l = new ArrayList<>();
			// 去除重复查询
			list = list.stream().distinct().collect(Collectors.toList());
			for(User u: list){
				if(u.getRoles().contains(carrierRole)) {
					l.add(u);
				}
			}
			map.put("carrierList",l);
			res.setMessage("返回成功");
			res.setData(map);
		} catch (Exception e) {
			e.printStackTrace();
			res.setCode(resultCode.ERROR);
			res.setMessage(resultCode.getMsg(resultCode.ERROR));
		}
		return res;
	}

	/**
	 * 修改用戶
	 * @param userRequest
	 * @return
	 */
	@PostMapping("/modifyUser")
	public Result modifyUser(@Valid @RequestBody UserRequest userRequest) {
		Result res = new Result();
		Map<String, Object> response = new HashMap<>();
		if (!userRepository.existsById(userRequest.getId())) {
			return ResponseEntity
					.badRequest()
					.body(new Result(ResultCode.EXISTERR, "Error: user not found!", response)).getBody();
		}

		User user = new User(userRequest.getUsername(),
				userRequest.getRealName(),
				userRequest.getPhone(),
				encoder.encode(userRequest.getPassword()));

		System.out.println(user);
		Long id = userRequest.getId();
		user.setId(id);
		Set<Role> roles = new HashSet<>();
		Role role = roleRepository.findByRoleName(ERole.ROLE_SHIPPER)
				.orElseThrow(() -> new RuntimeException("Error: Role is not found."));
		roles.add(role);
		user.setRoles(roles);

		if(userRepository.existsByUsername(user.getUsername())){
			if(userRepository.findByUsername(user.getUsername()).get().getId() != id) {
				res.setCode(ResultCode.InfoModERR);
				res.setMessage("用户名已存在");
				return res;
			}
		}

		if(userRepository.existsByPhone(user.getPhone())){
			if(userRepository.findByPhone(user.getPhone()).getId() != id) {
				res.setCode(ResultCode.InfoModERR);
				res.setMessage("联系方式已存在");
				return res;
			}
		}

		//JPA 新增和修改用的都是save方法. 它根据实体类的id是否为0来判断是进行增加还是修改.
		try{
			userRepository.save(user);
			res.setMessage("用户信息更新成功");
		}catch (Exception e){
			res.setCode(ResultCode.InfoModERR);
			res.setMessage(resultCode.getMsg(ResultCode.InfoModERR));
		}

		return res;
	}

	/**
	 * 修改員工
	 * @param userRequest
	 * @return
	 */
	@PostMapping("/modifyCarrier")
	public Result modifyCarrier(@Valid @RequestBody UserRequest userRequest) {
		Result res = new Result();
		Map<String, Object> response = new HashMap<>();
		if (!userRepository.existsById(userRequest.getId())) {
			return ResponseEntity
					.badRequest()
					.body(new Result(ResultCode.EXISTERR, "Error: user not found!", response)).getBody();
		}

		LocalDate a = LocalDate.parse(userRequest.getEntryTime());
		LocalDate b = LocalDate.parse(userRequest.getBirthday());
		User user = new User(userRequest.getUsername(),
				userRequest.getRealName(),
				userRequest.getPhone(),
				userRequest.getSex(),
				a,
				b,
				encoder.encode(userRequest.getPassword()));

		System.out.println(user);
		Long id = userRequest.getId();
		user.setId(id);
		Set<Role> roles = new HashSet<>();
		Role role = roleRepository.findByRoleName(ERole.ROLE_CARRIER)
				.orElseThrow(() -> new RuntimeException("Error: Role is not found."));
		roles.add(role);
		user.setRoles(roles);

		if(userRepository.existsByUsername(user.getUsername())){
			if(userRepository.findByUsername(user.getUsername()).get().getId() != id) {
				res.setCode(ResultCode.InfoModERR);
				res.setMessage("用户名已存在");
				return res;
			}
		}

		System.out.println(user.getPhone());
		if(userRepository.existsByPhone(user.getPhone())){
			if(userRepository.findByPhone(user.getPhone()).getId() != id) {
				res.setCode(ResultCode.InfoModERR);
				res.setMessage("联系方式已存在");
				return res;
			}
		}

		//JPA 新增和修改用的都是save方法. 它根据实体类的id是否为0来判断是进行增加还是修改.
		try{
			userRepository.save(user);
			res.setMessage("員工信息更新成功");
		}catch (Exception e){
			res.setCode(ResultCode.InfoModERR);
			res.setMessage(resultCode.getMsg(ResultCode.InfoModERR));
		}

		return res;
	}


	/**
	 * 批量删除
	 * @param params
	 * @return
	 */
	@DeleteMapping("/deleteUsers")
	public Result deleteUser(@RequestBody Map<String, Object> params){
		Result res = new Result();
		List<User> users = new ArrayList<>();
		List<Integer> ids = (List<Integer>) params.get("ids");
		for(int i:ids) {
			User u = userRepository.findById(Long.valueOf(i)).get();
			users.add(u);
		}
		try {
			userRepository.deleteInBatch(users);
			res.setMessage("删除角色成功");
		} catch (Exception e) {
			e.printStackTrace();
			res.setCode(ResultCode.ERROR);
			res.setMessage(resultCode.getMsg(ResultCode.ERROR));
		}
		return res;
	}

	/**
	 * 增加用戶
	 * @param user
	 * @return
	 */
	@PostMapping("/addUser")
	public Result addUser(@RequestBody User user){
		Result res = new Result();
		Set<Role> rr=new HashSet<>();
		Role role = roleRepository.findByRoleName(ERole.ROLE_SHIPPER)
				.orElseThrow(() -> new RuntimeException("Error: Role is not found."));
		rr.add(role);
		user.setRoles(rr);
		user.setPassword(encoder.encode(user.getPassword()));
		if(userRepository.existsByUsername(user.getUsername())) {
			res.setCode(ResultCode.EXISTERR);
			res.setMessage("该用户名已存在");
			return res;
		}
		if(userRepository.existsByPhone(user.getPhone())) {
			res.setCode(ResultCode.EXISTERR);
			res.setMessage("该电话号码已存在");
			return res;
		}
		try {
			User r = userRepository.save(user);
			if(r.getId()!=null){
				res.setMessage("新增用户成功");
			}else{
				res.setCode(ResultCode.EXISTERR);
				res.setMessage(resultCode.getMsg(ResultCode.EXISTERR));
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setCode(ResultCode.ERROR);
			res.setMessage(resultCode.getMsg(ResultCode.ERROR));
		}

		return res;
	}

	/**
	 * 增加员工
	 * @param user
	 * @return
	 */
	@PostMapping("/addCarrier")
	public Result addCarrier(@RequestBody User user){
		Result res = new Result();
		Set<Role> rr=new HashSet<>();
		Role role = roleRepository.findByRoleName(ERole.ROLE_CARRIER)
				.orElseThrow(() -> new RuntimeException("Error: Role is not found."));
		rr.add(role);
		user.setRoles(rr);
		user.setPassword(encoder.encode(user.getPassword()));
		if(userRepository.existsByUsername(user.getUsername())) {
			res.setCode(ResultCode.EXISTERR);
			res.setMessage("该用户名已存在");
			return res;
		}
		if(userRepository.existsByPhone(user.getPhone())) {
			res.setCode(ResultCode.EXISTERR);
			res.setMessage("该电话号码已存在");
			return res;
		}
		try {
			User r = userRepository.save(user);
			if(r.getId()!=null){
				res.setMessage("新增员工成功");
			}else{
				res.setCode(ResultCode.EXISTERR);
				res.setMessage(resultCode.getMsg(ResultCode.EXISTERR));
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setCode(ResultCode.ERROR);
			res.setMessage(resultCode.getMsg(ResultCode.ERROR));
		}

		return res;
	}

	@GetMapping("/findUserById")
	public User findById(@RequestParam(required = true,name = "id") Long id){
		Result res = new Result();
		Set<Role> rr=new HashSet<>();
		User u = userRepository.findById(id).get();
		return u;
	}

	@GetMapping("/findByRoleName")
	public Optional<Role> findByRoleName(@RequestParam(required = true,name = "roleName") ERole roleName) {
		Optional<Role> u = roleRepository.findByRoleName(roleName);
		return u;
	}

	@GetMapping("/findByUsernameContaining")
	public List<User> findByUsernameContaining(@RequestParam(required = true,name = "username") String username) {
		List<User> users = userRepository.findByUsernameContaining(username);
		return users;
	}
}
