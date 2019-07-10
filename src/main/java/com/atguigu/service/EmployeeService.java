package com.atguigu.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.atguigu.bean.Employee;
import com.atguigu.bean.EmployeeExample;
import com.atguigu.bean.EmployeeExample.Criteria;
import com.atguigu.dao.EmployeeMapper;

@Service
public class EmployeeService {
	 
	/**
	 * 查询所有员工记录
	 */
	@Autowired
	EmployeeMapper employeeMapper;
	public List<Employee> getAll() {
		return employeeMapper.selectByExampleWithDept(null);
	}
	/**
	 * 保存员工
	 */
	public void savaEmp(Employee employee) {
		employeeMapper.insert(employee);
	}
	/**
	 * 校验用户名是否可用
	 * @param empName
	 * @return
	 */
	public boolean checkUser(String empName) {
		EmployeeExample example=new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count=employeeMapper.countByExample(example);
		return count==0;
	}
	/**
	 * 根据id查询用户
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		return employeeMapper.selectByPrimaryKey(id);
		
		
	}
	
	/**
	 * 有选择的更新员工（用户名不更新）
	 * @param employee
	 */
	public void updateEmployee( Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);
	}
	/**
	 * 根据id删除
	 * @param id
	 */
	public void deleteEmpById(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}
	/**
	 * 批量删除
	 * @param ids
	 */
	public void deleteBatch(List<Integer> ids) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		//delete from xxx where emp_id in(1,2,3);
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
	}

}
