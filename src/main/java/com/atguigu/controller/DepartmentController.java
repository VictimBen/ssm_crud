package com.atguigu.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.bean.Department;
import com.atguigu.bean.Msg;
import com.atguigu.service.DepartmentService;

/**
 * 处理和部门有关的请求
 * @author Administrator
 *
 */
@Controller
public class DepartmentController {
	@Autowired
	DepartmentService departmentService;
	
	/**
	 * 返回所有部门信息
	 * @return
	 */
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts(){
		
		List<Department> list = departmentService.getDepts();
		return Msg.success().add("depts", list);
	}
}
