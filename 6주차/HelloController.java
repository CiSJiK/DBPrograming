package kr.ac.kangwon.eruri.SpringLearning.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class HelloController {
    @GetMapping("hello")
    public String hello(Model model){
        model.addAttribute("name", "김성진");
        model.addAttribute("dept", "컴퓨터과학전공");
        return "hello";
    }
    @GetMapping("hello-mvc")
    public String helloMvc(@RequestParam("name") String name, @RequestParam("dept") String dept, @RequestParam("year") short year, Model model)
    {
        model.addAttribute("name", name);
        model.addAttribute("dept", dept);
        model.addAttribute("year", year);
        return "hello-template";
    }

    @GetMapping("hello-string")
    @ResponseBody
    public String helloString(@RequestParam("name") String name, @RequestParam("dept") String dept, @RequestParam("year") short year)
    {
        return "안녕하세요. 제 이름은 " + name + "입니다. 소속은 " + dept + "이고 " + year +"학년 입니다.";
    }

    @GetMapping("hello-api")
    @ResponseBody
    public Hello helloApi(@RequestParam("name") String name, @RequestParam("dept") String dept, @RequestParam("year") short year)
    {
        Hello hello = new Hello();
        hello.setName(name);
        hello.setDept(dept);
        hello.setYear(year);
        return hello;
    }
    static class Hello{
        private String name;
        private String dept;
        private short year;
        public String getName()
        {
            return name;
        }
        public void setName(String name)
        {
            this.name = name;
        }

        public String getDept() {
            return dept;
        }

        public void setDept(String dept) {
            this.dept = dept;
        }

        public short getYear() {
            return year;
        }

        public void setYear(short year) {
            this.year = year;
        }
    }
}
