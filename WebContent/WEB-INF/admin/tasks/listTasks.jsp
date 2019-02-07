<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@page import="java.util.List"%>
<%@page import="com.lch.struts.formBeans.admin.AdminTaskBean" %>

<script type="text/javascript" src="js/tinyMCE/js/tinymce/tinymce.min.js"></script>
<script type="text/javascript">
	tinymce
      .init(
	      {
	      selector : "textarea",
	      theme : "modern",
	      plugins :
		      [
		      "autolink lists link image charmap print preview hr anchor pagebreak", "searchreplace wordcount visualblocks visualchars code fullscreen", "insertdatetime media nonbreaking save table contextmenu directionality", "paste textcolor"
		      ],
	      toolbar1 : "styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image",
	      toolbar2 : "preview media | forecolor backcolor"
	      });
</script>

<div align="center">
	<c:choose>
		<c:when test="${errorMsg != null && errorMsg.length() > 0}">
			<c:out value="${errorMsg}"/>
			<br/>
		</c:when>
		<c:when test="${taskCount < 1}">
			There are no tasks yet.
			<br/>
		</c:when>
		<c:when test="${taskCount > 0}">
			<table>
				<tr>
					<th>Name</th>
					<th>Description</th>
					<th>Status</th>
					<th>Content</th>
					<th>Additional Details</th>
					<th>Attachment</th>
				</tr>
				<c:forEach items="${taskList}" var="task">
				<tr>
					<td><c:out value="${task.taskName}" /></td>
					<td><c:out value="${task.taskDescription}" /></td>
					<td><c:out value="${task.status}" /></td>
					<td><c:out value="${task.taskContent}" /></td>
					<td><c:out value="${task.additionalDetails}" /></td>
					<td>None</td>
				</tr>
				</c:forEach>
			</table>
		</c:when>
	</c:choose>
</div>