package com.example.filter;

import cn.hutool.json.JSONUtil;
import com.example.utils.Result;
import com.example.utils.ResultCode;
import org.springframework.core.io.buffer.DataBuffer;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.server.authorization.ServerAccessDeniedHandler;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import java.nio.charset.Charset;


/**
 * 自定义返回结果：没有权限访问时
 * Created by macro on 2018/4/26.
 */
@Component
public class RestfulAccessDeniedHandler implements ServerAccessDeniedHandler {

    ResultCode resultCode = new ResultCode();
    @Override
    public Mono<Void> handle(ServerWebExchange exchange, AccessDeniedException denied) {
        ServerHttpResponse response = exchange.getResponse();
        response.setStatusCode(HttpStatus.OK);
        response.getHeaders().add(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE);
        Result r = new Result();
        r.setCode(ResultCode.FORBIDDEN);
        r.setMessage(resultCode.getMsg(ResultCode.FORBIDDEN));
        String body= JSONUtil.toJsonStr(r);
        DataBuffer buffer =  response.bufferFactory().wrap(body.getBytes(Charset.forName("UTF-8")));
        return response.writeWith(Mono.just(buffer));
    }
}