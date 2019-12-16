package com.qzy.controller;

import com.qzy.utils.LoginStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

/**
 * @author qingzeyu
 */
@Controller
public class UploadController {
    @ResponseBody
    @RequestMapping("/photoUpload")
    public LoginStatus uploadFile(MultipartFile file, HttpSession session) throws IOException {
        String oldFileName = file.getOriginalFilename();
        String substring = oldFileName.substring(oldFileName.lastIndexOf("."), oldFileName.length());
        String fileName = UUID.randomUUID().toString() + substring;
        String realPath = session.getServletContext().getRealPath("/media/upload");
        realPath = realPath + "\\" + fileName;
        System.out.println("真实地址" + realPath);
        file.transferTo(new File(realPath));
        LoginStatus loginStatus = new LoginStatus(fileName, 200);
        return loginStatus;
    }
}
