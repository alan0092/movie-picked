<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../../../resources/layout/taglib.jsp"%>
<%@ include file="../../../resources/jsp/remove.jsp"%>

<div>

	<h1>
	    ${user.name}
	</h1>

	<form:form commandName="user" id="profileForm" cssClass="form-horizontal profileForm">
		<label for="quote">
		    My Favorite Movie Quote
		</label>
		<form:input path="profile.code" id="profile" type="hidden" value="${user.profile.code}" />
		<form:input path="profile.quote" cssClass="form-control" id="quote" placeholder="Write your Favorite Movie Quote"
		    value="${user.profile.quote}" maxlength="50" autocomplete="off" disabled="true" />

		<div id="save" style="display: none;">
			<button type="button" class="btn btn-default btn-sm" onclick="saveQuote();">
				<span class="glyphicon glyphicon-floppy-disk"></span> 
				Save
			</button>
		</div>
	</form:form>

	<div id="edit" style="display: block;">
		<button type="button" class="btn btn-default btn-sm" onclick="editQuote();">
			<span class="glyphicon glyphicon-pencil"></span> 
			Edit
		</button>
	</div>

	<div id="divMessage" style="display: none; position: absolute; left: 110px;">
		<span id="message"></span>
	</div>
	
	<c:if test="${success eq true }">
		<div id="success" class="alert alert-success alert-dismissible">
			<a href="#" class="close" data-dismiss="alert" aria-label="close">
			   &times;
			 </a>
			Successful!
		</div>
	</c:if>
	<c:if test="${success eq false }">
		<div id="success" class="alert alert-danger alert-dismissible">
			<a href="#" class="close" data-dismiss="alert" aria-label="close">
			    &times;
			</a>
			Sorry! Something were wrong! Please try again later.
		</div>
	</c:if>

	<br><br>
	<h2>
	    Reviews
	</h2>
	<table class="table table-striped table-hover">
		<thead>
			<tr>
				<th>
				    Movie
				</th>
				<th>
				    Date
				</th>
				<th>
				    Title Comment
				</th>
				<th>
				    Comment
				 </th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${user.profile.review}" var="review">
				<tr>
					<td>
					    <a href="<spring:url value="/movie/${review.movie.code}.html" />">
						    <c:out value="${review.movie.title}" /> 
						    <font color="gray">
						        (<c:out value="${review.movie.year}" />)
						    </font>
					    </a>
					</td>
					<td>
					    <fmt:formatDate type="date" value="${review.publishedDate}" />
					</td>
					<td>
					    <b>
					        <c:out value="${review.title}" />
					    </b>
					</td>
					<td>
					    <c:out value="${review.comment}" />
					</td>
					<td>
						<button type="button" class="btn btn-primary" onclick="fillForm('${review.movie.code}',
						    '${review.movie.title}', '${review.code}', '${review.title}', '${review.comment}')">
						    Update Review
						</button>
					</td>
					<td>
					    <a href="<spring:url value="/profile/remove/${review.code}.html" />" 
					        class="btn btn-danger triggerRemove "> 
					        Remove Review 
					    </a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<div>
	    <form:form commandName="review" cssClass="form-horizontal movieForm">
		    <!-- Modal -->
		    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			    <div class="modal-dialog" role="document">
				    <div class="modal-content">
					    <div class="modal-header">
						    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
							    <span aria-hidden="true">
							        &times;
							     </span>
						    </button>
						    <h4 class="modal-title" id="myModalLabel">
						        Update Review
						     </h4>
					    </div>
					    <div class="modal-body">
						    <div class="form-group">
							    <input type="text" class="form-control input-sm" id="movie.title" name="movieTitle" readonly>
							    <br>
							    <form:input path="movie.code" type="hidden" id="movie.code" />
							    <form:input path="code" type="hidden" id="code" />
						     </div>
						    <div class="form-group">
							    <label for="title" class="col-sm-2 control-label">
							        Title:
							     </label>
							    <div class="col-sm-10">
								    <form:input path="title" cssClass="form-control" placeholder="Title" maxlength="50" 
								        id="title" autocomplete="off" />
								    <form:errors path="title" />
							    </div>
						    </div>
						    <div class="form-group">
							    <label for="comment" class="col-sm-2 control-label">
							        Comment:
							    </label>
							    <div class="col-sm-10">
								    <form:textarea path="comment" cssClass="form-control" placeholder="Comment" rows="3" 
								        maxlength="150" id="comment" autocomplete="off" />
								    <form:errors path="comment" />
							    </div>
						    </div>
					    </div>
					    <div class="modal-footer">
						    <button type="button" class="btn btn-default" data-dismiss="modal">
						        Close
						    </button>
						    <input type="submit" class="btn btn-primary" value="Update Review" />
					    </div>
				    </div>
			    </div>
		    </div>
	    </form:form>
	</div>
	
</div>

<script type="text/javascript">
	$(document).ready( function() {
	    $(".triggerRemove").click( function(e) {
		    e.preventDefault();
			$("#modalRemove .removeBtn").attr("href", $(this).attr("href"));
			$("#removeModalLabel").text("Remove Review");
			$("#confirmationMessage").text("Are you sure to delete this Review?");
			$("#modalRemove").modal();
		})
	});

	function fillForm(movieCode, movieTitle, reviewCode, reviewTitle, reviewComment) {
		document.getElementById("movie.code").value = movieCode;
		document.getElementById("movie.title").value = movieTitle;
		document.getElementById("code").value = reviewCode;
		document.getElementById("title").value = reviewTitle;
		document.getElementById("comment").value = reviewComment;
		$("#myModal").modal();
	}

	$(document).ready( function() {
	    $(".movieForm").validate({
		    rules : {
			    title : {
				    required : true,
					minlength : 3
				},
				comment : {
				    required : true,
					minlength : 5
				}
			},
			highlight : function(element) {
			    $(element).closest('.form-group').removeClass('has-success').addClass('has-error');
			},
			unhighlight : function(element) {
			    $(element).closest('.form-group').removeClass('has-error').addClass('has-success');
			}
		});
	})

	function editQuote() {
		document.getElementById("quote").disabled = false;
		document.getElementById("edit").style.display = 'none';
		document.getElementById("save").style.display = 'block';
	}

	function saveQuote() {
		var quote = document.getElementById("quote").value;
		if (quote != "") {
			document.getElementById("profileForm").submit();
			document.getElementById("quote").disabled = true;
			document.getElementById("save").style.display = 'none';
			document.getElementById("edit").style.display = 'block';
			document.getElementById("divMessage").style.display = 'none';
			document.getElementById("divMessage").removeAttribute("class");
			document.getElementById("message").textContent = "";
		} else {
			document.getElementById("message").textContent = "Quote cannot be Empty";
			document.getElementById("divMessage").className = 'alert alert-danger';
			document.getElementById("divMessage").style.display = 'block';
		}
	}
	
</script>
