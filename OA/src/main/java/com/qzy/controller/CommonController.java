package com.qzy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * @author qingzeyu
 */
@Controller
public class CommonController {
    @RequestMapping("/page_{page}")
    public String toPage(@PathVariable("page") String page){
//            return "/"+page+".jsp";
        return page;
    }
}
