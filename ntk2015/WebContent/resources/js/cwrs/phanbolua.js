/**
 * 
 * @param arrayruong
 * 		
 * @param arraylua
 * @returns
 */
function phanbo_lua(arrayruong, arraylua){

	  /* 
	   var arrayruong = [];
	   var arraygionglua = [];
	   var ruong = new ruong();
	   var lua = new lua();
	   arrayruong.push(ruong);
	   arraylua.push(lua);
	   */

	   var S = 0;//tong dien tich
	     for (var i = 0; i < arrayruong.length; i ++){
	    	 S += arrayruong[i].dientich;
	     }	    
	   // quy đổi diện tích từng thửa ruộng ra %
	     for (var i = 0; i <  arrayruong.length; i ++){
	    	 arrayruong[i].phantram = (arrayruong[i].dientich/S)*100;
	     }
	  
	   // Sắp xếp phần trăm các thửa ruộng theo thứ tự giảm dần
	     for (var i=0; i < arrayruong.length-1; i++) 
             for (var j =i+1 ; j< arrayruong.length; j++){
                 if (arrayruong[i].phantram<arrayruong[j].phantram){
               	  var tg = arrayruong[i];
               	  	  arrayruong[i] =  arrayruong[j];
               	  	  arrayruong[j] = tg;
                }
         }
	   
	  // Sắp xếp phần trăm giống lúa theo thứ tự giảm dần
	     for (var i=0; i < arraylua.length-1; i++) 
             for (var j =i+1 ; j< arraylua.length; j++){
                 if (arraylua[i].phantram<arraylua[j].phantram){

               	  var tg = arraylua[i];
               	  	  arraylua[i] =  arraylua[j];
               	  	  arraylua[j] = tg;

                }
         }
	     var tong = [];
	     for (var i=0; i < arraylua.length; i++) 
	      {
	          var min = 100;
	          for (var j = 0 ; j< arrayruong.length; j++)
	          if (Math.abs(arrayruong[j].phantram - arraylua[i].phantram)<min)
	          {
	              min = Math.abs(arrayruong[j].phantram - arraylua[i].phantram);
	              tong[i] = arrayruong[j].phantram;
	          };

	          for (var j = 0 ; j< arrayruong.length; j++)
	          if (arrayruong[j].phantram == tong[i])
	          {
	        	  arrayruong[j].gionglua = arraylua[i].id; 
	        	  arrayruong[j].phantram = 0;
	              break;
	          };
	      }
	 
	     for (var i=0; i < arraylua.length; i++) 
	    	 for (var j = 0 ; j< arrayruong.length; j++)

	          if (( (tong[i]+arrayruong[j].phantram)<=arraylua[i].phantram) &&(arrayruong[j].phantram!= 0) )

	             {
	                  tong[i] = tong[i]+arrayruong[j].phantram;
	                  arrayruong[j].gionglua = arraylua[i].id; 
		        	  arrayruong[j].phantram = 0;
	             };
	             
	     var luu = -1;
	    for (var j = 0 ; j< arrayruong.length; j++)
	     if (arrayruong[j].phantram!=0)
	        {
	             var min = 100;
	             for (var i=0; i < arraylua.length; i++) 

	             if (Math.abs((tong[i]+arrayruong[j].phantram)-arraylua[i].phantram) <= min) 

	             {
	                  luu=i ;  min = Math.abs((tong[i]+arrayruong[j].phantram)-arraylua[i].phantram);
	             }
	             arrayruong[j].gionglua = arraylua[luu].id; 
	        	 arrayruong[j].phantram = 0;
	        };
	    
	       // kết quả là arrayruong.gionglua lưu giá trị id của giống lúa tương ứng ruộng đó
		  //   for (var j = 0 ; j< arrayruong.length; j++){
		  //  	 alert("ruộng thứ "+ (arrayruong[j].id+1) + " trồng giống lúa "+arrayruong[j].gionglua);
		  //   }
	   return arrayruong;
}
