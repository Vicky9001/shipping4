package auth.controller;


import auth.component.Oauth2TokenDto;
import com.example.entity.User.User;
import auth.mapper.UserMapper;
import com.example.utils.JwtUtils;
import com.example.utils.Result;
import com.example.utils.ResultCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.security.oauth2.provider.endpoint.TokenEndpoint;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/oauth")
public class AuthController {

    @Autowired
    private TokenEndpoint tokenEndpoint;

    @Resource
    PasswordEncoder passwordEncoder;
    @Resource
    private UserMapper userMapper;
    /**
     * Oauth2登录认证
     */
    @RequestMapping(value = "/token", method = RequestMethod.POST)
    public Result postAccessToken(Principal principal, @RequestParam Map<String, String> parameters) throws HttpRequestMethodNotSupportedException {
        OAuth2AccessToken oAuth2AccessToken = tokenEndpoint.postAccessToken(principal, parameters).getBody();
        Oauth2TokenDto oauth2TokenDto = Oauth2TokenDto.builder()
                .token(oAuth2AccessToken.getValue())
                .refreshToken(oAuth2AccessToken.getRefreshToken().getValue())
                .expiresIn(oAuth2AccessToken.getExpiresIn())
                .tokenHead("Bearer ").build();
        Result r = new Result();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("token",oauth2TokenDto);
        r.setData(map);
        return r;
    }}
