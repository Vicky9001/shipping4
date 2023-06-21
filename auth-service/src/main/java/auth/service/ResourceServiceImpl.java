package auth.service;

import auth.component.RedisConstant;
import cn.hutool.core.collection.CollUtil;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

@Service
public class ResourceServiceImpl {

    private Map<String, List<String>> resourceRolesMap;

    @Resource
    private RedisTemplate<String,Object> redisTemplate;

    @PostConstruct
    public void initData() {
        resourceRolesMap = new TreeMap<>();
        resourceRolesMap.put("/user/*", CollUtil.toList("超级管理员","承运人","用户"));

        redisTemplate.opsForHash().putAll(RedisConstant.RESOURCE_ROLES_MAP, resourceRolesMap);
    }
}
