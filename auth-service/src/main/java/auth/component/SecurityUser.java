package auth.component;



import com.example.entity.User.User;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;


public class SecurityUser implements UserDetails {
	private static final long serialVersionUID = 1L;

	private Long id;

	private String userName;
	private String realName;

	private String phone;

	@JsonIgnore
	private String password;

	private Collection<? extends GrantedAuthority> authorities;

	public SecurityUser(Long id, String username, String realName, String password,
						String phone, Collection<? extends GrantedAuthority> authorities) {
		this.id = id;
		this.userName = username;
		this.realName = realName;
		this.password = password;
		this.phone = phone;
		this.authorities = authorities;
	}

	public static SecurityUser build(User user) {
		List<GrantedAuthority> authorities = user.getRoles().stream()
				.map(role -> new SimpleGrantedAuthority(role.getRoleName().name()))
				.collect(Collectors.toList());

		return new SecurityUser(
				user.getId(),
				user.getUsername(),
				user.getRealName(),
				user.getPassword(),
				user.getPhone(),
				authorities);
	}


	public Long getId() {
		return id;
	}


	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authorities;
	}

	@Override
	public String getPassword() {
		return password;
	}

	@Override
	public String getUsername() {
		return userName;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}

	@Override
	public boolean equals(Object o) {
		if (this == o)
			return true;
		if (o == null || getClass() != o.getClass())
			return false;
		SecurityUser user = (SecurityUser) o;
		return Objects.equals(id, user.id);
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}


	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setAuthorities(Collection<? extends GrantedAuthority> authorities) {
		this.authorities = authorities;
	}

}
