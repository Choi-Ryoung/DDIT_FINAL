<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>


<div class="container-fluid">
	<div class="row">
		<div class="sidebar border border-right col-md-3 col-lg-2 p-0 bg-body-tertiary">
			<div class="offcanvas-md offcanvas-end bg-body-tertiary" tabindex="-1" id="sidebarMenu" aria-labelledby="sidebarMenuLabel">
				<div class="offcanvas-header">
					<h5 class="offcanvas-title" id="sidebarMenuLabel">H I T</h5>
					<button type="button" class="btn-close" data-bs-dismiss="offcanvas" data-bs-target="#sidebarMenu" aria-label="Close"></button>
				</div>
				<div class="offcanvas-body d-md-flex flex-column p-0 pt-lg-3 overflow-y-auto">
					<h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-1 mb-2 text-body-secondary text-uppercase">
						<strong><span>관리</span></strong>
					</h6>
					<ul class="nav flex-column mb-auto">
						<li class="nav-item">
							<a class="nav-link d-flex align-items-center gap-2" href="/admin/manage/memberManage">
								일반 회원 관리
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link d-flex align-items-center gap-2" href="/admin/manage/entMemberManage">
								기업 회원 관리
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link d-flex align-items-center gap-2" href="/admin/freeboardlist">
								커뮤니티 관리
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link d-flex align-items-center gap-2" href="/admin/mentolist">
								멘토 관리
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link d-flex align-items-center gap-2" href="/admin/manage/codingTestList">
								코딩테스트
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link d-flex align-items-center gap-2" href="/admin/manage/chart">
								통계 조회
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
