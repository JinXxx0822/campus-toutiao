package com.campus.toutiao.controller;

import com.campus.toutiao.common.Result;
import com.campus.toutiao.entity.User;
import com.campus.toutiao.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @PostMapping("/login")
    @ResponseBody
    public Result login(String username, String password, HttpSession session) {
        // 后端参数校验
        if (isBlank(username) || isBlank(password)) {
            return Result.error("用户名和密码不能为空");
        }
        User user = userService.login(username.trim(), password);
        if (user != null) {
            session.setAttribute("loginUser", user);
            return Result.success("登录成功", user);
        }
        return Result.error("用户名或密码错误");
    }

    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    @PostMapping("/register")
    @ResponseBody
    public Result register(User user) {
        // 后端参数校验：非空 + 长度
        if (isBlank(user.getUsername()) || isBlank(user.getPassword()) || isBlank(user.getNickname())) {
            return Result.error("用户名、密码、昵称均不能为空");
        }
        String username = user.getUsername().trim();
        if (username.length() < 3 || username.length() > 20) {
            return Result.error("用户名长度需为 3-20 个字符");
        }
        if (user.getPassword().length() < 6 || user.getPassword().length() > 30) {
            return Result.error("密码长度需为 6-30 个字符");
        }
        if (userService.isUsernameExists(username)) {
            return Result.error("用户名已存在");
        }
        user.setUsername(username);
        userService.register(user);
        return Result.success("注册成功", null);
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/profile")
    public String profilePage(HttpSession session) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null) {
            return "redirect:/user/login";
        }
        return "profile";
    }

    /** 判断字符串是否为空（null 或去空格后为空） */
    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}
