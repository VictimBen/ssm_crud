<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<!-- 员工编辑的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">员工编辑</h4>
      </div>
      <div class="modal-body">
      <!-- 表单列表 -->
        <form class="form-horizontal">
		  <div class="form-group">
		    <label  class="col-sm-2 control-label">empName</label>
		    <div class="col-sm-10">
		      <p class="form-control-static" id="empName_update_static"></p>
		    </div>
		  </div>
		  <div class="form-group">
		    <label  class="col-sm-2 control-label">email</label>
		    <div class="col-sm-10">
		      <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@atguigu.com">
		      <span  class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label  class="col-sm-2 control-label">gender</label>
				 <label class="radio-inline">
					 <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
				 </label>
				<label class="radio-inline">
				  <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
				</label>
		  </div>
		  <div class="form-group">
		    <label  class="col-sm-2 control-label">deptName</label>
		    	<div class="col-sm-4">
		    		<!-- 部门提交部门id即可，下拉项需从数据库中查 -->
					<select class="form-control" name="dId">
					</select>
		    	</div>
		  </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
      </div>
    </div>
  </div>
</div>


<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
      </div>
      <div class="modal-body">
      <!-- 表单列表 -->
        <form class="form-horizontal">
		  <div class="form-group">
		    <label  class="col-sm-2 control-label">empName</label>
		    <div class="col-sm-10">
		      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
		      <span  class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label  class="col-sm-2 control-label">email</label>
		    <div class="col-sm-10">
		      <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@atguigu.com">
		      <span  class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label  class="col-sm-2 control-label">gender</label>
				 <label class="radio-inline">
					 <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
				 </label>
				<label class="radio-inline">
				  <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
				</label>
		  </div>
		  <div class="form-group">
		    <label  class="col-sm-2 control-label">deptName</label>
		    	<div class="col-sm-4">
		    		<!-- 部门提交部门id即可，下拉项需从数据库中查 -->
					<select class="form-control" name="dId">
					</select>
		    	</div>
		  </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
      </div>
    </div>
  </div>
