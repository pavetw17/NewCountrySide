/*			
	window.addEventListener(
    'load',
    function() {
        document.getElementById('ngay_batdau').addEventListener(
            'focus',
            function($e) {
                this.value = 'huyfocus';
            }, false
        );
        document.getElementById('ngay_batdau').addEventListener(
            'blur',
            function($e) 
            {
            	alert('Hello Baby');	
				var ngaybatdau = document.getElementById('ngay_batdau');
				var pattern = '/[0-9]{2}(\)[0-9]{2}(\)[0-9]{4}/g';
				if(pattern.test(ngaybatdau.value))
				{
					alert('Bạn đã nhập sai định dạng, mời bạn nhập lại với định dạng sau:dd/mm/yyyy;');
							
				}
            }, false
        );
        
    }, false
);
			
			
			function vld_ngaybatdau()
			{
				var reDate = /(?:0[1-9]|[12][0-9]|3[01])\/(?:0[1-9]|1[0-2])\/(?:19|20\d{2})/; 
				var ngaybatdau = document.getElementById("ngay_batdau");
				 if (reDate.test(ngaybatdau.value)) 
                 {
					 {return true;}
                 } else 
                 {
                	 {return false;}
                 }
				
			}
			*/
// hàm kiểm tra xâu rỗng

function kiemtrarong(truyen)
{
	if (truyen.match(/^s+$/) || truyen == "")
		{return true;}
	else
		{return false;}
}

// hàm kiểm tra ngày tháng
function ngaythang(truyen)
{
	if (truyen.match(/^(((0[1-9]|[12]\d|3[01])\/(0[13578]|1[02])\/((19|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)\/(0[13456789]|1[012])\/((19|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])\/02\/((19|[2-9]\d)\d{2}))|(29\/02\/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$/g))
		{return true;}
	else
		{return false;}
}
function isEmail(stremail)
{
 var filter=/^([a-zA-Z])+([a-zA-Z0-9_\-\.])+\@([a-zA-Z])+\.([a-zA-Z0-9]){2,4}$/;
if( filter.test( stremail ) !=true)
{
 return false;
}
else
{
return true;
}
}

String.prototype.endsWith = function(suffix) {
    return this.indexOf(suffix, this.length - suffix.length) !== -1;
};

function getContextPath() {
	   return window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
}
