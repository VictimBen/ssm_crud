package com.atguigu.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.atguigu.bean.Department;
import com.atguigu.bean.Employee;
import com.atguigu.dao.DepartmentMapper;
import com.atguigu.dao.EmployeeMapper;

/**
 * 
 * 测试dao层的工作
 * @author Administrator
 *使用spring的单元测试，可以自动的注入我们需要的组件
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {
	
	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
		
	@Autowired
	SqlSession sqlSession;
	
	/**
	 * 测试DepartmentMapper
	 * 
	 */
	@Test
	public void testDept(){
		
		//插入部门
//		departmentMapper.insertSelective(new Department(null,"开发部"));
//		departmentMapper.insertSelective(new Department(null,"测试部"));
		
		//插入员工
		//employeeMapper.insertSelective(new Employee(null,"tom","m","tom@atguigu.com",2));
		
		//批量插入
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i = 0;i<1000;i++){
			String uid = UUID.randomUUID().toString().substring(0,5)+i;
			mapper.insertSelective(new Employee(null,uid, "M", uid+"@atguigu.com", 1));
		}
		System.out.println("批量完成");
		
		
	}
}