</div>

	<!-- 搭建显示页面 -->
	<!-- 标题 -->
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
	<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_addModal_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>
		</div>
	<!-- 表格 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all" />
							</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
					
				</table>
			</div>
		</div>
	<!-- 分页 -->
		<div class="row">
			<div class="col-md-12">
				<!-- 分页文字信息 -->
				<div class="col-md-6" id="page_info_area">
					
				</div>
				<!-- 分页条信息 -->
				<div class="col-md-6" id="page_nav_area">
					
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		
		var currentPage;
		//页面加载完成后，直接发送ajax请求，要到分页数据
		$(function(){
			to_page(1);
		});
		//发送ajax请求
		function to_page(pn){
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn="+pn,
				type:"GET",
				success:function(result){
					//console.log(result);
					//1、解析并显示员工数据
					build_emps_table(result);
					//2、解析并显示分页信息
					build_page_info(result);
					//3、解析并显示分页数据
					build_page_nav(result);
				}
				
			});
		}
		function build_emps_table(result){
			//	清空table表格数据
			$("#emps_table tbody").empty();
			var emps=result.extend.pageInfo.list;
			$.each(emps,function(index,item){
				var checkBoxTd=$("<td><input type='checkbox' class='check_item'></td>");
				var empIdTd=$("<td></td>").append(item.empId);
				var empNameTd=$("<td></td>").append(item.empName);
				var genderTd=$("<td></td>").append(item.gender=='M'?"男":"女");
				var emailTd=$("<td></td>").append(item.email);
				var deptNameTd=$("<td></td>").append(item.department.deptName);
				/*
					<button class="btn btn-primary btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									编辑
								</button>
				*/
				/*
					<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button>
				*/
				var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
								.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
				//为编辑按钮添加一个属性，来表示当前员工id
				editBtn.attr("edit-id",item.empId);
				var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
								.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
				//为删除按钮添加一个属性，来表示当前员工id
				delBtn.attr("del-id",item.empId);
				var btnTd=$("<td></td>").append(editBtn).append(" ").append(delBtn);
				$("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd)
						.append(genderTd).append(emailTd).append(deptNameTd).append(btnTd)
						.appendTo("#emps_table tbody");
			});
		
			
		}
		//解析显示分页信息
		function build_page_info(result){
			//清空数据
			$("#page_info_area").empty();
			$("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页,	总"+result.extend.pageInfo.pages+"页,	总"+result.extend.pageInfo.total+"条记录");
			currentPage=result.extend.pageInfo.pageNum;
			
			
		} 
		//解析显示分页条数据
		function build_page_nav(result){
			//清空数据
			$("#page_nav_area").empty();
			var ul=$("<ul></ul>").addClass("pagination");
			//构建元素
			var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
			if(result.extend.pageInfo.hasPreviousPage == false){
				//没有上一页了
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				//为元素添加点击翻页事件
				firstPageLi.click(function(){
					to_page(1);
				});
				prePageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum-1);
				});
			}
			//构建元素
			var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			if(result.extend.pageInfo.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				//为元素添加点击翻页事件
				nextPageLi.click(function(){
					to_page(result.extend.pageInfo.pageNum+1);
				});
				lastPageLi.click(function(){
					to_page(result.extend.pageInfo.pages);
					
				});
			}
			
			//首页和上一页
			ul.append(firstPageLi).append(prePageLi);
			//构建分页
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				var numLi=$("<li></li>").append($("<a></a>").append(item));
				if(result.extend.pageInfo.pageNum == item){
					//在当前页，高亮显示
					numLi.addClass("active");
				}
				//点击翻页
				numLi.click(function(){
					to_page(item);
				});
				ul.append(numLi);
			});
			//末页和下一页
			ul.append(nextPageLi).append(lastPageLi);
			var navEle=$("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
		//清空表单
		function reset_form(ele){
			//清空数据
			$(ele)[0].reset();
			//清空样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		//点击新增按钮
		$("#emp_addModal_btn").click(function(){
			//清除表单
			reset_form("#empAddModal form");
			//发送ajax请求，查出部门信息，显示在下拉列表中
			getDepts("#empAddModal select");
			//点击弹出模态框
			$("#empAddModal").modal({
				backdrop:"static"
			});
		})
		//查出所有部门信息并显示在下拉列表中
		function getDepts(ele){
			//清空数据
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					$.each(result.extend.depts,function(){
						var optionEle=$("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo(ele);
					});

				}
			});
		}
		//前端校验数据
		function validate_add_form(){
			//拿到要校验的数据，使用正则表达式
			var empName=$("#empName_add_input").val();
			var regName=/(^[a-zA-Z0-9_-]{3,10}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(!regName.test(empName)){
				//alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
				show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或者6-16位英文和数字的组合");
				return false;
			}else{
				show_validate_msg("#empName_add_input","success","");
			}
			var email=$("#email_add_input").val();
			var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				//alert("邮箱格式不正确");
				show_validate_msg("#email_add_input","error","邮箱格式不正确");
				return false;
			}else{
				show_validate_msg("#email_add_input","success","");
			}
			return true;
			
		}
		//显示校验结果的提示信息
		function show_validate_msg(ele,status,msg){
			//清除当前元素的校验状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success"==status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error"==status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
			
		}
		//校验用户名是否存在
		$("#empName_add_input").change(function(){
					//发送ajax请求
				var empName=this.value;
					$.ajax({
						url:"${APP_PATH}/checkUser",
						type:"POST",
						data:"empName="+empName,
						success:function(result){
							if(result.code==100){
								show_validate_msg("#empName_add_input","success","用户名可用");
								$("#emp_save_btn").attr("btn-validate","success");
							}else{
								show_validate_msg("#empName_add_input","error",result.extend.va_msg);
								$("#emp_save_btn").attr("btn-validate","error");
							}
						}
					});
					
		});
		//点击保存，保存员工信息
		$("#emp_save_btn").click(function(){
			//模拟框中提交的表单数据提交给服务器进行保存
			//对要提交服务器的数据进行校验
			if(!validate_add_form()){
				return false;
			}
			//判断之前的用户名校验是否成功
			if($(this).attr("btn-validate")=="error"){
				return false;
			}
			//发送ajax请求保存员工
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result){
					if(result.code==100){
						//员工保存成功后，关闭模块框
						$("#empAddModal").modal('hide');
						//来到最后一页，查看保存数据
						//发送ajax请求，显示最后一页数据
						to_page(999);
					}else{
						//显示失败信息
						if(undefined!=result.extend.errorFields.email){
							//显示邮箱的错误信息
							show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
						}
						if(undefined!=result.extend.errorFields.empName){
							//显示用户名的错误信息
							show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
							
						}
					}
					
					
				}
			});
			
		});
		
		//给编辑按钮绑定点击事件
		$(document).on("click",".edit_btn",function(){
			//查询部门信息
			getDepts("#empUpdateModal select");
			//根据id查出员工信息
			getEmp($(this).attr("edit-id"));
			//将员工id传递给模态框的更新按钮
			$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
			//点击弹出模态框
			$("#empUpdateModal").modal({
				backdrop:"static"
			});
		});
		//给单个删除按钮绑定点击事件
		$(document).on("click",".delete_btn",function(){
			//弹出确认删除对话框
			var empName=$(this).parents("tr").find("td:eq(2)").text();
			var empId= $(this).attr("del-id");
			if(confirm("确认删除【"+empName+"】吗？")){
				$.ajax({
					url:"${APP_PATH}/emp/"+empId,
					type:"DELETE",
					success:function(result){
						to_page(currentPage);
					}
				});
			}
			
		});
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					var empData=result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
				}
				
			});
		}
		//点击修改按钮，执行保存操作
		$("#emp_update_btn").click(function(result){
			//校验邮箱格式是否合法
			var email=$("#email_update_input").val();
			var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				//alert("邮箱格式不正确");
				show_validate_msg("#email_update_input","error","邮箱格式不正确");
				return false;
				
			}else{
				show_validate_msg("#email_update_input","success","");
			}
			
				//发送ajax请求
				$.ajax({
					url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
					type:"POST",
					data:$("#empUpdateModal form").serialize()+"&_method=PUT",
					success:function(result){
						//关闭对话框
						$("#empUpdateModal").modal("hide");
						//回到本页面
						to_page(currentPage);
					}
				});
		});
		//全选或者全不选功能
		$("#check_all").click(function(){
			//注意：用prop修改dom原生的属性，attr获取自定义的属性
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		//单个复选框全部选上
		$(document).on("click",".check_item",function(){
			//判断当前元素是否选满
			var flag=$(".check_item:checked").length==$(".check_item").length;
			$("#check_all").prop("checked",flag);
		});
		//点击删除，批量删除
		$("#emp_delete_all_btn").click(function(){
			var empNames="";
			var del_idstr="";
			$.each($(".check_item:checked"),function(){
				//组装员工姓名字符串
				empNames +=$(this).parents("tr").find("td:eq(2)").text()+",";
				//组装员工id字符串
				del_idstr +=$(this).parents("tr").find("td:eq(1)").text()+"-";
				
			});
			//去除empNames多余 的逗号
			empNames=empNames.substring(0,empNames.length-1);
			//去除员工id多余 的“-”
			del_idstr=del_idstr.substring(0,del_idstr.length-1);
			if(confirm("确认删除【"+empNames+"】吗？")){
				//发ajax请求
				$.ajax({
					url:"${APP_PATH}/emp/"+del_idstr,
					type:"DELETE",
					success:function(result){
						to_page(currentPage);
					}
					
				});
			}
		});
			
		
	</script>

</body>
</html>