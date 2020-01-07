package com.bitware.utils;

import com.bitware.bean.UserInfo;

import javax.servlet.http.HttpServletRequest;

/**
 * @author  ludaxian
 * 封装后端当前线程用户信息类
 */
public class BitUser {
    private static final ThreadLocal<UserInfo> userHolder = new ThreadLocal();

    private static final ThreadLocal<HttpServletRequest> requestHolder = new ThreadLocal();

    public static void add(UserInfo userInfo) {
        userHolder.set(userInfo);
    }

    public static void add(HttpServletRequest request) {
        requestHolder.set(request);
    }

    public static UserInfo getCurrentUser() {
        return userHolder.get();
    }

    public static HttpServletRequest getCurrentRequest() {
        return requestHolder.get();
    }

    public static void remove() {
        userHolder.remove();
        requestHolder.remove();
    }
}
