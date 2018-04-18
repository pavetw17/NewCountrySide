<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Login Page</title>
<link rel="stylesheet" type="text/css" href="css/login.css" />
<script type="text/javascript"	src="../resources/js/jquery-1.11.1.min.js"></script>
<style type="text/css">
.container_12, .container_16 {
  margin-left: auto;
  margin-right: auto;
  width: 960px;
}

.container_16 .suffix_5 {
  padding-right: 300px;
  padding-left: 300px;
  width: 340px;
}
</style>

<script type="text/javascript">
$(function() {
	  $('#txt_password').keyup(function(e) {
		 if(e.keyCode == 13) {
			 process();
		 }
	  });
	
	  $('#txt_username').keyup(function(e) {
			 if(e.keyCode == 13) {
				 process();
			 }
		  });
	  
      $(".black_button").click(function(){
    	  process();
	  });
      
      
      
});

	function process(){
		var username = $.trim($('#txt_username').val()) ;
  		var password = $.trim($('#txt_password').val()) ;
  		
  		if(kiemtra_dangnhap(username, password)){
  			$.ajax({ 
  			      type: "POST", 
  			      url:  '../DangNhap?action=01', 
  			      data: 'username='+ username + '&password=' + password, 
  			      dataType: "html",
  			      success: function(data) { 
  			    	  if (data == 0) { 
  			      		$('.error').html('<b style="color: red;">Sorry, unrecognized username or password!</b>');
  			      		$('#txt_username').val(""); 
  			      		$('#txt_password').val(""); 
  			      	  }else{
  			      		 document.location.href = data;
  			      	  } 
  			      }
  			     });
  			    return false;
  		}
	}	

	function kiemtra_dangnhap(a,b) {
		var valid = true, errorMessage = "";
		if (a == "") {
			errorMessage += "Username field is required.\n";
			valid = false;
		}

		if (b == "") {
			errorMessage += "Password field is required.\n";
			valid = false;
		}

		if (!valid && errorMessage.length > 0) {
			alert(errorMessage);
		}
		return valid;

	}
</script>

</head>
<body>
				<div class="container_16">
					<div class="grid_6 prefix_5 suffix_5">
						<h1>Login</h1>
						<div id="login">
						 <p class="error"></p>     
								<p>
									<label><strong>Username</strong> <input type="text"
										name="txt_username" class="inputText" id="txt_username" /> </label>
								</p>
								<p>
									<label><strong>Password</strong> <input type="password"
										name="txt_password" class="inputText" id="txt_password" /> </label>
								</p>
								<a class="black_button" ><span>Authentification</span></a>
							</form>
							<br clear="all" />
						</div>
						<div id="forgot">
							<a href="#" class="forgotlink"><span>Forgot your
									username or password?</span></a>
						</div>
					</div>
				</div>
				<br clear="all" />
</body>
</html>