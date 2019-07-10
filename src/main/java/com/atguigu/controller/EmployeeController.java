package com.atguigu.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.bean.Employee;
import com.atguigu.bean.Msg;
import com.atguigu.service.EmployeeService;
import com.fasterxml.jackson.annotation.JsonFormat.Value;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 处理员工crud请求
 * @author Administrator
 *
 */
@Controller
public class EmployeeController {
	
	
	@Autowired
	EmployeeService employeeService;
	
	/**
	 * 批量和单个删除
	 * @param ids
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	public Msg deleteEmpById(@PathVariable("ids")String ids){
		if(ids.contains("-")){
			//批量删除
			List<Integer> del_ids=new ArrayList<Integer>();
			String[] str_ids=ids.split("-");
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			employeeService.deleteBatch(del_ids);
		}else {
			//单个删除
			Integer id= Integer.parseInt(ids);
			employeeService.deleteEmpById(id);
		}
		return Msg.success();
	}
	
	
	/**
	 * 更新员工
	 * @param employee
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	public Msg updateEmp(Employee employee){
		employeeService.updateEmployee(employee);
		return Msg.success();
	}
	
	/**
	 * 根据id查询用户
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable Integer id){
		Employee employee= employeeService.getEmp(id);
		return Msg.success().add("emp",employee);
	}
	
	/**
	 * 校验用户名是否可用
	 * @param empName
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkUser")
	public Msg checkUser(String empName){
		//先判断用户名是否是合法的表达式
		String regx="(^[a-zA-Z0-9_-]{3,10}$)|(^[\u2E80-\u9FFF]{2,5})";
		if(!empName.matches(regx)){
			return Msg.fail().add("va_msg","用户名必须是6-16位数字和字母组成或者2-5位中文");
		}
		//用户名数据库重复校验
		boolean b=employeeService.checkUser(empName);
		if(b){
			return Msg.success();
		}else{
			return Msg.fail().add("va_msg","用户名已存在");
		}
	}
	
	/**
	 * 保存员工
	 * 后台进行数据校验 JSR303
	 * @param employee
	 * @return
	 */
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result){
		if(result.hasErrors()){
			//校验失败，在模态框中显示失败信息
			Map<String, Object> map=new HashMap<String, Object>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				map.put(fieldError.getField(),fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields",map);
		}else{
			employeeService.savaEmp(employee);
			return Msg.success();
		}
		
		
	}
	
	/**
	 * 查询员工数据（分页查询）
	 * 要导入Jackson支持
	 * @param pn
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody  //能将返回的数据自动地转为Jason数据
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn){
			  	//分页查询，引用pagehelper插件
				//在查询前，传入页码，每页的大小
				PageHelper.startPage(pn, 5);
				List<Employee> emps=employeeService.getAll();
				//使用pageinfo包装查询后的结果，封装了详细的信息
				//传入连续显示的页数
				PageInfo page=new PageInfo(emps,5);
				return Msg.success().add("pageInfo",page);
	}
	/**
	 * 查询员工数据（分页查询）
	 * @return
	 */
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model){
		//分页查询，引用pagehelper插件
		//在查询前，传入页码，每页的大小
		PageHelper.startPage(pn, 5);
		List<Employee> emps=employeeService.getAll();
		//使用pageinfo包装查询后的结果，封装了详细的信息
		//传入连续显示的页数
		
		PageInfo page=new PageInfo(emps,5);
		//把pageinfo提交给页面
		model.addAttribute("pageInfo",page);
		
		return "list";
	}
}
