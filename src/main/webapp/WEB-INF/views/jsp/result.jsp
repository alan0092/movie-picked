<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../../../resources/layout/taglib.jsp"%>

<div>

	<h1>Results</h1>

	<table class="table table-striped table-hover">
		<thead>
			<tr>
				<th>Movie</th>
				<th>Rating</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${movie}" var="movie">
				<tr>
					<td>
						<a href="<spring:url value="/movie/${movie.id}.html" />">
							${movie.title} <font color="gray">(${movie.year})</font>
						</a>
					</td>
					<td>${movie.rating}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

</div>