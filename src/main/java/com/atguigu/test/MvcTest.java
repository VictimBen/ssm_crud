package com.atguigu.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.atguigu.bean.Employee;
import com.github.pagehelper.PageInfo;

/**
 * 使用spring测试模块中提供的测试请求功能，测试crud请求的正确性
 * 注意：spring4测试的时候，需要servlet3.0的支持
 * @author Administrator
 *
 */

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations={"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MvcTest {
	
	//传入springMVC的ioc
	@Autowired
	WebApplicationContext context;
	//虚拟的mvc请求,获取到处理结果
	MockMvc mockMvc;
	
	//初始化mockMvc
	@Before
	public void initMockMvc(){
		mockMvc=MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void testPage()throws Exception{
		System.out.println(1);
		//模拟请求拿到放回值
		MvcResult result=mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn","5")).andReturn();
		System.out.println(2);
		//请求成功后，请求域中会有pageInfo，取出pageInfo进行验证
		MockHttpServletRequest request = result.getRequest();
		System.out.println(3);
		PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
		System.out.println(4);
		System.out.println("当前页码："+pi.getPageNum());
		System.out.println("总页码"+pi.getPages());
		System.out.println("总记录数"+pi.getTotal());
		System.out.println("在页面需要连续显示的页码");
		int[] nums=pi.getNavigatepageNums();
		for(int i:nums){
			System.out.println(" "+i);
		}
		
		//获取员工数据
		List<Employee> list = pi.getList();
		for(Employee employees:list){
			System.out.println("ID"+employees.getEmpId()+"===姓名"+employees.getEmpName());
		}
	}
}
