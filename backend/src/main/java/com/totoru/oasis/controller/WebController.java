package com.totoru.oasis.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WebController {
    @RequestMapping(value = {
            "/{path:[^\\.]+}",
            "/{path1:[^\\.]+}/{path2:[^\\.]+}",
            "/{path1:[^\\.]+}/{path2:[^\\.]+}/{path3:[^\\.]+}",
            "/{path1:[^\\.]+}/{path2:[^\\.]+}/{path3:[^\\.]+}/{path4:[^\\.]+}"
    })
    public String forward() {
        return "forward:/index.html";
    }
}
