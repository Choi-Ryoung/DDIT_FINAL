<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<style>
	/* 메뉴 배경 색상 */
    .bg-custom {
        background-color: cornflowerblue; /* 여기에 원하는 색상의 HEX 코드나 색상 이름을 사용하세요 */
    }
</style>

 
    <div id="sh_container"> 
        <div id="sh_container_wrapper">
            <div id="sh_content">
                <div id="greeting" class="pagecommon">
	                	<!-- 아래로 콘텐츠 추가  -->
						<div>
							<div class="bd-example">
						        <nav>
						          <div class="nav nav-tabs " id="nav-tab" role="tablist">
						            <button class="nav-link" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">기업리뷰</button>
						            <button class="nav-link active" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">면접후기</button>
						          </div>
						        </nav>
						     </div>
						</div> 
						<div class="row">
						    <div class="col-md-12">
						        <div class="card card-outline card-danger mt-4">
						            <div class="p-2 p-md-5 text-white rounded bg-custom">
						                <div class="col-md-12 px-0">
						                    <h1 class="display-5 fst-bold mb-2">메뉴 타이틀</h1><br>
						                    <p class="lead my-1">메뉴 소개 1</p>
						                </div>
						            </div>
						        </div>
						    </div>
						</div><hr>
						<hr>
						<div class="container mt-5 mb-3">
						    <div class="row">
						        <div class="col-md-4">
						            <div class="card p-3 mb-2">
						                <div class="d-flex justify-content-between">
						                    <div class="d-flex flex-row align-items-center">
						                        <div class="icon"> <i class="bx bxl-mailchimp"></i> </div>
						                        <div class="ms-2 c-details">
						                            <h6 class="mb-0">Mailchimp</h6> <span>1 days ago</span>
						                        </div>
						                    </div>
						                    <div class="badge"> <span>Design</span> </div>
						                </div>
						                <div class="mt-5">
						                    <h3 class="heading">Senior Product<br>Designer-Singapore</h3>
						                    <div class="mt-5">
						                        <div class="progress">
						                            <div class="progress-bar" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
						                        </div>
						                        <div class="mt-3"> <span class="text1">32 Applied <span class="text2">of 50 capacity</span></span> </div>
						                    </div>
						                </div>
						            </div>
						        </div>
						        <div class="col-md-4">
						            <div class="card p-3 mb-2">
						                <div class="d-flex justify-content-between">
						                    <div class="d-flex flex-row align-items-center">
						                        <div class="icon"> <i class="bx bxl-dribbble"></i> </div>
						                        <div class="ms-2 c-details">
						                            <h6 class="mb-0">Dribbble</h6> <span>4 days ago</span>
						                        </div>
						                    </div>
						                    <div class="badge"> <span>Product</span> </div>
						                </div>
						                <div class="mt-5">
						                    <h3 class="heading">Junior Product<br>Designer-Singapore</h3>
						                    <div class="mt-5">
						                        <div class="progress">
						                            <div class="progress-bar" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
						                        </div>
						                        <div class="mt-3"> <span class="text1">42 Applied <span class="text2">of 70 capacity</span></span> </div>
						                    </div>
						                </div>
						            </div>
						        </div>
						        <div class="col-md-4">
						            <div class="card p-3 mb-2">
						                <div class="d-flex justify-content-between">
						                    <div class="d-flex flex-row align-items-center">
						                        <div class="icon"> <i class="bx bxl-reddit"></i> </div>
						                        <div class="ms-2 c-details">
						                            <h6 class="mb-0">Reddit</h6> <span>2 days ago</span>
						                        </div>
						                    </div>
						                    <div class="badge"> <span>Design</span> </div>
						                </div>
						                <div class="mt-5">
						                    <h3 class="heading">Software Architect <br>Java - USA</h3>
						                    <div class="mt-5">
						                        <div class="progress">
						                            <div class="progress-bar" role="progressbar" style="width: 50%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
						                        </div>
						                        <div class="mt-3"> <span class="text1">52 Applied <span class="text2">of 100 capacity</span></span> </div>
						                    </div>
						                </div>
						            </div>
						        </div>
						    </div>
						</div>
						<div class="container">
						    <!-- Page Heading -->
						    <h1 class="my-4">Page Heading
						      <small>Secondary Text</small>
						    </h1>
						    
						    <hr>
						
						    <!-- Project Three -->
						    <div class="row">
						      <div class="col-md-2">
						        <a href="#">
						          <img class="img-fluid rounded mb-3 mb-md-0" src="https://via.placeholder.com/200x200" alt="">
						        </a>
						      </div>
						      <div class="col-md-10">
						        <h3>Project Three</h3>
						        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis, temporibus, dolores, at, praesentium ut unde repudiandae voluptatum</p>
						      </div>
						    </div>
						    <!-- /.row -->
						
						    <hr>
						
						    <!-- Project Four -->
						    <div class="row">
						
						      <div class="col-md-7">
						        <a href="#">
						          <img class="img-fluid rounded mb-3 mb-md-0" src="https://via.placeholder.com/700x300" alt="">
						        </a>
						      </div>
						      <div class="col-md-5">
						        <h3>Project Four</h3>
						        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Explicabo, quidem, consectetur, officia rem officiis illum aliquam perspiciatis aspernatur quod modi hic nemo qui soluta aut eius fugit quam in suscipit?</p>
						        <a class="btn btn-primary" href="#">View Project</a>
						      </div>
						    </div>
						    <!-- /.row -->
						
						    <hr>
						</div>
						<form class="row g-3">
						  <div class="col-md-6">
						    <label for="inputEmail4" class="form-label">Email</label>
						    <input type="email" class="form-control" id="inputEmail4">
						  </div>
						  <div class="col-md-6">
						    <label for="inputPassword4" class="form-label">Password</label>
						    <input type="password" class="form-control" id="inputPassword4">
						  </div>
						  <div class="col-12">
						    <label for="inputAddress" class="form-label">Address</label>
						    <input type="text" class="form-control" id="inputAddress" placeholder="1234 Main St">
						  </div>
						  <div class="col-12">
						    <label for="inputAddress2" class="form-label">Address 2</label>
						    <input type="text" class="form-control" id="inputAddress2" placeholder="Apartment, studio, or floor">
						  </div>
						  <div class="col-md-6">
						    <label for="inputCity" class="form-label">City</label>
						    <input type="text" class="form-control" id="inputCity">
						  </div>
						  <div class="col-md-4">
						    <label for="inputState" class="form-label">State</label>
						    <select id="inputState" class="form-select">
						      <option selected>Choose...</option>
						      <option>...</option>
						    </select>
						  </div>
						  <div class="col-md-2">
						    <label for="inputZip" class="form-label">Zip</label>
						    <input type="text" class="form-control" id="inputZip">
						  </div>
						  <div class="col-12">
						    <div class="form-check">
						      <input class="form-check-input" type="checkbox" id="gridCheck">
						      <label class="form-check-label" for="gridCheck">
						        Check me out
						      </label>
						    </div>
						  </div>
						  <div class="col-12">
						    <button type="submit" class="btn btn-primary">Sign in</button>
						  </div>
						</form>						
						
						
						
           	</div>
         </div>
      </div>
   </div>
