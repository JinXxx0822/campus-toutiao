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
        User user = userService.login(username, password);
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
        if (userService.isUsernameExists(user.getUsername())) {
            return Result.error("用户名已存在");
        }
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
}
