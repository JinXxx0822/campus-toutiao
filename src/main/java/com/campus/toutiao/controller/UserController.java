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

    /**
     * 更新个人资料（昵称/学校/学院/个性签名）。
     * 校验后写入，并刷新 session 中的登录用户信息。
     */
    @PostMapping("/profile/update")
    @ResponseBody
    public Result updateProfile(User user, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return Result.error(401, "请先登录");
        }
        user.setId(loginUser.getId());

        // 昵称必填，长度限制
        if (isBlank(user.getNickname())) {
            return Result.error("昵称不能为空");
        }
        user.setNickname(user.getNickname().trim());
        if (user.getNickname().length() > 30) {
            return Result.error("昵称过长（最多 30 字）");
        }
        // 选填字段：去空格 + 长度限制（超长截断，避免脏数据）
        user.setSchool(trimToNull(user.getSchool(), 50));
        user.setCollege(trimToNull(user.getCollege(), 50));
        user.setSignature(trimToNull(user.getSignature(), 100));

        boolean ok = userService.updateProfile(user);
        if (!ok) {
            return Result.error("资料更新失败");
        }
        // 刷新 session 中的用户信息
        User fresh = userService.findById(loginUser.getId());
        session.setAttribute("loginUser", fresh);
        return Result.success("资料已更新", fresh);
    }

    /**
     * 修改密码：校验旧密码后，以加盐哈希写入新密码。
     * 修改成功后建议用户重新登录。
     */
    @PostMapping("/password")
    @ResponseBody
    public Result changePassword(String oldPassword, String newPassword, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser == null) {
            return Result.error(401, "请先登录");
        }
        if (isBlank(oldPassword) || isBlank(newPassword)) {
            return Result.error("新旧密码均不能为空");
        }
        if (newPassword.length() < 6 || newPassword.length() > 30) {
            return Result.error("新密码长度需为 6-30 个字符");
        }
        if (newPassword.equals(oldPassword)) {
            return Result.error("新密码不能与原密码相同");
        }
        boolean ok = userService.changePassword(loginUser.getId(), oldPassword, newPassword);
        if (!ok) {
            return Result.error("原密码不正确");
        }
        return Result.success("密码已修改，请重新登录", null);
    }

    /** 去空格；空字符串转为 null；超长截断到 maxLen。 */
    private String trimToNull(String s, int maxLen) {
        if (s == null) {
            return null;
        }
        s = s.trim();
        if (s.isEmpty()) {
            return null;
        }
        return s.length() > maxLen ? s.substring(0, maxLen) : s;
    }
}
