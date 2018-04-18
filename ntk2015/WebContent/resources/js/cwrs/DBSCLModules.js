
function CCWRS_Report_BuildGraph(){
	this.chart=null; 
	this.chartType='line'; 
	this.showLabelOnLine=false;//hient thi gia tri tai cac diem tren do thi
	this.bAllDbscl = false;
}
CCWRS_Report_BuildGraph.prototype = {
		info:function(){
			alert('Report Build Graph version 1.0');
		},
		onLoad:function(){
			this.registerEvents();
		    $('#dlg_main_graph_gieocaythuhoach').show();
			$('#dlg_main_graph_dichhai').hide();
			$("#reportgraph_labelloai_mds_tlb_dtn").text("Sâu hại");
	 		gm.cbb.load(ACT_GET_SAUHAI_TO_CBB, 'report_graph_cbloai_mds_tlb_dtn','-Danh sách sâu hại-', TYPE_DATA_HTML_CBB);
	 		
	 		var nowDate=new Date();
	 		$("#reportgraph_mds_tlb_dtn_datebox2").datebox("setValue",gm.date.date2String(nowDate));
	 		var dateStringFrom=gm.date.Int2DateString((gm.date.date2Int(nowDate)-30));
	 		
	 		
	 		$("#reportgraph_mds_tlb_dtn_datebox1").datebox("setValue",dateStringFrom);
	 		
	 		var currTime=gm.date.getCurrentTime();
	 		$('#report_graph_txtdate').val(currTime.day+"/"+currTime.month);
	 		//load theme
	 		gm.loadScript("components/charts/highcharts/themes/dark-blue.js");
		},
		
		/**
		 * Đăng ký xử lý sự kiện vd onchange của combobox, click của radio...
		 */
		registerEvents:function(){
			//onchange combobox 
			$("#dlg_main_graph_cbgionglua").change(function() {  
			    
			});
			/*$("#dlg_main_graph_cbvulua").change(function(val) {  
				var vuid=$(this).val();
			    if (vuid==VU_DX){
			    	 gm.cbb.setNumber("dlg_main_graph_cbthang",ASC,1,5,"*");
			    }else{
			    	 gm.cbb.setNumber("dlg_main_graph_cbthang",ASC,1,12,"*");
			    }
			});*/
			/*$("#dlg_main_graph_cbthang").change(function() {  
			    
			});*/
			$("#dlg_main_graph_cbnam1").change(function() {  
			    
			});
			$("#dlg_main_graph_cbnam2").change(function() {  
			    
			});
			
			//attack a click event on all radio buttons with name 'dlg_main_graph_radio'
			$("input[name=dlg_main_graph_radio]:radio").click(function() {
				 switch($(this).val()){
				 	case "1"://dt xuong giong
				 	case "2"://dt thu hoach
				 	case "3"://san luong thu hoach
				 		$('#dlg_main_graph_gieocaythuhoach').show();
				 		$('#dlg_main_graph_dichhai').hide();
				 		break;
				 	case "4"://mat do sau-ty le benh-dien tich nhiem
				 		$('#dlg_main_graph_gieocaythuhoach').hide();
				 		$('#dlg_main_graph_dichhai').show();
				 		break;
				 	case "5"://dien tich lua (vien tham)
				 	case "6"://dien tich lua (vien tham)
				 		$('#dlg_main_graph_gieocaythuhoach').show();
				 		$('#dlg_main_graph_dichhai').hide();
				 		//$("#dlg_main_graph_cbvulua").hide();
				 		break;
				 }
			});
			
			//FOR OPTION: Mat do sau-Ty le benh-dien tich nhiem
			$("#report_graph_cbsosanh_mds_tlb_dtn").change(function() {  
				 switch($(this).val()){
				 	case "1"://mds
				 	//	$("#reportgraph_labelloai_mds_tlb_dtn").text("Sâu hại");
				 		gm.cbb.load(ACT_GET_SAUHAI_TO_CBB, 'report_graph_cbloai_mds_tlb_dtn','-Danh sách sâu hại-', TYPE_DATA_HTML_CBB);
				 		break;
				 	case "2"://ty le benh
				 	//	$("#reportgraph_labelloai_mds_tlb_dtn").text("Bệnh hại");
				 		gm.cbb.load(ACT_GET_BENHHAI_TO_CBB, 'report_graph_cbloai_mds_tlb_dtn','-Danh sách bệnh hại-', TYPE_DATA_HTML_CBB);
				 		break;
				 	case "3":
				 	//	$("#reportgraph_labelloai_mds_tlb_dtn").text("Dịch hại");
						gm.cbb.load(ACT_GET_SAUHAI_TO_CBB, 'report_graph_cbloai_mds_tlb_dtn','Danh sách sâu hại', TYPE_DATA_HTML_CBB,null,'0o','-');
						gm.cbb.load(ACT_GET_BENHHAI_TO_CBB, 'report_graph_cbloai_mds_tlb_dtn','Danh sách bệnh hại', TYPE_DATA_HTML_CBB,null,'1o','-',true);
				 		break;
				 }
			});
			$("#reportgraph_img_previous").click( function(){
				//get offset day
				var strDate1=$("#reportgraph_mds_tlb_dtn_datebox1").datebox("getValue");
				var strDate2=$("#reportgraph_mds_tlb_dtn_datebox2").datebox("getValue");
				
				var t1=gm.date.stringDate2Int(strDate1);
				var t2=gm.date.stringDate2Int(strDate2);
				
				var offsetDay=t2-t1;

				$("#reportgraph_mds_tlb_dtn_datebox2").datebox("setValue",strDate1);
				$("#reportgraph_mds_tlb_dtn_datebox1").datebox("setValue",gm.date.Int2DateString(t1-offsetDay));
				gm.report.graph.onClickBuildGraph();
			});
			$("#reportgraph_img_next").click( function(){
				var strDate1=$("#reportgraph_mds_tlb_dtn_datebox1").datebox("getValue");
				var strDate2=$("#reportgraph_mds_tlb_dtn_datebox2").datebox("getValue");
				
				var t1=gm.date.stringDate2Int(strDate1);
				var t2=gm.date.stringDate2Int(strDate2);
				var offsetDay=t2-t1;
				
				$("#reportgraph_mds_tlb_dtn_datebox1").datebox("setValue",strDate2);
				$("#reportgraph_mds_tlb_dtn_datebox2").datebox("setValue",gm.date.Int2DateString(t2+offsetDay));
				gm.report.graph.onClickBuildGraph();
			});
			//Fires khi user chọn date
			$('#reportgraph_mds_tlb_dtn_datebox1').datebox({  
			    required:false ,
			    onSelect: function(date) {
			    	//alert(date);
			    }
			});
			$('#reportgraph_mds_tlb_dtn_datebox2').datebox({  
			    required:false ,
			    onSelect: function(date) {
			    	//alert(date);
			    }
			});
			
			
			//OnClick Build Graph
			$('#report_btn_buildgraph').click(function(){ 
				gm.report.graph.onClickBuildGraph();
            });
			$('#report_btn_buildgraph_close').click(function(){ 
				gm.report.hide();
            });
			
			
			//Theme
			$("#report_graph_cbtheme").change(function() {  
				 switch($(this).val()){
				 	case '1'://nền xanh nước biển-gam màu tối
				 		gm.loadScript("components/charts/highcharts/themes/dark-blue.js",
				 		function(){
				 			gm.report.graph.onClickBuildGraph();
				 		}		
				 		);
				 		break;
				 	case '2'://nền đen-gam màu tối
				 		gm.loadScript("components/charts/highcharts/themes/gray.js",
				 		function(){
				 			
				 			gm.report.graph.onClickBuildGraph();
				 		}		
				 		);
				 		
				 		break;
				 	case '3'://nền đen-gam màu tối
				 		gm.loadScript("components/charts/highcharts/themes/dark-green.js",
				 		function(){
				 			gm.report.graph.onClickBuildGraph();
				 		}		
				 		);
				 		break;
				 	case '4'://nền đen-gam màu tối
				 		gm.loadScript("components/charts/highcharts/themes/grid.js",
				 		function(){
				 			gm.report.graph.onClickBuildGraph();
				 		}		
				 		);
				 		break;
				 }
			});
			//Onchange chart type
			$("#report_graph_cbchartyype").change(function() {  
				 switch($(this).val()){
				 	case '1'://line
				 		gm.report.graph.chartType='line';
				 		$("#report_graph_chkboxshowlabel").attr('checked',false);
				 		$("#report_graph_chkboxshowlabel").show();
				 		$("#report_graph_lbshowlabel").show();
				 		
				 		//$("#report_graph_chkboxshowlabel").attr('disabled',false);
				 		
				 		gm.report.graph.onClickBuildGraph();
				 		break;
				 	case '2'://spline
				 		gm.report.graph.chartType='spline';
				 		$("#report_graph_chkboxshowlabel").attr('checked',false);
				 		$("#report_graph_chkboxshowlabel").hide();
				 		$("#report_graph_lbshowlabel").hide();//câu: hiện thị giá trị...
				 		
				 		//$("#report_graph_chkboxshowlabel").attr('disabled',true);
				 		gm.report.graph.onClickBuildGraph();
				 		
				 		break;
				 }
			});
			
			//onchange checkbox show label on graph
			$("#report_graph_chkboxshowlabel").change(function(){
		        if($(this).attr("checked"))
		        {
		        	gm.report.graph.showLabelOnLine=true;
		        	gm.report.graph.onClickBuildGraph();
		        }
		        else
		        {
		        	gm.report.graph.showLabelOnLine=false;
		        	gm.report.graph.onClickBuildGraph();
		        }
		    });
			

		},
		/**
		 * @isShowDebug
		 * 		set true nếu muốn hiện thị thông tin debug
		 * @returns Trả về JSON object gồm các trường:
		 *  - {json}.gionglua_id
		 *  - {json}.vulua_id
		 *  - {json}.month
		 *  - {json}.year_from
		 *  - {json}.year_to
		 *  - {json}.desc Diễn tả tùy chọn
		 *  - {json}.option
		 *  
		 */
		getOptionsContent:function(isShowDebug){
			 var content='Bạn đang xây dựng đồ thị so sánh ';
			 var gl=0;
			 var vuid=0;
			 var toDate=0;
			 var nam_from=0;
			 var nam_to=0;
			 var offset_time_int1=0;
			 var offset_time_int2=0;
			 var option=0;
			 var time_series_int1="";
			 var time_series_int2="";
			 var year_series="";
			 
			 var time_int1=0;
			 var time_int2=0;
			 var type_mds_tlb_dtn=0;
			 var sau_id=0;
			 var benh_id=0;
			 var hasError=false;
			 var strDOY = 0;
			 hasError=false;
			// -Bạn xây dựng đồ thị so sánh diện tích gieo cấy giống  A của vụ đông xuân đến tháng 5 trong N năm lien tục (2002 đến 2012).
			 var type= $('input:radio[name=dlg_main_graph_radio]:checked').val();
			 if(type == '1'||type == '2'||type == '3' || type=='5' || type== '6'){//dt+sanluong xuong giong,thu hoach
				 hasError=true;
				 //msginfo("Để xây dựng đồ thị so sánh bạn cần có số liệu của ít nhất 2 năm")
				//  return null;
				 gl=getCbbValue('dlg_main_graph_cbgionglua');
				 vuid=getCbbValue('dlg_main_graph_cbvulua');
				// alert(gionglua_id)
				 
				 toDate=$('#report_graph_txtdate').val();
				 toDate=toDate.trim();
				 
				 
				 if(vuid==-1 && type !=5 && type!=6){
					 msginfo("Hãy chọn vụ lúa.");
					 return;
				 }
				 if(!gm.date.isValidateDMY(toDate+'/2012')){
					 msgerror(toDate+" không đúng định dạng ngày/tháng. Bạn cần nhập chẳng hạn 15/06");
					 return;
				 }

				
				var jsDate = gm.date.stringToJSONDate(toDate+'/2012', g_dfDefault);
				if (Utils.isValidateDMY(toDate+'/2012'))
				{
					strDOY = jsDate.doy;
				}	

					
				
				 nam_from=getCbbValue('dlg_main_graph_cbnam1');
				 nam_to=getCbbValue('dlg_main_graph_cbnam2');
		         	if(type == '1') {
		         		content+='diện tích gieo cấy';
		         		option=1;
		         	} else if(type == '2') {
		         		content+='diện tích thu hoạch';
		         		option=2;
		         	} else if(type == '3') {
		         		content+='sản lượng thu hoạch';
		         		option=3;
		         	} else if(type == '5') {
		         		content+='diện tích lúa(VT)';
		         		option=5;
		         	} else if(type == '6') {
		         		content+='diện tích gieo trồng(VT)';
		         		option=6;
		         		if(strDOY <=0)
		         		{
		         			msgerror('Hãy chọn thời gian ');
		         			return;
		         		}
					
		         	}else {
		        	
		         	}
		         	if (gl!=-1)content+=' giống ' +getCbbText('dlg_main_graph_cbgionglua');
		         	//else content+='( tất cả các giống) ';
		      
		         	if (vuid!=-1)content+=' của vụ ' +getCbbText('dlg_main_graph_cbvulua');
		         	//else content+='( tất cả các vụ) ';
		      
		         	if (toDate!="")content+=' tính đến ' + toDate;
		     
		         	if (nam_from!=-1)content+=' trong ' + (parseInt(nam_to)-parseInt(nam_from)+1)+' năm liên tục('+nam_from+' đến '+nam_to+').';
		         	//strJson = '{\"gionglua_id\":'+ gl +',\"vulua_id\":'+vuid+',\"month\":'+month+',\"year_from\":'+nam_from+',\"year_to\":'+nam_to+',\"desc\":'+"\""+content+"\""+',\"option\":'+option+'}';
		         	var toMonth=gm.date.stringToJSONDate(toDate+"/2012");
		         	var arrayTime1=[];
		         	var arrayTime2=[];
		         	var arrayYears=[];
		         	if(vuid==VU_DX){
		         		for(var i=parseInt(nam_from)-1;i<parseInt(nam_to)+1;i++){
		         			    offset_time_int1="01/09"+"/"+i;
		         			   //alert(toDate+"/2012")
		         			    var _toDate=gm.date.stringToJSONDate(toDate+"/2012");
		         			    if(_toDate.month>=9 && _toDate.month<=12) 
		         				    offset_time_int2= toDate+"/"+i;
		         			    else 
		         			    	offset_time_int2= toDate+"/"+(i+1);
		         			    
		         			  arrayTime1.push(gm.date.stringDate2Int(offset_time_int1));
		         			  arrayTime2.push(gm.date.stringDate2Int(offset_time_int2));
		         			  arrayYears.push(i);
		         			}
		         	}else {
		         		for(var i=parseInt(nam_from);i<parseInt(nam_to)+1;i++){
	         			    offset_time_int1="01/01"+"/"+i;
	         			    //var _toDate=gm.date.stringToJSONDate(toDate+"/2012");
	         			    //gm.date.getDaysInMonth(12, i)+"/12/"+i;
	         			    offset_time_int2= toDate+"/"+(i);
		         			  arrayTime1.push(gm.date.stringDate2Int(offset_time_int1));
		         			  arrayTime2.push(gm.date.stringDate2Int(offset_time_int2));
		         			 arrayYears.push(i);
	         			}
	         		}
		         	
		         	time_series_int1=gm.utils.createStringWithSeparator(arrayTime1, ',');
		         	time_series_int2=gm.utils.createStringWithSeparator(arrayTime2, ',');
		         	year_series=gm.utils.createStringWithSeparator(arrayYears, ',');
		         	
		 
			 } else if (type=='4'){//mds-tlb-dtn
				 	option=4;
					var strDate1=$("#reportgraph_mds_tlb_dtn_datebox1").datebox("getValue");
					var strDate2=$("#reportgraph_mds_tlb_dtn_datebox2").datebox("getValue");

				 	time_int1=gm.date.stringDate2Int(strDate1);
				    time_int2=gm.date.stringDate2Int(strDate2);
				    type_mds_tlb_dtn=gm.cbb.getValue("report_graph_cbsosanh_mds_tlb_dtn");	
				    
				    
				    if(type_mds_tlb_dtn==1){//mat do sau
				    	sau_id=gm.cbb.getValue("report_graph_cbloai_mds_tlb_dtn");
				    	//alert("ss1")
				    }else if(type_mds_tlb_dtn==2){//ty le benh
				    	//alert("ss2")
				    	benh_id=gm.cbb.getValue("report_graph_cbloai_mds_tlb_dtn");
				    } if(type_mds_tlb_dtn==3){//dien tich nhiem
				    	//alert("ss3")
				    	var	sau_or_benh_id=gm.cbb.getValueDTN("report_graph_cbloai_mds_tlb_dtn");
				    	sau_id=sau_or_benh_id.sau_id;
				    	benh_id=sau_or_benh_id.benh_id;
				    }
				    //strJson = '{\"time_int1\":'+ time_int1 +',\"time_int2\":'+time_int2+',\"type_mds_tlb_dtn\":'+type_mds_tlb_dtn+',\"sau_id\":'+sau_id+',\"benh_id\":'+benh_id+'}';
			 }
			// alert(gl)
		  	var jso= gm.utils.createJSONObject({
		  		option:type,
		  		gionglua_id: gl,
		  		vulua_id: vuid,
		  		todate: toDate,
		  		time_series_int1: time_series_int1,
		  		time_series_int2: time_series_int2,
		  		year_series:year_series,
		  		desc: content,
		  		option: option,
		  		
		  		time_int1: time_int1,
		  		time_int2: time_int2,
		  		type_mds_tlb_dtn: type_mds_tlb_dtn,
		  		sau_id: sau_id,
		  		benh_id: benh_id,
		  		error:hasError,
		  		doy:strDOY

		  	 },isShowDebug);
		  	 return jso;
		},
		getOptionsContentFromPaneVientham:function(isShowDebug)
		{
			 var content='Bạn đang xây dựng đồ thị so sánh ';
			 var vuid=0;
			 var toDate=0;
			 var nam_from=0;
			 var nam_to=0;
			 var offset_time_int1=0;
			 var offset_time_int2=0;
			 var option=0;
			 var time_series_int1="";
			 var time_series_int2="";
			 var year_series="";
			 var doy_series="";
			 var doy1610_series="";
			 var doy3112_series="";
			 
			 var time_int1=0;
			 var time_int2=0;
			 var hasError=false;
			 var strDOY = 0;
			 hasError=false;
			// -Bạn xây dựng đồ thị so sánh diện tích gieo cấy giống  A của vụ đông xuân đến tháng 5 trong N năm lien tục (2002 đến 2012).
			 var type= $('input:radio[name=rs_graph_options]:checked').val();
			 
			 if(type=='10' || type== '11'){//dt+sanluong xuong giong,thu hoach
				// hasError=true;
				 //msginfo("Để xây dựng đồ thị so sánh bạn cần có số liệu của ít nhất 2 năm")
				//  return null;
				 vuid=getCbbValue('dlg_rs_graph_cbvu');
				// alert(gionglua_id)
				 
				 toDate=$('#rs_graph_txtdate').val();
				 toDate=toDate.trim();
				 
				 
				 if(vuid==-1 && type !=10 && type!=11){
					 msginfo("Hãy chọn vụ lúa.");
					 return;
				 }
				 if(!gm.date.isValidateDMY(toDate+'/2012')){
					 msgerror(toDate+" không đúng định dạng ngày/tháng. Bạn cần nhập chẳng hạn 15/06");
					 return;
				 }

				
				var jsDate = gm.date.stringToJSONDate(toDate+'/2012', g_dfDefault);
				if (Utils.isValidateDMY(toDate+'/2012'))
				{
					strDOY = jsDate.doy;
				}	

					
				
				 nam_from=getCbbValue('dlg_rs_graph_cbnam1');
				 nam_to=getCbbValue('dlg_rs_graph_cbnam2');
		            if(type == '10') {
		         		content+='diện tích lúa(VT)';
		         		option=10;
		         	} else if(type == '11') {
		         		content+='diện tích gieo trồng(VT)';
		         		option=11;
		         		if(strDOY <=0)
		         		{
		         			msgerror('Hãy chọn thời gian ');
		         			return;
		         		}
					
		         	}else {
		        	
		         	}
				      
		         	if (vuid!=-1)content+=' của vụ ' +getCbbText('dlg_rs_graph_cbvu');
		         	//else content+='( tất cả các vụ) ';
		      
		         	if (toDate!="")content+=' tính đến ' + toDate;
		     
		         	if (nam_from!=-1)content+=' trong ' + (parseInt(nam_to)-parseInt(nam_from)+1)+' năm liên tục('+nam_from+' đến '+nam_to+').';
		         	//strJson = '{\"gionglua_id\":'+ gl +',\"vulua_id\":'+vuid+',\"month\":'+month+',\"year_from\":'+nam_from+',\"year_to\":'+nam_to+',\"desc\":'+"\""+content+"\""+',\"option\":'+option+'}';
		         	//var toMonth=gm.date.stringToJSONDate(toDate+"/2012");
		         	//var toMonth10=gm.date.stringToJSONDate("01/10/2012");
		         	var arrayTime1=[];
		         	var arrayTime2=[];
		         	var arrayYears=[];
		         	var arrayDOY=[];
		         	var arrayDOY1610=[];
		         	var arrayDOY3112=[];
		         	if(vuid==VU_DX){
		         		if(type==10)//dien tich lua
		         		{
		         			for(var i=parseInt(nam_from);i<parseInt(nam_to)+1;i++){
		         				  var _toDate=gm.date.stringToJSONDate(toDate+"/"+i);
			         			  arrayDOY.push(parseInt(_toDate.doy));
		         			    offset_time_int1="01/01"+"/"+i;
		         			    //var _toDate=gm.date.stringToJSONDate(toDate+"/2012");
		         			    //gm.date.getDaysInMonth(12, i)+"/12/"+i;
		         			    offset_time_int2= toDate+"/"+(i);
			         			  arrayTime1.push(gm.date.stringDate2Int(offset_time_int1));
			         			  arrayTime2.push(gm.date.stringDate2Int(offset_time_int2));
			         			 arrayYears.push(i);
		         			}
		         		} else {//tien do gieo trong
		         		for(var i=parseInt(nam_from);i<parseInt(nam_to)+1;i++){
		         			    offset_time_int1="01/09"+"/"+i;
		         			   //alert(toDate+"/2012")
		         			  var _toDate=gm.date.stringToJSONDate(toDate+"/"+i);
		         			  arrayDOY.push(parseInt(_toDate.doy));
		         			  
		         			//  alert(_toDate1610.doy + ','+_toDate3112.doy );
		         			   // if(_toDate.month>9 && _toDate.month<=12) 
		         			 var _toDate1610 = gm.date.stringToJSONDate("16/10/"+i);
		         			  var _toDate3112 = gm.date.stringToJSONDate("31/12/"+i);
		         			 arrayDOY1610.push(parseInt(_toDate1610.doy));
		         			 arrayDOY3112.push(parseInt(_toDate3112.doy));
		         			   
		         			    if(parseInt(_toDate.doy) >= parseInt(_toDate1610.doy) && parseInt(_toDate.doy) <= parseInt(_toDate3112.doy))
		         			    {
		         			    	
		         				    offset_time_int2= toDate+"/"+i;
		         				    //arrayYears.push(i-1);
		         				   arrayYears.push(i);
		         			    }
		         			    else {
		         			    	offset_time_int2= toDate+"/"+(i+1);
		         			    	 arrayYears.push(i);
		         			    }
		         			    
		         			  arrayTime1.push(gm.date.stringDate2Int(offset_time_int1));
		         			  arrayTime2.push(gm.date.stringDate2Int(offset_time_int2));
		         			 
		         			}
		         		}
		         	}else {//he thu, thu dong
		         		for(var i=parseInt(nam_from);i<parseInt(nam_to)+1;i++){
		         			  var _toDate=gm.date.stringToJSONDate(toDate+"/"+i);
		         			  arrayDOY.push(parseInt(_toDate.doy));
	         			    offset_time_int1="01/01"+"/"+i;
	         			    //var _toDate=gm.date.stringToJSONDate(toDate+"/2012");
	         			    //gm.date.getDaysInMonth(12, i)+"/12/"+i;
	         			    offset_time_int2= toDate+"/"+(i);
		         			  arrayTime1.push(gm.date.stringDate2Int(offset_time_int1));
		         			  arrayTime2.push(gm.date.stringDate2Int(offset_time_int2));
		         			 var _toDate=gm.date.stringToJSONDate(toDate+"/"+i);
		         			 
		         			 var _toDate1610 = gm.date.stringToJSONDate("16/10/"+i);
		         			  var _toDate3112 = gm.date.stringToJSONDate("31/12/"+i);
		         			 arrayDOY1610.push(parseInt(_toDate1610.doy));
		         			 arrayDOY3112.push(parseInt(_toDate3112.doy));
		         			   

		         			
		         			  
		         			if(type==11)//tien do gieo trong
			         		{
		         			    if(parseInt(_toDate.doy) >= parseInt(_toDate1610.doy) && parseInt(_toDate.doy) <= parseInt(_toDate3112.doy))
		         			    {
		         				    arrayYears.push(i-1);
		         			    } else arrayYears.push(i);
			         		} else {
			         			arrayYears.push(i);
			         		}
	         			}
	         		}
		         	
		         	time_series_int1=gm.utils.createStringWithSeparator(arrayTime1, ',');
		         	time_series_int2=gm.utils.createStringWithSeparator(arrayTime2, ',');
		         	year_series=gm.utils.createStringWithSeparator(arrayYears, ',');
		         	doy_series=gm.utils.createStringWithSeparator(arrayDOY, ',');
		         	doy1610_series=gm.utils.createStringWithSeparator(arrayDOY1610, ',');
		         	doy3112_series=gm.utils.createStringWithSeparator(arrayDOY3112, ',');
		         	
		 
			 } 
			//alert(doy_series);
		  	var jso= gm.utils.createJSONObject({
		  		option:type,
		  		vulua_id: vuid,
		  		todate: toDate,
		  		time_series_int1: time_series_int1,
		  		time_series_int2: time_series_int2,
		  		year_series:year_series,
		  		desc: content,
		  		option: option,
		  		
		  		time_int1: time_int1,
		  		time_int2: time_int2,
		  		error:hasError,
		  		doy:strDOY,
		  		doy_series:doy_series,
		  		doy1610_series:doy1610_series,
		  		doy3112_series:doy3112_series
		  		

		  	 },isShowDebug);
		  	 return jso;
		},
		validate: function(){
			
		},
		
		/**
		 * Call this when user click button "xay dung do thi"
		 */
		onClickBuildGraph:function(bFromKQVT){
				$("*").css("cursor", "progress");
				//openExtruder('baocao_build_graph_extruder');
				//$('#baocao_build_graph_extruder').self().css("opacity",1.0);
				//$(window).width()-10*(24+5)
				// var typeReport = null;
				// var time_int1=0;
				// var time_int2=0; 
				// var vulua =0;
				// var option =3;
				// var msgErrors="";
				var forAlldbscl = false;
				
				 var jsonOpts= null;
				 if(bFromKQVT == undefined)jsonOpts = this.getOptionsContent();
				 else jsonOpts = this.getOptionsContentFromPaneVientham();
				 if(jsonOpts==null)return;
				 
				
				 //alert(jsonOpts.option);
				// var posWKT="";
				 //getLanhthoClicked( 'tbl_xa_region','xa_id',posWKT);
				 //msgErrors='Không tạo được báo cáo:'+'<br>'+'- Không có dữ liệu' +'<br>- Vụ lúa này đã được thu hoạch hết<br>';
				 typeReport = REPORT_TYPE_BUILDGRAPH;
				 //var page_type = $('input:radio[name=dlg_main_report_radio_trang]:checked').val();

				//alert(page_type)
				 //hiden controls
				 g_controlPanel.hideControl(g_btnEditCanhdong);
			     g_controlPanel.hideControl(g_btnSelectDeature);

				//cwrs_debug(vulua+','+time_int1+','+time_int2);
				//reload chart image
			   /*  var url_image=REPORT_SERVLET +
						"&action=" +ACT_GEN_REPORT+
						"&type=" +REPORT_TYPE_BUILDGRAPH+
						"&option="+jsonOpts.option+
						"&type_mds_tlb_dtn="+jsonOpts.type_mds_tlb_dtn+
						"&tinh_id=" +gm.map.getLanhthoSelected("tinh_id")+
						"&huyen_id=" +gm.map.getLanhthoSelected("huyen_id")+
						"&xa_id=" +gm.map.getLanhthoSelected("xa_id")+
						"&width=" +800+
						"&height="+ 600+
						"&time_int1=" +jsonOpts.time_int1+
						"&time_int2=" +jsonOpts.time_int2+
						"&sau_id="+jsonOpts.sau_id+
						"&benh_id="+jsonOpts.benh_id+
						"&rand="+(new Date()).getTime();//used for no-caching*/
			     		
			  		/*gionglua_id: gl,
			  		vulua_id: vuid,
			  		todate: toDate,
			  		time_series_int1: time_series_int1,
			  		time_series_int2: time_series_int2,
			  		year_series:year_series,*/
		        //get data
			    // alert(gm.map.getLanhthoSelected("tinh_id")+","+gm.map.getLanhthoSelected("huyen_id")+","+gm.map.getLanhthoSelected("xa_id"))
			    //if( jsonOpts.option !=5 &&  jsonOpts.option !=6)
	
			     if(gm.map.getLanhthoSelected("tinh_id")== undefined) return;
			     $.ajax({
					url:REPORT_SERVLET ,
					data:
					{ 
						action:ACT_GEN_REPORT,
						type:REPORT_TYPE_BUILDGRAPH,
						option:jsonOpts.option,
						type_mds_tlb_dtn:jsonOpts.type_mds_tlb_dtn,
						tinh_id:gm.map.getLanhthoSelected("tinh_id"),
						huyen_id:gm.map.getLanhthoSelected("huyen_id"),
						xa_id:gm.map.getLanhthoSelected("xa_id"),
						tinh_name:gm.map.getLanhthoSelected("tinh_name"),
						huyen_name:gm.map.getLanhthoSelected("huyen_name"),
						xa_name:gm.map.getLanhthoSelected("xa_name"),
						width:800,
						height:600,
						time_int1:jsonOpts.time_int1,
						time_int2:jsonOpts.time_int2,
						sau_id:jsonOpts.sau_id,
						benh_id:jsonOpts.benh_id,
						
						vulua_id:jsonOpts.vulua_id,
						gionglua_id:jsonOpts.gionglua_id,
						time_series_int1:jsonOpts.time_series_int1,
						time_series_int2:jsonOpts.time_series_int2,
						year_series:jsonOpts.year_series,
						doy:jsonOpts.doy,
						doy_series:jsonOpts.doy_series,
						doy1610_series:jsonOpts.doy1610_series,
						doy3112_series:jsonOpts.doy3112_series,
						dbscl:this.bAllDbscl
						//"&rand="+(new Date()).getTime();
						
					},
					async:false,
					error: function (request, status, error) {
			  
					},
					success:function(jsonDataResult) {
						var json = JSON.parse(jsonDataResult);
						gm.report.show();
					  // Apply the theme
					  try{
				    		  if( gm.report.graph.chart!=null){
							    gm.report.graph.chart.destroy();
							    gm.report.graph.chart=null;
				    		  }
				      }catch(err){}
					gm.report.graph.createChart(json.main_title,json.axis_y_title,json.tooltip_unit,json.series, json.xaxis_value);
					$("*").css("cursor", "default");
					}
				});
			 	
			   /* else //VIEN THAM
				 $.ajax({
						url: RENDER_SERVLET ,
						type: "POST",
						data:
					    { 
						  action: ACT_RENDER_MAP_VIENTHAM,
						  position: posWKT,
						  table:table,
						  id:id,
						  year: strYear,
						  doy: strDOY, //day of year (1 -> 365)
						  opts_map_type: map_type, //ndvi, gdst; map_type = 4 chi show dt, ko tao ban do
						  vulua: vulua
						},
						 async:false,
						 success:function(data) {
							 if (data != "" && data != "null"){
						     var jsonObject = JSON.parse(data);
													    	
							   var str_dt_colua = jsonObject.data[0].dt_by_colua;
							   var array_dt_coluahayko = str_dt_colua.split(",");
							    	
							} else if(map_type == 4){//chi hien thi dien tich
								    	var str_dt_cacvu = jsonObject.data[0].lst_str_dt;
								    	var array_dt_cacvu = str_dt_cacvu.split(",");
								    	//array_dt_cacvu[0];//DX
								    	//array_dt_cacvu[1];//HT
								    	//array_dt_cacvu[2];//TĐ
								    	//array_dt_cacvu[3];//Mua
								    	var s = "<strong> [ĐX]: </strong>"+array_dt_cacvu[0]+"  <strong> [HT]: </strong>"+array_dt_cacvu[1]+"  <strong> [TĐ]: </strong> "+array_dt_cacvu[2];
								    	$('#db_rs_tongdt').html(s);
								    	
									
								    }
							    showPanel_createchugiai();
						}
					});*/

		},
		reDrawChart:function(){
			this.chart.redraw();
		},
		createChart:function(mainTitle,axisYTitle,tooltipUnit,data,xaxis_value){
		    this.chart = new Highcharts.Chart({
		    	global: {
					useUTC: false
				},
				exporting: {
					enabled: false
				},
	            chart: {
	                renderTo: 'chart_content',
	                type: gm.report.graph.chartType
	            },
	            title: {
	                text: mainTitle
	            },
	            subtitle: {
	                text: ''
	            },
	            xAxis:{
	                /*type: 'datetime',
	                      	tickInterval: 6 * 24 * 3600 * 1000, // one week
	        			
	        			
	        			//tickWidth: 10,//do day cua moc ngay thang
	        			gridLineWidth: 1,
	        			labels: {
	        		         formatter: function() {
	   	                    	//alert(this.value)
	   	                        return gm.date.long2DateString(this.value);// "15.05.2012";//Highcharts.dateFormat('%d %b %y', this.value);
	   	                     }
	               			}*/
	            	 categories: xaxis_value
	            },
	           	          
	            yAxis: {
	                title: {
	                    text: axisYTitle
	                },
	                min: 0
	               // ,minorTickInterval: 'auto'
	            },
	            tooltip: {
	                formatter: function() {
	                        return '<b>'+ this.series.name +'</b><br/>'+
	                       /* Highcharts.dateFormat('%e. %b', this.x) +': '+ */this.y.toFixed(2) +' '+tooltipUnit;
	                }
	            },
	            plotOptions: {
	                line: {
	                    dataLabels: {
	                        enabled: gm.report.graph.showLabelOnLine,
	                        formatter: function() {
		                        return this.y.toFixed(2);
		                }
	                    },
	                    enableMouseTracking: true
	                }
	            },
	            series: data
	        });
		    
		}

};


function CCWRS_Report(){
	this.graph=new CCWRS_Report_BuildGraph(); 
	this._container= null;
	this.easing=
	      ['easeOutQuad',
	      'easeInOutQuad',
	      'easeInCubic',
	      'easeOutCubic',
	      'easeInOutCubic',
	      'easeInQuart',
	      'easeOutQuart',
	      'easeInOutQuart',
	      'easeInQuint',
	      'easeOutQuint',
	      'easeInOutQuint',
	      'easeInSine',
	      'easeOutSine',
	      'easeInOutSine',
	      'easeInExpo',
	      'easeOutExpo',
	      'easeInOutExpo',
	      'easeInCirc',
	      'easeOutCirc',
	      'easeInOutCirc',
	      'easeInElastic',
	      'easeOutElastic',
	      'easeInOutElastic',
	      'easeInBack',
	      'easeOutBack',
	      'easeInOutBack',
	      'easeInBounce',
	      'easeOutBounce',
	      'easeInOutBounce'//28
	      ];
	this.settings={};
	//alert($("#map").height())
	//alert("mb "+)
	this.setSetting({"width":$("#map").width()-$("#baocao_extruder").getOptions().width,"height":$("#map").height()-60});
}
CCWRS_Report.bShowing=false;
CCWRS_Report.prototype = {
		info:function(){
			alert('Report Manager version 1.0');
		},
		setSetting: function(options){
			this.settings = $.extend({
		        "id": "CCWRS_Report_result_panel",
		        "icon": false,
		        "title": false,
		        "message": "",
		        "cls": "",
		        "speed": 500,
		        "timeout": 3000,
		        "x":0,
		        "y":0,
		        "easing":"easeInOutExpo",
		        "bShowing":false
		      },options);
		},
		onShowDone:function(){
			try{
				CCWRS_Report.bShowing=true;
			}catch(err){
				alert(err)
			}
		},
		show: function(){
			if(CCWRS_Report.bShowing)return;
			this._container = $('<div id="chartcontainer"></div>').appendTo("#map");
			this._container.prepend(
			        '<div id="'+this.settings.id+'" class="chartcontent '+this.settings.cls+'" >'+
	
			        	'<div id="chart_content" style="min-width: 400px; height: 400px; margin: 0px 0px 5px 5px"></div>'+
			        	' '+
			        '</div>'
			      );
		  //  top: 50%;
		 //   left: 150%;
			$("#chartcontainer").draggable();

			//alert($("#map").height())
			var width=(this.settings.width-50)+'px';
			var height=this.settings.height+'px';
			var marginTop=((-1)*this.settings.height/2)+'px';
			var marginLeft=((-1)*this.settings.width/2)+'px';
			
			//alert( gm.date.date2String(gm.date.Int2Date(15340)))
			
			$("#"+this.settings.id).css({top:"50%",left:"50%"});
			$("#chart_content").css({width:width,height:height});
			
		    $("#"+this.settings.id).animate({
		    	  width: [width, this.settings.easing],
		          height: [height, this.settings.easing],
		          marginTop: [marginTop,this.settings.easing],
		          marginLeft: [marginLeft, this.settings.easing]
		      }
		      ,1500,this.onShowDone);
		    
		    

		    
		},
		hide: function(){
			if(CCWRS_Report.bShowing){
			    $("#"+this.settings.id).animate({
			    	  width: [10, this.settings.easing],
			          height: [10, this.settings.easing],
			          marginTop: [10,this.settings.easing],
			          marginLeft: [10, this.settings.easing]
			      }
			      ,1000,function(){
			    	  CCWRS_Report.bShowing=false;
			    	  try{
			    		  if(gm.report.graph.chart!=null){
			    		     gm.report.graph.chart.destroy();
			    		     gm.report.graph.chart=null;
			    		  }
			    		  $(gm.report._container).hide().remove();
			    	  }catch(err){
			    		  msginfo(err)
			    	  }
					
						
			    	  
			      });
			    

			}
		}

};


/***
*VIEN THAM MODULE
*author:TuanNA
*Email:atmel.ru@gmail.com
***/
function CCWRS_Vientham(){
	this.mapLayer=new Map();
	this.layers=[];
	
}
CCWRS_Vientham.prototype = {
		
		onLoad:function(){
			//this.registerEvents();
		    //load theme
	 		//gm.loadScript("components/charts/highcharts/themes/dark-blue.js");
		},
		
		registerEvents:function(){
			//init
			 //load theme
	 		gm.loadScript("components/charts/highcharts/themes/dark-blue.js");
	 		$("#rs_graph_txtdate").attr('disabled',true);
	 		
			//attack a click event on all radio buttons with name 'dlg_main_graph_radio'
			$("input[name=rs_maptype_options]:radio").click(function() {
				 switch($(this).val()){
				 	case "1"://theo ndvi
				 		//$('#dlg_main_graph_gieocaythuhoach').show();
				 		//$('#dlg_main_graph_dichhai').hide();
				 		
						//var content = gm.vientham.CreateTableChugiaiTpl_GDST(/*title,arrayIDs,arrayNames,arrayColors*/);
						//$("#div_chugiai_vientham").html(content);
				 		 $("#div_rs_chugiai_gdst").hide();
				 		 $("#div_rs_chugiai_ndvi").show();


				 		break;
				 	case "2"://theo giai doan sinh truong
				 		 $("#div_rs_chugiai_gdst").show();
				 		 $("#div_rs_chugiai_ndvi").hide();

				 		break;
				 }
			});
			$("input[name=rs_graph_options]:radio").click(function() {
				 switch($(this).val()){
				 	case "10"://
				 		$("#rs_graph_txtdate").attr('disabled',true);	
				 		


				 		break;
				 	case "11"://
				 		$("#rs_graph_txtdate").attr('disabled',false);	

				 		break;
				 }
			});
			//Check box lap ban do hien trang va show dt lua theo vu
			$('#rs_checkbox_taomap').click(function() {
		        if (this.checked) {
		        	//enable
		        	$("#rs_maptype_options_ndvi").attr('disabled',false);	
		        	$("#rs_maptype_options_gdst").attr('disabled',false);
		        	//uncheck
		        	$('#rs_checkbox_mapcoluahayko').attr('checked', false);
		        	$('#rs_checkbox_tongdtvutrongnam').attr('checked', false);
		        	$('#rs_checkbox_creategraph').attr('checked', false);
		        	
		        	//disalbe
		        	 $('#rs_htlua_cbbnam').attr('disabled',true);
		        	 $('#rs_htlua_cbbvulua').attr('disabled',true);
		        	 $('#rs_tongdtcacvu_cbbnam').attr('disabled',true);
		        	
			        //hide then show
				 	$("#div_rs_chugiai_gdst").hide();
				 	$("#div_rs_chugiai_ndvi").hide();
				 	$("#div_rs_chugiai_graph").hide();
				 	$('#rs_graph_button').hide();
				 	
				 	if($('input:radio[name=rs_maptype_options]:checked').val() != undefined){
						var opt = $('input:radio[name=rs_maptype_options]:checked').val();
						if(opt ==1)$("#div_rs_chugiai_ndvi").show();
						if(opt ==2)$("#div_rs_chugiai_gdst").show();
					}				 	
		        	
				 	$('#db_rs_tongdt').html('');
		        } else {
		        	$("#rs_maptype_options_ndvi").attr('disabled',true);	
		        	$("#rs_maptype_options_gdst").attr('disabled',true);
		        	//hide
			 		$("#div_rs_chugiai_gdst").hide();
			 		$("#div_rs_chugiai_ndvi").hide();
			 		$('#rs_graph_button').hide();
		        }
		    });
			
			$('#rs_checkbox_mapcoluahayko').click(function() {
		        if (this.checked) {
		        	//enable
		            $('#rs_htlua_cbbnam').attr('disabled',false);
		        	$('#rs_htlua_cbbvulua').attr('disabled',false);
		        	
		        	//uncheck
		        	$('#rs_checkbox_taomap').attr('checked', false);
		        	$('#rs_checkbox_tongdtvutrongnam').attr('checked', false);
		        	$('#rs_checkbox_creategraph').attr('checked', false);
		        	
		        	//disable
		        	$("#rs_maptype_options_ndvi").attr('disabled',true);	
		        	$("#rs_maptype_options_gdst").attr('disabled',true);
		        	$('#rs_tongdtcacvu_cbbnam').attr('disabled',true);
		        	
		        	//hide
			 		$("#div_rs_chugiai_gdst").hide();
			 		$("#div_rs_chugiai_ndvi").hide();
			 		$("#div_rs_chugiai_graph").hide();
			 		$('#rs_graph_button').hide();
		        	
			 		$('#db_rs_tongdt').html('');
		        	
		        } else {
		        	
		        }
		    });
			$('#rs_checkbox_tongdtvutrongnam').click(function() {
		        if (this.checked) {

		        	//enable
		        	$('#rs_tongdtcacvu_cbbnam').attr('disabled',false)
		        	
		        	//uncheck
		        	$('#rs_checkbox_taomap').attr('checked', false);
		        	$('#rs_checkbox_mapcoluahayko').attr('checked', false);
		        	$('#rs_checkbox_creategraph').attr('checked', false);
		        	
		        	
		        	//disable
		        	$("#rs_maptype_options_ndvi").attr('disabled',true);	
		        	$("#rs_maptype_options_gdst").attr('disabled',true);
		           	$('#rs_htlua_cbbnam').attr('disabled',true);
		        	$('#rs_htlua_cbbvulua').attr('disabled',true);
		        	
		        	//hide
			 		$("#div_rs_chugiai_gdst").hide();
			 		$("#div_rs_chugiai_ndvi").hide();
			 		$("#div_rs_chugiai_graph").hide();
			 		$('#rs_graph_button').hide();
		        	
		        	
		        	
		        } else {
		        	
		        }
		    });
			
			$('#rs_checkbox_creategraph').click(function() {
		        if (this.checked) {

		        	//enable
		        	$('#rs_tongdtcacvu_cbbnam').attr('disabled',false)
		        	
		        	//uncheck
		        	$('#rs_checkbox_taomap').attr('checked', false);
		        	$('#rs_checkbox_tongdtvutrongnam').attr('checked', false);
		        	$('#rs_checkbox_mapcoluahayko').attr('checked', false);
		        	
		        	//disable
		        	$("#rs_maptype_options_ndvi").attr('disabled',true);	
		        	$("#rs_maptype_options_gdst").attr('disabled',true);
		           	$('#rs_htlua_cbbnam').attr('disabled',true);
		        	$('#rs_htlua_cbbvulua').attr('disabled',true);
		        	$('#rs_tongdtcacvu_cbbnam').attr('disabled',true);
		        	
		        	//hide
			 		$("#div_rs_chugiai_gdst").hide();
			 		$("#div_rs_chugiai_ndvi").hide();
			 		
			 		//show
			 		$("#div_rs_chugiai_graph").show();
			 		$('#rs_graph_button').show();
		        	
		        	
		        	
		        } else {
		        	$("#div_rs_chugiai_graph").hide();
		        	$('#rs_graph_button').hide();
		        	
		        }
		    });
			//on change
			$( "#rs_htlua_cbbvulua" ).change(function() {//rs_htlua_cbbnam
				 var cbbyear = ''; 
				 var cbbyear_dongxuan='';
				 for (var i =0; i >= -15; i--){
					 cbbyear_dongxuan += ('<option value=\'' + (parseInt(g_rtc.year)+i)+ '\'>'+(parseInt(g_rtc.year)+i)+' - '+(parseInt(g_rtc.year)+i+1)+'</option>');
					 cbbyear += ('<option value=\'' + (parseInt(g_rtc.year)+i)+'\'>'+(parseInt(g_rtc.year)+i)+'</option>');

				 }
				var vuid= $("#rs_htlua_cbbvulua").val();
				if (vuid==1){
					$('#rs_htlua_cbbnam').html(cbbyear_dongxuan);
				} else
					$('#rs_htlua_cbbnam').html(cbbyear);
			});
			
			
			
			
        	//enable
        	$("#rs_maptype_options_ndvi").attr('disabled',false);	
        	$("#rs_maptype_options_gdst").attr('disabled',false);
        	//uncheck
        	$('#rs_checkbox_mapcoluahayko').attr('checked', false);
        	$('#rs_checkbox_tongdtvutrongnam').attr('checked', false);
        	$('#rs_checkbox_creategraph').attr('checked', false);
        	
        	//disalbe
        	 $('#rs_htlua_cbbnam').attr('disabled',true);
        	 $('#rs_htlua_cbbvulua').attr('disabled',true);
        	 $('#rs_tongdtcacvu_cbbnam').attr('disabled',true);
        	 

			$('#extruder_vientham_textboxdate').datebox('setValue',g_rtc.string);
			
			//OnClick Build Graph
			$('#rs_btn_buildgraph').click(function(){ 
				gm.report.graph.bAllDbscl = false;
				var graphopt = $('input:radio[name=rs_graph_options]:checked').val();
				if(graphopt==undefined){ 
					msgwarning('Hãy chọn tùy chọn xây dựng đồ thị.');
					return;
				};
				 msgconfirm('Thông báo','Xây dựng đồ thị cho cả vùng ĐBSCL có thể mất một vài phút, bạn có muốn tiếp tục?',function(r){
					    if (r){
					    	gm.report.graph.bAllDbscl = true;
					    	setTimeout(function() {
					    		gm.report.graph.onClickBuildGraph(true);//true if from vien tham
								 
					    		}, 500);
					    }
					  });
			
            });
			$('#rs_btn_buildgraph_close').click(function(){ 
				gm.report.hide();
            });
		},

		/**
		 * Trả về một chuỗi chứa thông tin về các loại diện tích:tốt, khá(hiện trạng lúa),năng suất(a-b tấn/ha có diện tích là X...)
		 * @param action
		 * 			ACT_GET_DIENTICH_ON_VIENTHAM_IMG_NS -> năng suất, ACT_GET_DIENTICH_ON_VIENTHAM_IMG_HTL -> hiện trạng lúa...
		 * @param table
		 * 			tên bảng tương ứng với ảnh modis
		 * @param posWKT
		 * 				unused
		 * @param condition
		 * 			thường sử dụng id tỉnh,huyện,xã để lọc tính diện tích
		 * @returns
		 * 		{string}
		 */
		_getDientichInfoSelected:function(action,table,posWKT,condition){
			 var s = null;
			 $.ajax({
						url: REPORT_SERVLET ,
						type: "POST",
						data:
					    { 
						  action: action,//ACT_GET_DIENTICH_ON_VIENTHAM_IMG_NS,
						  //position: posWKT,
						  table:table,
						  condition:condition
						},
						 async:false,
						 error: function (request, status, error) {
						        alert(request.responseText);
						    },
						 success:function(_s) {
							 s = _s;
							return s;
					    }});
			 
			 return s;
		},
		readVienthamImage:function(){
			
			var time_str = $('#extruder_vientham_textboxdate').datebox('getValue');
			//var oDate = gm.date.string2Date(time_str, g_dfDefault);	
			alert(111);
			var jsDate = gm.date.stringToJSONDate(time_str, g_dfDefault);
			alert(jsDate.doy);
			if (!Utils.isValidateDMY(time_str)){msgerror('Hãy chọn thời gian để tạo bản đồ ');return;}		
	
				var name="";
				if(loaibd_id=="2")
					name="-Sạ cấy";
				else if(loaibd_id=="1")
					name="-Sức khỏe lúa";
				else if(loaibd_id=="3")
					name="-Năng suất";
				
				var error=false;
				var vtLayerName="";
				var vtTableName="";
				$.ajax({url:MAIN_SERVLET ,									
				    data:{ 
					  action: ACT_GET_DATA_TO_VIENTHAM_IMAGE,
					  condition: 'id ='+id_image
					},
					async:false,
				    success:function(jsonData) {
						//alert(jsonData);
					try{	
				    	var jsonObject = JSON.parse(jsonData)
						
						 $("#dlg_rs_txtvientham").html(jsonObject.rows[0].tulieuvientham);
						 $("#dlg_rs_txtphangiai").html(jsonObject.rows[0].dophangiai);
						 $("#dlg_rs_txttenchutri").html(jsonObject.rows[0].tenchuyengia);
						 
						 var ngaychup = jsonObject.rows[0].ghi_chu;
						 $("#dlg_rs_txtngaychup").html(ngaychup);
						
				
						 vtLayerName=jsonObject.rows[0].tulieuvientham+name+' ('+ngaychup+')';
						 vtTableName=jsonObject.rows[0].tenbang;
						 
					}catch(err){
						//alert(err)
						error=true;
	
					}
						return;
				    }
				});
			

			if (error==true) return;
			//remove_image_vientham();
			var newurl =mapserver_url_draw_vientham+"tablename="+vtTableName+'&';
			//alert(newurl)
			
			for (var i=0; i<map.layers.length;i++) {
		  	            var layer = map.layers[i];
		  	            if(layer.name==vtLayerName)
		  	            {
		  	            			return;
		  	            }
		  	}
			
			
			var layer_vientham_in_mapfile= "";
			//alert($("#dlg_rs_cbloaibando").val())
			switch($("#dlg_rs_cbloaibando").val()){
				case "1": 
					layer_vientham_in_mapfile='layer_vientham_htl';
					break;
				case "2": 
					layer_vientham_in_mapfile='layer_vientham_sacay';
					//ẩn chú giải
					$("#div_chugiai_vientham").hide();
					break;
				case "3": //nang suat
					layer_vientham_in_mapfile='layer_vientham_ns';
					//ẩn chú giải
					$("#div_chugiai_vientham").hide();
					break;
			
				default:break;
			
			}
			//alert(layer_vientham_in_mapfile)
			var new_layer    = new OpenLayers.Layer.WMS(vtLayerName,newurl,{layers: layer_vientham_in_mapfile ,transparent: 'true',format: image_format,isBaseLayer: false,visibility: 'false'},{projection:'EPSG:4756',singleTile: true});
			//new_layer.attributes['table_database']='hell atmel';
			new_layer.setVisibility(false);
			map.removeLayer(g_layer_search);
		    map.addLayer(new_layer);	
		    map.addLayer(g_layer_search);
		    this.mapLayer.put(vtLayerName,vtTableName);
		    this.layers.push(new_layer);
		   
		},
		removeVienthamImage:function(){
			//g_vientham_htl_table = null;
			/*for (var i=0; i <  this.layers.length;i++)
				map.removeLayer( this.layers[i]);
			
			this.layers=[];
  		    this.mapLayer.clear();
			CloseDientichGiaidoanAnhViewer();
			*/
			layer_ruong_hientrang.setVisibility(false);
			//$('#div_chugiai_vientham').html('');
		    $("#rs_chugiai_gdst_ma").html('');
		    $("#rs_chugiai_gdst_denhanh").html('');
		    $("#rs_chugiai_gdst_lamdong").html('');
		    $("#rs_chugiai_gdst_tro").html('');
		    $("#rs_chugiai_gdst_ngamsua").html('');
		    $("#rs_chugiai_gdst_chin").html('');
		    
		   
		},
		/***
		 * Hiển thị thông tin khi click bản đồ tương ứng với layer dữ liệu đang được kích hoạt
		 */
		showDataInfo:function(postWKT){
			//alert('showDataInfo:'+postWKT);
			
			
			var layerName=gm.map.getCurrentLayerActivated();
			if(layerName.indexOf("Sức khỏe lúa")>=0){
				this.showDientichHTL(this.mapLayer.get(layerName),postWKT);
			}else if(layerName.indexOf("Sạ cấy")>=0){
				this.showDientichSacay(this.mapLayer.get(layerName),postWKT);
			}else if(layerName.indexOf("Năng suất")>=0){
				this.showNangsuat(this.mapLayer.get(layerName),postWKT);
			}
		},
		createTableChugiai:function(title,arrayIDs,arrayNames,arrayColors){
			var s= '<table width="200" border="0" align="center" style="margin-left:40px;">';
			s+= '<tr>';
			s+= '<td colspan="2"><strong style="color:#ffffff;margin-left:10px;">'+title+'</strong></td>';
			s+= '</tr>';
			for(var i=0;i<arrayNames.length;i++){
				s+= '<tr>';
				s+= '<td id="'+arrayIDs[i]+'" width="35" style="background:'+arrayColors[i]+ '">&nbsp;</td>';
				s+= '<td  width="149" ><strong style="color:#ffffff;margin-left:10px;">'+arrayNames[i]+ '</strong></td>';
				s+= '</tr>';
			}
			s+= '</table>'; 
			return s;
		},
		/**
		 * Tạo table template chú giải giai đoạn sinh trưởng
		 * @param title
		 * @param arrayIDs
		 * @param arrayNames
		 * @param arrayColors
		 * @returns {String}
		 */
		CreateTableChugiaiTpl_GDST:function(/*title,arrayIDs,arrayNames,arrayColors*/){
			 var title = "AAAA";
			 var arrayIDs =  [
					    'color_ns_rattot',
					    'color_ns_tot',
					    'color_ns_kha',
					    'color_ns_tb',
					    'color_ns_yeu',
					    'color_ns_kem',
					    ];
			 
			 var arrayNames = [
					    "Mạ",
					    "Đẻ nhánh",
					    "Làm đòng",
					    "Trổ",
					    "Ngậm sữa",
					    "Chín"
					    ];
			var arrayColors = [
					     gm.utils.rgbToHex(177,255,177),
					     gm.utils.rgbToHex(118,205,118),
					     gm.utils.rgbToHex(59, 155, 59),
					     gm.utils.rgbToHex(0,104,0),
					     gm.utils.rgbToHex(189, 255,0),
					     gm.utils.rgbToHex(255,255,0)
					     ];
			var arrayDientich = [
							    "",
							    "",
							    "",
							    "",
							    "",
							    ""
							     ];		
					   
			   //set to parent
			
			var s= '<table width="200" border="0" align="center" style="margin-left:40px;">';
			s+= '<tr>';
			s+= '<td colspan="2"><strong style="color:#ffffff;margin-left:10px;">'+title+'</strong></td>';
			s+= '</tr>';
			for(var i=0;i<arrayNames.length;i++){
				s+= '<tr>';
				s+= '<td  width="40" ><strong style="color:#ffffff;margin-left:10px;">'+arrayNames[i]+ '</strong></td>';
				s+= '<td id="'+arrayIDs[i]+'" width="30" style="background:'+arrayColors[i]+ '">&nbsp;</td>';
				s+= '<td  width="40" ><strong style="color:#ffffff;margin-left:10px;">'+arrayDientich[i]+ '</strong></td>';
				s+= '</tr>';
			}
			s+= '</table>'; 
			return s;
		},
		/**
		 * Tạo table template chú giải giai đoạn sinh trưởng
		 * @param title
		 * @param arrayIDs
		 * @param arrayNames
		 * @param arrayColors
		 * @returns {String}
		 */
		CreateTableChugiaiTpl_ChatLuongLua:function(/*title,arrayIDs,arrayNames,arrayColors*/){
			 var title = "AAAA";
			 var arrayIDs =  [
					    'color_ns_rattot',
					    'color_ns_tot',
					    'color_ns_kha',
					    'color_ns_tb',
					    'color_ns_yeu',
					    'color_ns_kem',
					    ];
			 
			 var arrayNames = [
					    "Mạ",
					    "Đẻ nhánh",
					    "Làm đòng",
					    "Trổ",
					    "Ngậm sữa",
					    "Chín"
					    ];
			var arrayColors = [
					     gm.utils.rgbToHex(177,255,177),
					     gm.utils.rgbToHex(118,205,118),
					     gm.utils.rgbToHex(59, 155, 59),
					     gm.utils.rgbToHex(0,104,0),
					     gm.utils.rgbToHex(189, 255,0),
					     gm.utils.rgbToHex(255,255,0)
					     ];
			var arrayDientich = [
							    "",
							    "",
							    "",
							    "",
							    "",
							    ""
							     ];		
					   
			   //set to parent
			
			var s= '<table width="200" border="0" align="center" style="margin-left:40px;">';
			s+= '<tr>';
			s+= '<td colspan="2"><strong style="color:#ffffff;margin-left:10px;">'+title+'</strong></td>';
			s+= '</tr>';
			for(var i=0;i<arrayNames.length;i++){
				s+= '<tr>';
				s+= '<td  width="40" ><strong style="color:#ffffff;margin-left:10px;">'+arrayNames[i]+ '</strong></td>';
				s+= '<td id="'+arrayIDs[i]+'" width="30" style="background:'+arrayColors[i]+ '">&nbsp;</td>';
				s+= '<td  width="40" ><strong style="color:#ffffff;margin-left:10px;">'+arrayDientich[i]+ '</strong></td>';
				s+= '</tr>';
			}
			s+= '</table>'; 
			return s;
		},
		OnMapClick:function(posWKT){
			
			var table = '';
			var id = '';
			if (layer_xa.getVisibility()){
				table = 'tbl_xa_region';
				id = 'xa_id';
			} else if (layer_huyen.getVisibility()) {
				table = 'tbl_huyen_region';
				id = 'huyen_id';
			} else {
				table = 'tbl_tinh_region';
				id = 'tinh_id';	
			}
			getLanhthoClicked( table,id,posWKT);
			var time_str = $('#extruder_vientham_textboxdate').datebox('getValue');

				
			var strYear = 0;
			var strDOY = 0;
			var map_type = -1;
			if($('#rs_checkbox_taomap').attr('checked'))
			{
				var jsDate = gm.date.stringToJSONDate(time_str, g_dfDefault);
				if (!Utils.isValidateDMY(time_str)){msgerror('Hãy chọn thời gian để tạo bản đồ ');return;}	
				strYear = jsDate.year;
				strDOY = jsDate.doy;
				
				if($('input:radio[name=rs_maptype_options]:checked').val() != undefined){
					map_type = $('input:radio[name=rs_maptype_options]:checked').val();
				}else {
					map_type = -1;
				}
				
			}else if($('#rs_checkbox_mapcoluahayko').attr('checked'))
			{
				map_type = 3;
				strYear = gm.cbb.getValue("rs_htlua_cbbnam");
			}else if($('#rs_checkbox_tongdtvutrongnam').attr('checked'))
			{
				map_type = 4;//chi show dt, ko tao ban do
				strYear = gm.cbb.getValue("rs_tongdtcacvu_cbbnam");
			} else if($('#rs_checkbox_creategraph').attr('checked')){
				
				var grpahtype = $('input:radio[name=rs_graph_options]:checked').val();
				if(grpahtype==10 || grpahtype==11){
				gm.report.graph.bAllDbscl = false;
				gm.report.graph.onClickBuildGraph(true);//true if from vien tham
				
				}
				return;
			}
       

			var vulua = gm.cbb.getValue("rs_htlua_cbbvulua");
			/*alert('vu '+vulua);
			alert('opts '+map_type);
			alert('year '+strYear);
			alert('doy '+strDOY);*/
			if(map_type == -1) return;
					
					
			 var isRendered = false;
			 var mapFile = '';
			 $.ajax({
						url: RENDER_SERVLET ,
						type: "POST",
						data:
					    { 
						  action: ACT_RENDER_MAP_VIENTHAM,
						  position: posWKT,
						  table:table,
						  id:id,
						  year: strYear,
						  doy: strDOY, //day of year (1 -> 365)
						  opts_map_type: map_type, //ndvi, gdst; map_type = 4 chi show dt, ko tao ban do
						  vulua: vulua
						},
						 async:false,
						 success:function(data) {

							 if (data != "" && data != "null"){
								 isRendered = true;
							    var jsonObject = JSON.parse(data);
							    mapFile = jsonObject.data[0].map_file;

							   

							    if(map_type == 2){
								    var str_dt_gdst = jsonObject.data[0].dt_by_gdst;
								    var array_dt_gdst = str_dt_gdst.split(",");
							      $("#rs_chugiai_gdst_ma").html(array_dt_gdst[0]);
							      $("#rs_chugiai_gdst_denhanh").html(array_dt_gdst[1]);
							      $("#rs_chugiai_gdst_lamdong").html(array_dt_gdst[2]);
							      $("#rs_chugiai_gdst_tro").html(array_dt_gdst[3]);
							      $("#rs_chugiai_gdst_ngamsua").html(array_dt_gdst[4]);
							      $("#rs_chugiai_gdst_chin").html(array_dt_gdst[5]);
							    } else if(map_type == 3){
							    	
							    	var str_dt_colua = jsonObject.data[0].dt_by_colua;
							    	var array_dt_coluahayko = str_dt_colua.split(",");
							    	
								    //  $("#..").html(array_dt_coluahayko[0]);
								    //  $("#..").html(array_dt_coluahayko[1]);

								    } else if(map_type == 4){//chi hien thi dien tich
								    	var str_dt_cacvu = jsonObject.data[0].lst_str_dt;
								    	var array_dt_cacvu = str_dt_cacvu.split(",");
								    	//array_dt_cacvu[0];//DX
								    	//array_dt_cacvu[1];//HT
								    	//array_dt_cacvu[2];//TĐ
								    	//array_dt_cacvu[3];//Mua
								    	var s = "<strong> [ĐX]: </strong>"+array_dt_cacvu[0]+"  <strong> [HT]: </strong>"+array_dt_cacvu[1]+"  <strong> [TĐ]: </strong> "+array_dt_cacvu[2];
								    	$('#db_rs_tongdt').html(s);
								    	
									
								    }
							    showPanel_createchugiai();
				
							 }
							
							return data;  
					    }});
			 
			 if(map_type != -1 && map_type != 4){
				if (isRendered == true){
					
					var url = mapserver_url_draw_hientrang.replace('<o>', mapFile);
					//msginfo('Tạo bản đồ hiện trạng thành công!');
					ShowMessageCreateMapSuccess('Bản đồ hiện trạng đang được tạo...');
					var currentime = new Date().getTime();
				 	layer_ruong_hientrang.url = url+'&random='+currentime;
				 	// cwrs_debug("map file url: "+ url);
		 		    //alert("map file url: "+ layer_ruong_hientrang.url);
				 	layer_ruong_hientrang.redraw();
				 	layer_ruong_hientrang.setVisibility(true);

				} else {
					 msgwarning('Hệ thống không xây dựng được bản đồ hiện trạng (không có dữ liệu hoặc dữ liệu không hợp lệ)');

				}
			 }
			 
			
			
		}

};

/**
 * NOT USED, NOW
 * 
 */
function CCWRS_Vientham_old(){
	this.mapLayer=new Map();
	this.layers=[];
	
}
CCWRS_Vientham_old.prototype = {
		/**
		 * 
		 */
		 _onChangeSelectImage:function(){
			//alert('dialogs:922, no used OnComboAnhVienthamChange')//return;
			
			var id_image = $("#dlg_rs_cbanh").val();
			var loaibd_id=  $("#dlg_rs_cbloaibando").val();
			
			var name="";
			if (loaibd_id=="3")
				name="(Năng suất lúa)";
			else if(loaibd_id=="2")
				name="-Sạ cấy";
			else 
				name="-Sức khỏe lúa";
			
			$.ajax({url:MAIN_SERVLET ,									
			    data:{ 
				  action: ACT_GET_DATA_TO_VIENTHAM_IMAGE,
				  condition: 'id ='+id_image
				},
				async:false,
			    success:function(jsonData) {
					//alert(jsonData);
				try{	
			    	var jsonObject = JSON.parse(jsonData)
					
					 $("#dlg_rs_txtvientham").html(jsonObject.rows[0].tulieuvientham);
					 $("#dlg_rs_txtphangiai").html(jsonObject.rows[0].dophangiai);
					 $("#dlg_rs_txttenchutri").html(jsonObject.rows[0].tenchuyengia);
					 
					// var ngaychup = jsonObject.rows[0].time;
					 var ghi_chu = jsonObject.rows[0].ghi_chu;
					 $("#dlg_rs_txtngaychup").html(ghi_chu);
					

	

				}catch(err){

				}
					return;
			    }
			});
		},
		/**
		 * Fires khi chọn hiện trạng lúa,sạ cấy,năng suất
		 */
		 _onChangeSelectMapType:function(){
			 
			 
				var loaibd_id, cond;
				loaibd_id=  $("#dlg_rs_cbloaibando").val();
				//ẩn chú giải
				/*/if(loaibd_id=="2")
				$("#div_chugiai_vientham").hide();
				else 
					$("#div_chugiai_vientham").show();
				*/
				 cond=" loai_bando_id="+loaibd_id;
				// cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_DOT_THIENTAI_TO_CBB,cond, TYPE_DATA_HTML_CBB,"*", 'dlg_main_hientrang_thientai_cbdot');
				 cwrs_Data2ComboBox(MAIN_SERVLET, ACT_GET_VIENTHAM_TO_CBB, cond, TYPE_DATA_HTML_CBB,'*', 'dlg_rs_cbanh');	


			   /* $('#color_htl_rattot').css({background:"rgb(40, 196, 153)"});
			    $('#color_htl_tot').css({background:"rgb(45, 196, 40)"});
			    $('#color_htl_kha').css({background:"rgb(157, 196, 40)"});
			    $('#color_htl_tb').css({background:"rgb(194, 160, 41)"});
			    $('#color_htl_yeu').css({background:"rgb(194, 81, 43)"});
			    $('#color_htl_kem').css({background:"rgb(200, 20, 20)"});*/
				var loaibd_id=  $("#dlg_rs_cbloaibando").val();
				if (loaibd_id=="3"){//name="(Năng suất lúa)";
					  var content= this.createTableChugiai("CHÚ GIẢI",
							   [
							    'color_ns_rattot',
							    'color_ns_tot',
							    'color_ns_kha',
							    'color_ns_tb',
							    'color_ns_yeu',
							    'color_ns_kem',
							    'color_ns_khac'
							    ],
							   [
							    "< 5.0     tấn/ha",
							    "5 - 5.5   tấn/ha",
							    "5.5 - 6.0 tấn/ha",
							    "6.0 - 6.5 tấn/ha",
							    "6.5 - 7.0 tấn/ha",
							    "7.0 - 7.5 tấn/ha",
							    "> 7.5     tấn/ha"
							    ],
							    [
							     gm.utils.rgbToHex(40, 196, 153),
							     gm.utils.rgbToHex(45, 196, 40),
							     gm.utils.rgbToHex(157, 196, 40),
							     gm.utils.rgbToHex(194, 160, 41),
							     gm.utils.rgbToHex(194, 81, 43),
							     gm.utils.rgbToHex(200, 20, 20),
							     gm.utils.rgbToHex(10,10,255)
							     ]
					  		
							   );
					   //set to parent
					   $("#div_chugiai_vientham").html(content);
				}
				else if(loaibd_id=="2"){//name="-Sạ cấy";
					$("#div_chugiai_vientham").html("");
				
				}else if(loaibd_id=="1"){ //name="-Sức khỏe lúa";
					//alert(gm.utils.rgbToHex(40, 196, 153));
					//sreturn;
					  var content= this.createTableChugiai("CHÚ GIẢI",
							   [
							    'color_htl_rattot',
							    'color_htl_tot',
							    'color_htl_kha',
							    'color_htl_tb',
							    'color_htl_yeu',
							    'color_htl_kem',
							    'color_htl_khac'
							    ],
							   [
							    "Rất tốt",
							    "Tốt",
							    "Khá",
							    "Trung bình",
							    "Yếu",
							    "Kém",
							    "Mây hoặc đất khác"
							    ],
							    [
							     gm.utils.rgbToHex(40, 196, 153),
							     gm.utils.rgbToHex(45, 196, 40),
							     gm.utils.rgbToHex(157, 196, 40),
							     gm.utils.rgbToHex(194, 160, 41),
							     gm.utils.rgbToHex(194, 81, 43),
							     gm.utils.rgbToHex(200, 20, 20),
							     gm.utils.rgbToHex(255,255,255)
							     ]
					  		
							   );
					   //set to parent
					   $("#div_chugiai_vientham").html(content);
					   //alert(content)
					   
				}
				
	
			},

		
		
		registerEvents:function(){
			
			$("#dlg_rs_cbanh").change(function() {  
				gm.vientham._onChangeSelectImage();
			});
			$("#dlg_rs_cbloaibando").change(function() {  
				gm.vientham._onChangeSelectMapType();
			});
			


		},
		/**
		 * Trả về một chuỗi chứa thông tin về các loại diện tích:tốt, khá(hiện trạng lúa),năng suất(a-b tấn/ha có diện tích là X...)
		 * @param action
		 * 			ACT_GET_DIENTICH_ON_VIENTHAM_IMG_NS -> năng suất, ACT_GET_DIENTICH_ON_VIENTHAM_IMG_HTL -> hiện trạng lúa...
		 * @param table
		 * 			tên bảng tương ứng với ảnh modis
		 * @param posWKT
		 * 				unused
		 * @param condition
		 * 			thường sử dụng id tỉnh,huyện,xã để lọc tính diện tích
		 * @returns
		 * 		{string}
		 */
		_getDientichInfoSelected:function(action,table,posWKT,condition){
			 var s = null;
			 $.ajax({
						url: REPORT_SERVLET ,
						type: "POST",
						data:
					    { 
						  action: action,//ACT_GET_DIENTICH_ON_VIENTHAM_IMG_NS,
						  //position: posWKT,
						  table:table,
						  condition:condition
						},
						 async:false,
						 error: function (request, status, error) {
						        alert(request.responseText);
						    },
						 success:function(_s) {
							 s = _s;
							return s;
					    }});
			 
			 return s;
		},

		/**
		 * 
		 * @param posWKT
		 */
		 showDientichHTL:function(tableName,posWKT){
			
			var dientich=0;
			var content='';
			var s='';
			if (layer_xa.getVisibility()){
		
				dientich =getSumField(tableName,'dientich','id_xa='+g_lanhtho_selected.getIDXa());
				if(dientich<0)dientich=0;
				s = this._getDientichInfoSelected(ACT_GET_DIENTICH_ON_VIENTHAM_IMG_HTL,tableName,posWKT,'id_xa='+g_lanhtho_selected.getIDXa());
				content=('Diện tích lúa của xã '+g_lanhtho_selected.getTenXa()+' tính theo bản đồ giải đoán ảnh "'+ gm.map.getCurrentLayerActivated() +'" là '+dientich.toFixed(2)+ 'ha' +'<br> '+s)

			} else if (layer_huyen.getVisibility()){

				dientich =getSumField(tableName,'dientich','id_huyen='+g_lanhtho_selected.getIDHuyen());
				if(dientich<0)dientich=0;
				s = this._getDientichInfoSelected(ACT_GET_DIENTICH_ON_VIENTHAM_IMG_HTL,tableName,posWKT,'id_huyen='+g_lanhtho_selected.getIDHuyen());
				content=('Diện tích lúa của huyện '+g_lanhtho_selected.getTenHuyen()+' tính theo bản đồ giải đoán ảnh "'+gm.map.getCurrentLayerActivated() +'" là ' +dientich.toFixed(2)+ 'ha' +'<br> '+s)

			} else if (layer_tinh.getVisibility()){
				dientich = getSumField(tableName,'dientich','id_tinh='+g_lanhtho_selected.getIDTinh());
				if(dientich<0)dientich=0;
				s = this._getDientichInfoSelected(ACT_GET_DIENTICH_ON_VIENTHAM_IMG_HTL,tableName,posWKT,'id_tinh='+g_lanhtho_selected.getIDTinh());
				content=('Diện tích lúa của '+(g_lanhtho_selected.getTenTinh().indexOf("TP")>=0?g_lanhtho_selected.getTenTinh():('tỉnh '+g_lanhtho_selected.getTenTinh())) +' tính theo bản đồ giải đoán ảnh "'+gm.map.getCurrentLayerActivated() +'" là ' +dientich.toFixed(2)+ 'ha' +'<br> '+s)
				
			}
			if(gm.map.getCurrentLayerActivated().indexOf("modis")>=0 ||gm.map.getCurrentLayerActivated().indexOf("Modis")>=0){
				ShowDientichGiaidoanAnhViewer(content);
			}
			else {
				CloseDientichGiaidoanAnhViewer();
			}
		},
		/**
		 * 
		 * @param posWKT
		 */ 
		showDientichSacay:function(tableName,posWKT){
			
			var dientich=0;
			var content='';
			var s='';
			if (layer_xa.getVisibility()){

				dientich =getSumField(tableName,'dientich','id_xa='+g_lanhtho_selected.getIDXa());
				if(dientich<0)dientich=0;
				
				content=('Diện tích xuống giống của xã '+g_lanhtho_selected.getTenXa()+' tính theo bản đồ giải đoán ảnh "'+ gm.map.getCurrentLayerActivated() +'" là '+dientich.toFixed(2)+ 'ha' +'<br> '+s)

			} else if (layer_huyen.getVisibility()){

				dientich =getSumField(tableName,'dientich','id_huyen='+g_lanhtho_selected.getIDHuyen());
				if(dientich<0)dientich=0;
	
				content=('Diện tích xuống giống của huyện '+g_lanhtho_selected.getTenHuyen()+' tính theo bản đồ giải đoán ảnh "'+gm.map.getCurrentLayerActivated() +'" là ' +dientich.toFixed(2)+ 'ha' +'<br> '+s)

			} else if (layer_tinh.getVisibility()){

				dientich = getSumField(tableName,'dientich','id_tinh='+g_lanhtho_selected.getIDTinh());
				if(dientich<0)dientich=0;
				content=('Diện tích xuống giống của '+(g_lanhtho_selected.getTenTinh().indexOf("TP")>=0?"":('tỉnh '+g_lanhtho_selected.getTenTinh())) +' tính theo bản đồ giải đoán ảnh "'+gm.map.getCurrentLayerActivated() +'" là ' +dientich.toFixed(2)+ 'ha' +'<br> '+s)

				
			}
			if(gm.map.getCurrentLayerActivated().indexOf("modis")>=0 ||gm.map.getCurrentLayerActivated().indexOf("Modis")>=0){
				ShowDientichGiaidoanAnhViewer(content);
			}
			else {
				CloseDientichGiaidoanAnhViewer();
			}
			
		},
		/**
		 * 
		 * @param posWKT
		 */ 
		showNangsuat:function(tableName,posWKT){
			
			var dientich=0;
			var content='';
			var s='';
			if (layer_xa.getVisibility()){

				dientich =getSumField(tableName,'dientich','id_xa='+g_lanhtho_selected.getIDXa());
				if(dientich<0)dientich=0;
				s = this._getDientichInfoSelected(ACT_GET_DIENTICH_ON_VIENTHAM_IMG_NS,tableName,posWKT,'id_xa='+g_lanhtho_selected.getIDXa());
				
				content=('Diện tích thu hoạch của xã '+g_lanhtho_selected.getTenXa()+' tính theo bản đồ giải đoán ảnh "'+ gm.map.getCurrentLayerActivated() +'" là '+dientich.toFixed(2)+ 'ha' +'<br> '+s)

			} else if (layer_huyen.getVisibility()){

				dientich =getSumField(tableName,'dientich','id_huyen='+g_lanhtho_selected.getIDHuyen());
				if(dientich<0)dientich=0;
				s = this._getDientichInfoSelected(ACT_GET_DIENTICH_ON_VIENTHAM_IMG_NS,tableName,posWKT,'id_huyen='+g_lanhtho_selected.getIDHuyen());

				content=('Diện tích thu hoạch của huyện '+g_lanhtho_selected.getTenHuyen()+' tính theo bản đồ giải đoán ảnh "'+gm.map.getCurrentLayerActivated() +'" là ' +dientich.toFixed(2)+ 'ha' +'<br> '+s)

			} else if (layer_tinh.getVisibility()){

				dientich = getSumField(tableName,'dientich','id_tinh='+g_lanhtho_selected.getIDTinh());
				if(dientich<0)dientich=0;
				s = this._getDientichInfoSelected(ACT_GET_DIENTICH_ON_VIENTHAM_IMG_NS,tableName,posWKT,'id_tinh='+g_lanhtho_selected.getIDTinh());
				content=('Diện tích thu hoạch của '+(g_lanhtho_selected.getTenTinh().indexOf("TP")>=0?"":('tỉnh '+g_lanhtho_selected.getTenTinh())) +' tính theo bản đồ giải đoán ảnh "'+gm.map.getCurrentLayerActivated() +'" là ' +dientich.toFixed(2)+ 'ha' +'<br> '+s)
				
			}
			if(gm.map.getCurrentLayerActivated().indexOf("modis")>=0 ||gm.map.getCurrentLayerActivated().indexOf("Modis")>=0){
				ShowDientichGiaidoanAnhViewer(content);
			}
			else {
				CloseDientichGiaidoanAnhViewer();
			}
			
		},
		readVienthamImage:function(){
				
				var id_image = $("#dlg_rs_cbanh").val();
				var loaibd_id=  $("#dlg_rs_cbloaibando").val();
				
				var name="";
				if(loaibd_id=="2")
					name="-Sạ cấy";
				else if(loaibd_id=="1")
					name="-Sức khỏe lúa";
				else if(loaibd_id=="3")
					name="-Năng suất";
				
				var error=false;
				var vtLayerName="";
				var vtTableName="";
				$.ajax({url:MAIN_SERVLET ,									
				    data:{ 
					  action: ACT_GET_DATA_TO_VIENTHAM_IMAGE,
					  condition: 'id ='+id_image
					},
					async:false,
				    success:function(jsonData) {
						//alert(jsonData);
					try{	
				    	var jsonObject = JSON.parse(jsonData)
						
						 $("#dlg_rs_txtvientham").html(jsonObject.rows[0].tulieuvientham);
						 $("#dlg_rs_txtphangiai").html(jsonObject.rows[0].dophangiai);
						 $("#dlg_rs_txttenchutri").html(jsonObject.rows[0].tenchuyengia);
						 
						 var ngaychup = jsonObject.rows[0].ghi_chu;
						 $("#dlg_rs_txtngaychup").html(ngaychup);
						
				
						 vtLayerName=jsonObject.rows[0].tulieuvientham+name+' ('+ngaychup+')';
						 vtTableName=jsonObject.rows[0].tenbang;
						 
					}catch(err){
						//alert(err)
						error=true;
	
					}
						return;
				    }
				});
			

			if (error==true) return;
			//remove_image_vientham();
			var newurl =mapserver_url_draw_vientham+"tablename="+vtTableName+'&';
			//alert(newurl)
			
			for (var i=0; i<map.layers.length;i++) {
		  	            var layer = map.layers[i];
		  	            if(layer.name==vtLayerName)
		  	            {
		  	            			return;
		  	            }
		  	}
			
			
			var layer_vientham_in_mapfile= "";
			//alert($("#dlg_rs_cbloaibando").val())
			switch($("#dlg_rs_cbloaibando").val()){
				case "1": 
					layer_vientham_in_mapfile='layer_vientham_htl';
					break;
				case "2": 
					layer_vientham_in_mapfile='layer_vientham_sacay';
					//ẩn chú giải
					$("#div_chugiai_vientham").hide();
					break;
				case "3": //nang suat
					layer_vientham_in_mapfile='layer_vientham_ns';
					//ẩn chú giải
					$("#div_chugiai_vientham").hide();
					break;
			
				default:break;
			
			}
			//alert(layer_vientham_in_mapfile)
			var new_layer    = new OpenLayers.Layer.WMS(vtLayerName,newurl,{layers: layer_vientham_in_mapfile ,transparent: 'true',format: image_format,isBaseLayer: false,visibility: 'false'},{projection:'EPSG:4756',singleTile: true});
			//new_layer.attributes['table_database']='hell atmel';
			new_layer.setVisibility(false);
			map.removeLayer(g_layer_search);
		    map.addLayer(new_layer);	
		    map.addLayer(g_layer_search);
		    this.mapLayer.put(vtLayerName,vtTableName);
		    this.layers.push(new_layer);
		   
		},
		removeVienthamImage:function(){
			//g_vientham_htl_table = null;
			for (var i=0; i <  this.layers.length;i++)
				map.removeLayer( this.layers[i]);
			
			this.layers=[];
  		    this.mapLayer.clear();
			CloseDientichGiaidoanAnhViewer();
		},
		/***
		 * Hiển thị thông tin khi click bản đồ tương ứng với layer dữ liệu đang được kích hoạt
		 */
		showDataInfo:function(postWKT){
			//alert('showDataInfo:'+postWKT);
			
			
			var layerName=gm.map.getCurrentLayerActivated();
			if(layerName.indexOf("Sức khỏe lúa")>=0){
				this.showDientichHTL(this.mapLayer.get(layerName),postWKT);
			}else if(layerName.indexOf("Sạ cấy")>=0){
				this.showDientichSacay(this.mapLayer.get(layerName),postWKT);
			}else if(layerName.indexOf("Năng suất")>=0){
				this.showNangsuat(this.mapLayer.get(layerName),postWKT);
			}
		},
		createTableChugiai:function(title,arrayIDs,arrayNames,arrayColors){
			var s= '<table width="200" border="0" align="center" style="margin-left:40px;">';
			s+= '<tr>';
			s+= '<td colspan="2"><strong style="color:#ffffff;margin-left:10px;">'+title+'</strong></td>';
			s+= '</tr>';
			for(var i=0;i<arrayNames.length;i++){
				s+= '<tr>';
				s+= '<td id="'+arrayIDs[i]+'" width="35" style="background:'+arrayColors[i]+ '">&nbsp;</td>';
				s+= '<td  width="149" ><strong style="color:#ffffff;margin-left:10px;">'+arrayNames[i]+ '</strong></td>';
				s+= '</tr>';
			}
			s+= '</table>'; 
			return s;
		}
};

//NOTE: UNUSED!!!
function CCWRS_GUI(){
	this.panelMaster=null;//panel for search,login
	this.panelSlaveExtruder=null;//panel for report,hien trang,vien tham
	//this.divSectionSlave=[];
	//this.maxSections=6;
}
CCWRS_GUI.prototype = {
		
		_createMainMenuItem:function(options){
			
/*
			    <a class="{action: 'onclick_dieutra_thoitiet()' , img: '', imgClass: 'img_menu investigation_icon1'}">Thông tin thời tiết</a>
			    <a class="{action: 'onclick_dieutra_dotthientai()' , img: '', imgClass: 'img_menu report_icon5'}"> Đợt thiên tai</a>
			    <a class="{action: 'onclick_dieutra_thitruong()' , img: '', imgClass: 'img_menu investigation_icon2'}">Thông tin thị trường</a>
			    <a class="{action: 'onclick_dieutra_thuhoach()' , img: '', imgClass: 'img_menu investigation_icon3'}">Kết quả thu hoạch của tỉnh</a>
			    <a class="{action: 'onclick_dieutra_xa()',  img: '', imgClass: 'img_menu investigation_icon4'}">Điều tra theo xã</a>
			    <a class="{action: 'onclick_dieutra_canhdong()', img: '', imgClass: 'img_menu investigation_icon5'}">Điều tra theo cánh đồng</a>
			    <a class="{action: 'onclick_dieutra_ruong()',  img: '', imgClass: 'img_menu investigation_icon6'}">Điều tra theo ruộng</a>
			 */
               var subItem= "<a class=\"{action:"+options.action+  " ,img:'', imgClass:'"+options.imgClass+ "'}\"/>" + options.title+ "</a>";
                //  alert(subItem);
                options.parent.append(subItem);
        },
		/**
		 * Menu số liệu điều tra
		 */
		_createMenuSolieuDieutra:function(){
			 var divSldt=$("<div id=\"memu_solieudieutra\" class=\"mbmenu\" style=\"height:500px\"></div>");
			 _createMainMenuItem({parent:divSldt,action:'onclick_dieutra_thoitiet()',imgClass:'img_menu investigation_icon1',title:'Thông tin thời tiết'});
			 _createMainMenuItem({parent:divSldt,action:'onclick_dieutra_dotthientai()',imgClass:'img_menu report_icon5',title:'Đợt thiên tai'});
			 _createMainMenuItem({parent:divSldt,action:'onclick_dieutra_thitruong()',imgClass:'img_menu investigation_icon2',title:'Thông tin thị trường'});
			 _createMainMenuItem({parent:divSldt,action:'onclick_dieutra_thuhoach()',imgClass:'img_menu investigation_icon3',title:'Kết quả thu hoạch của tỉnh'});
			 _createMainMenuItem({parent:divSldt,action:'onclick_dieutra_xa()',imgClass:'img_menu investigation_icon4',title:'Điều tra theo xã'});				
			 _createMainMenuItem({parent:divSldt,action:'onclick_dieutra_canhdong()',imgClass:'img_menu investigation_icon5',title:'Điều tra theo cánh đồng'});
			 _createMainMenuItem({parent:divSldt,action:'onclick_dieutra_ruong()',imgClass:'img_menu investigation_icon6',title:'Điều tra theo ruộng'});
			
			    
		},
		/**
		 * Menu số liệu ít biến động
		 */
		_createMenuSlibd:function(){
			 var divSlidt=$("<div id=\"memu_solieuitbiendong\" class=\"mbmenu\" style=\"height:500px\"></div>");
			 _createMainMenuItem({parent:divSlidt,action:'onsubmenu_add_xa_slibd_gionglua()',imgClass:'img_menu static_icon1',title:'Giống lúa'});
			 _createMainMenuItem({parent:divSlidt,action:'onsubmenu_add_xa_slibd_phanbon()',imgClass:'img_menu static_icon2',title:'Phân bón'});
			 _createMainMenuItem({parent:divSlidt,action:'onsubmenu_add_xa_slibd_thuocBVTV()',imgClass:'img_menu static_icon4',title:'Thuốc BVTV'});
			 _createMainMenuItem({parent:divSlidt,action:'onsubmenu_add_xa_slibd_sauhai()',imgClass:'img_menu static_icon5',title:'Sâu hại'});
			 _createMainMenuItem({parent:divSlidt,action:'onsubmenu_add_xa_slibd_dichbenh()',imgClass:'img_menu static_icon6',title:'Bệnh hại'});				
			 _createMainMenuItem({parent:divSlidt,action:'onsubmenu_add_xa_slibd_visinhvat()',imgClass:'img_menu static_icon3',title:'Vi sinh vật đối kháng'});
			 _createMainMenuItem({parent:divSlidt,action:'onsubmenu_add_xa_slibd_thiendich()',imgClass:'img_menu static_icon7',title:'Thiên địch'});
			 _createMainMenuItem({parent:divSlidt,action:'onsubmenu_add_xa_slibd_hientuonggayhai()',imgClass:'img_menu report_icon4',title:'Hiện tượng gây hại'});
				
		
	
			
		},
		/**
		 * Menu báo cáo thống kê
		 */
		_createMenuBaocaoThongke:function(){
			 var divBaocao=$("<div id=\"menu_baocaothongke\" class=\"mbmenu\" style=\"height:500px\"></div>");
			 _createMainMenuItem({parent:divBaocao,action:'onclick_report_tiendosanxuat()',imgClass:'img_menu investigation_icon4',title:'Tiến độ sản xuất'});
			 _createMainMenuItem({parent:divBaocao,action:'onclick_report_cocaugionglua()',imgClass:'img_menu report_icon1',title:'Tiến độ gieo cấy'});
			 _createMainMenuItem({parent:divBaocao,action:'onclick_report_tiendothuhoach()',imgClass:'img_menu report_icon6',title:'Tiến độ thu hoạch'});
			 _createMainMenuItem({parent:divBaocao,action:'onclick_report_thongtinthientai()',imgClass:'img_menu report_icon5',title:'Thông tin thiên tai'});
			 _createMainMenuItem({parent:divBaocao,action:'onclick_report_hientranglua()',imgClass:'img_menu report_icon2',title:'Hiện trạng lúa'});				
			 _createMainMenuItem({parent:divBaocao,action:'onclick_report_thongtindichhai()',imgClass:'img_menu static_icon5',title:'Tình hình dịch hại'});
			 _createMainMenuItem({parent:divBaocao,action:'onclick_menu_buildgraph()',imgClass:'img_menu report_icon2',title:'Xây dựng đồ thị'});

		},
		/**
		 * Menu bản đồ hiện trạng
		 */
		_createMenuBandoHientrang:function(){
			 var divBando=$("<div id=\"menu_baocaothongke\" class=\"mbmenu\" style=\"height:500px\"></div>");
			 _createMainMenuItem({parent:divBando,action:'onclick_bandohientrang_ccgl()',imgClass:'img_menu report_icon1',title:'Bản đồ cơ cấu giống lúa'});
			 _createMainMenuItem({parent:divBando,action:'onclick_bandohientrang_htlua()',imgClass:'img_menu report_icon2',title:'Tiến độ gieo cấy'});
			 _createMainMenuItem({parent:divBando,action:'onclick_bandohientrang_nuoc()',imgClass:'img_menu report_icon3',title:'Tiến độ thu hoạch'});
			 _createMainMenuItem({parent:divBando,action:'onclick_bandohientrang_dichhai()',imgClass:'img_menu report_icon4',title:'Thông tin thiên tai'});
			 _createMainMenuItem({parent:divBando,action:'onclick_bandohientrang_thientai()',imgClass:'img_menu report_icon5',title:'Hiện trạng lúa'});				
			 _createMainMenuItem({parent:divBando,action:'onclick_bandohientrang_nangsuat()',imgClass:'img_menu report_icon6',title:'Tình hình dịch hại'});
			
			 /* 
			 *  <!--BEGIN BAN DO HIEN TRANG -->  
  <div id="menu_bandohientrang" class="{action: 'alert()'} style="height:500px">
     <a rel="text">
     <!--   <img src="image/static/thiendich.png" alt="img" style="position:absolute;margin-top:0px; margin-left:-25px;margin-bottom:0px"/><br/>
   	-->
    </a>
    <a class="{action: 'onclick_bandohientrang_ccgl()' , img: '', imgClass: 'img_menu report_icon1'}">Bản đồ cơ cấu giống lúa</a>
    <a class="{action: 'onclick_bandohientrang_htlua()' , img: '', imgClass: 'img_menu report_icon2'}">Bản đồ hiện trạng sức khỏe lúa</a>
    <a class="{action: 'onclick_bandohientrang_nuoc()',  img: '', imgClass: 'img_menu report_icon3'}">Bản đồ phân bố nguồn nước tưới</a>
    <a class="{action: 'onclick_bandohientrang_dichhai()', img: '', imgClass: 'img_menu report_icon4'}">Bản đồ dịch hại</a>
    <a class="{action: 'onclick_bandohientrang_thientai()',  img: '', imgClass: 'img_menu report_icon5'}">Bản đồ thiên tai</a> 
    <a class="{action: 'onclick_bandohientrang_nangsuat()',  img: '', imgClass: 'img_menu report_icon6'}">Bản đồ năng suất lúa</a>

  </div>
  <!--END  BAN DO HIEN TRANG --> */
			
		},
		
		/**
		 *Menu chính (ngang) 
		 */
		createMainMenu:function(){
			var mainMenu=$("<div id=\"mainmenu_horizontal_content\"></div>");
			$("body").append(mainMenu);
			
			//Tao
		},
		createSlaveExtruder:function(options){
	//		alert('22222222222222222222222')
			 if(this.panelSlaveExtruder!=null)return;
			 
			 //create div
			  this.panelSlaveExtruder=$("<div id=\""+"panelSlaveExtruder"+"\" class=\"{title:'"+ "title"+"'}\"/>");
			 //add to div map
			   $('#map').append(this.panelSlaveExtruder);
			  // dlg_report_query
			  // $('#dlg_report_query').append(this.panelSlaveExtruder);
			 //tạo & add sẵn 4 div section to DIV panelSlaveExtruder
			   /*for(var i=0;i<this.maxSections;i++){
		        var subDiv= $("<div id=\"panelSlaveExtruder_subdiv"+i+"\" style=\"margin-left:50px;margin-right:10px;position:absolute;\">  </div>"); 
		        this.divSectionSlave.push("panelSlaveExtruder_subdiv"+i);
		        this.panelSlaveExtruder.append(subDiv);
			   }*/
			   
			  this.panelSlaveExtruder.buildMbExtruder({
				    position:"left",
				    //width:options.width,
				    extruderOpacity:0.8, 
				    top:1000, 
				    positionFixed: false,	    
				    closeOnExternalClick:false,
				    hidePanelsOnClose:true,
				    accordionPanels:true,
				    onExtOpen:function(){
				  
				    },
				    onExtContentLoad:function(){},
				    onExtClose:function(){}
				  });	 
			   
		 },
		 openSlaveExtruder:function(){
			 if(this.panelSlaveExtruder==null){
				 this.createSlaveExtruder();
				 //return;
			 }
			 this.panelSlaveExtruder.openMbExtruder();
		 },
		 closeSlaveExtruder:function(){
			 this.panelSlaveExtruder.closeMbExtruder();
		 },
		 /**
		  * 
		  * @param flapOpts
		  * @param extruderOpts
		  * 		set css: width,opacity...
		  * @param contentOpts
		  * 		
		  */
		 setSlaveExtruderOptions:function(flapOpts,extruderOpts,contentOpts){
	//		 alert('111111111111');
			// var width=options.width;
			// var opacity=options.opacity;
			// var titleFlap=options.titleFlap;
			// var titleMain=options.titleMain;
			 if(this.panelSlaveExtruder==null){
				 this.createSlaveExtruder();
				 //return;
			 }
		//	alert( this.panelSlaveExtruder.html());
			/*if(contentOpts.sections){
				for(var i=0;i<this.maxSections;i++){
					$("#"+this.divSectionSlave[i]).hide();
				}
				for(var i=0;i<contentOpts.sections;i++){
					
					$("#"+this.divSectionSlave[i]).css({background:"rgb(0, 0, 0)"})
					$("#"+this.divSectionSlave[i]).corner();	
					$("#"+this.divSectionSlave[i]).css({width:200,height:200,background:"rgba(2, 0, 0, 0.80)"})
					$("#"+this.divSectionSlave[i]).show();
				}
			}*/
		     
			 this.panelSlaveExtruder.find('.content').css(extruderOpts);
			 this.panelSlaveExtruder.find(".flapLabel").html(flapOpts).css({whiteSpace:"noWrap"});//,height:this.options.flapDim
			 var orientation= this.panelSlaveExtruder.getOptions().textOrientation == "tb";
			 var labelH=this.panelSlaveExtruder.find('.flapLabel').getFlipTextDim()[1];
			 this.panelSlaveExtruder.find('.flapLabel').mbFlipText(orientation);
		 }
			
		 
		 
}

/**
 * =======DỰ BÁO
***/
function CCWRS_DuBao(){
	this.mapLayer=new Map();
	this.layers=[];
	
	this.chugiai_chatluongdat = null;//this.CreateTableChugiaiTpl_ChatLuongDat();
	//this.chugiai_nangsuat = this.CreateTableChugiaiTpl_NangSuat();
	
}
CCWRS_DuBao.prototype = {
		
		registerEvents:function(){
			//init
	 		if( $("#div_db_rs_chugiai_chatluongdat").is(':empty'))
	 		{
	 			this.chugiai_chatluongdat = this.CreateTableChugiaiTpl_ChatLuongDat();
	 			$("#div_db_rs_chugiai_chatluongdat").html(this.chugiai_chatluongdat);
	 		
	 		}
	 		if( $("#div_db_rs_chugiai_nangsuat").is(':empty'))
	 		{
	 			this.chugiai_nangsuat = this.CreateTableChugiaiTpl_NangSuat();
	 			$("#div_db_rs_chugiai_nangsuat").html(this.chugiai_nangsuat);
	 			
	 		}
			
			//attack a click event on all radio buttons with name 'dlg_main_graph_radio'
			$("input[name=db_rs_maptype_options]:radio").click(function() {
				 switch($(this).val()){
				 	case "1"://chat luong dat lua

				 		 $("#div_db_rs_chugiai_chatluongdat").show();
				 		 $("#div_db_rs_chugiai_nangsuat").hide();
				 		
				 		$("#extruder_dubao_textboxdate").attr("disabled",true);
				 		$('#extruder_dubao_textboxdate').datebox({
				 		    disabled:true
				 		});
				 		 
				 		


				 		break;
				 	case "2": //nang suat lua
				 		 $("#div_db_rs_chugiai_chatluongdat").hide();
				 		 $("#div_db_rs_chugiai_nangsuat").show();
				 		$('#extruder_dubao_textboxdate').datebox({
				 		    disabled:false
				 		});	
				 		 $("#extruder_dubao_textboxdate").attr("disabled",false);
				 		break;
				 }
			});
			
			$('#extruder_dubao_textboxdate').datebox('setValue',g_rtc.string);



		},

		/**
		 * Trả về một chuỗi chứa thông tin về các loại diện tích:tốt, khá(hiện trạng lúa),năng suất(a-b tấn/ha có diện tích là X...)
		 * @param action
		 * 			ACT_GET_DIENTICH_ON_VIENTHAM_IMG_NS -> năng suất, ACT_GET_DIENTICH_ON_VIENTHAM_IMG_HTL -> hiện trạng lúa...
		 * @param table
		 * 			tên bảng tương ứng với ảnh modis
		 * @param posWKT
		 * 				unused
		 * @param condition
		 * 			thường sử dụng id tỉnh,huyện,xã để lọc tính diện tích
		 * @returns
		 * 		{string}
		 */
		_getDientichInfoSelected:function(action,table,posWKT,condition){
			 var s = null;
			 $.ajax({
						url: REPORT_SERVLET ,
						type: "POST",
						data:
					    { 
						  action: action,//ACT_GET_DIENTICH_ON_VIENTHAM_IMG_NS,
						  //position: posWKT,
						  table:table,
						  condition:condition
						},
						 async:false,
						 error: function (request, status, error) {
						        alert(request.responseText);
						    },
						 success:function(_s) {
							 s = _s;
							return s;
					    }});
			 
			 return s;
		},
		readVienthamImage:function(){
			
			var time_str = $('#extruder_vientham_textboxdate').datebox('getValue');
			//var oDate = gm.date.string2Date(time_str, g_dfDefault);	
			alert(111);
			var jsDate = gm.date.stringToJSONDate(time_str, g_dfDefault);
			alert(jsDate.doy);
			if (!Utils.isValidateDMY(time_str)){msgerror('Hãy chọn thời gian để tạo bản đồ ');return;}		
	
				var name="";
				if(loaibd_id=="2")
					name="-Sạ cấy";
				else if(loaibd_id=="1")
					name="-Sức khỏe lúa";
				else if(loaibd_id=="3")
					name="-Năng suất";
				
				var error=false;
				var vtLayerName="";
				var vtTableName="";
				$.ajax({url:MAIN_SERVLET ,									
				    data:{ 
					  action: ACT_GET_DATA_TO_VIENTHAM_IMAGE,
					  condition: 'id ='+id_image
					},
					async:false,
				    success:function(jsonData) {
						//alert(jsonData);
					try{	
				    	var jsonObject = JSON.parse(jsonData)
						
						 $("#dlg_rs_txtvientham").html(jsonObject.rows[0].tulieuvientham);
						 $("#dlg_rs_txtphangiai").html(jsonObject.rows[0].dophangiai);
						 $("#dlg_rs_txttenchutri").html(jsonObject.rows[0].tenchuyengia);
						 
						 var ngaychup = jsonObject.rows[0].ghi_chu;
						 $("#dlg_rs_txtngaychup").html(ngaychup);
						
				
						 vtLayerName=jsonObject.rows[0].tulieuvientham+name+' ('+ngaychup+')';
						 vtTableName=jsonObject.rows[0].tenbang;
						 
					}catch(err){
						//alert(err)
						error=true;
	
					}
						return;
				    }
				});
			

			if (error==true) return;
			//remove_image_vientham();
			var newurl =mapserver_url_draw_vientham+"tablename="+vtTableName+'&';
			//alert(newurl)
			
			for (var i=0; i<map.layers.length;i++) {
		  	            var layer = map.layers[i];
		  	            if(layer.name==vtLayerName)
		  	            {
		  	            			return;
		  	            }
		  	}
			
			
			var layer_vientham_in_mapfile= "";
			//alert($("#dlg_rs_cbloaibando").val())
			switch($("#dlg_rs_cbloaibando").val()){
				case "1": 
					layer_vientham_in_mapfile='layer_vientham_htl';
					break;
				case "2": 
					layer_vientham_in_mapfile='layer_vientham_sacay';
					//ẩn chú giải
					$("#div_chugiai_vientham").hide();
					break;
				case "3": //nang suat
					layer_vientham_in_mapfile='layer_vientham_ns';
					//ẩn chú giải
					$("#div_chugiai_vientham").hide();
					break;
			
				default:break;
			
			}
			//alert(layer_vientham_in_mapfile)
			var new_layer    = new OpenLayers.Layer.WMS(vtLayerName,newurl,{layers: layer_vientham_in_mapfile ,transparent: 'true',format: image_format,isBaseLayer: false,visibility: 'false'},{projection:'EPSG:4756',singleTile: true});
			//new_layer.attributes['table_database']='hell atmel';
			new_layer.setVisibility(false);
			map.removeLayer(g_layer_search);
		    map.addLayer(new_layer);	
		    map.addLayer(g_layer_search);
		    this.mapLayer.put(vtLayerName,vtTableName);
		    this.layers.push(new_layer);
		   
		},
		removeVienthamImage:function(){

			layer_ruong_hientrang.setVisibility(false);
			
			 $("#id_dt_db_chatluongdat10").html('');
		      $("#id_dt_db_chatluongdat9").html('');
		      $("#id_dt_db_chatluongdat8").html('');
		      $("#id_dt_db_chatluongdat7").html('');
		      $("#id_dt_db_chatluongdat6").html('');
		      $("#id_dt_db_chatluongdat5").html('');
		      $("#id_dt_db_chatluongdat4").html('');
		      $("#id_dt_db_chatluongdat3").html('');
		      $("#id_dt_db_chatluongdat2").html('');
		      $("#id_dt_db_chatluongdat1").html('');

			      $("#id_dt_db_ns10").html('');
			      $("#id_dt_db_ns9").html('');
			      $("#id_dt_db_ns8").html('');
			      $("#id_dt_db_ns7").html('');
			      $("#id_dt_db_ns6").html('');
			      $("#id_dt_db_ns5").html('');
			      $("#id_dt_db_ns4").html('');
			      $("#id_dt_db_ns3").html('');
			      $("#id_dt_db_ns2").html('');
			      $("#id_dt_db_ns1").html('');
			    
		},
		/***
		 * Hiển thị thông tin khi click bản đồ tương ứng với layer dữ liệu đang được kích hoạt
		 */
		showDataInfo:function(postWKT){
			//alert('showDataInfo:'+postWKT);
			
			
			var layerName=gm.map.getCurrentLayerActivated();
			if(layerName.indexOf("Sức khỏe lúa")>=0){
				this.showDientichHTL(this.mapLayer.get(layerName),postWKT);
			}else if(layerName.indexOf("Sạ cấy")>=0){
				this.showDientichSacay(this.mapLayer.get(layerName),postWKT);
			}else if(layerName.indexOf("Năng suất")>=0){
				this.showNangsuat(this.mapLayer.get(layerName),postWKT);
			}
		},
		createTableChugiai:function(title,arrayIDs,arrayNames,arrayColors){
			var s= '<table width="200" border="0" align="center" style="margin-left:40px;">';
			s+= '<tr>';
			s+= '<td colspan="2"><strong style="color:#ffffff;margin-left:10px;">'+title+'</strong></td>';
			s+= '</tr>';
			for(var i=0;i<arrayNames.length;i++){
				s+= '<tr>';
				s+= '<td id="'+arrayIDs[i]+'" width="35" style="background:'+arrayColors[i]+ '">&nbsp;</td>';
				s+= '<td  width="149" ><strong style="color:#ffffff;margin-left:10px;">'+arrayNames[i]+ '</strong></td>';
				s+= '</tr>';
			}
			s+= '</table>'; 
			return s;
		},
		/**
			 * Tạo table template chú giải nang suat lua
			 * @param title
			 * @param arrayIDs
			 * @param arrayNames
			 * @param arrayColors
			 * @returns {String}
			 */
			CreateTableChugiaiTpl_NangSuat:function(/*title,arrayIDs,arrayNames,arrayColors*/){
				 var title = "-------------------";
				 var arrayIDs =  [
						    '1',
						    '2',
						    '3',
						    '4',
						    '5',
						    '6',
						    '7',
						    '8',
						    '9',
						    '10',
						    ];
				 
				 var arrayNames = [
						    "91-100",
						    "81-90",
						    "71-80",
						    "61-70",
						    "51-60",
						    "41-50",
						    "31-40",
						    "21-30",
						    "11-20",
						    " 1-10"
						    ];
				var arrayColors = [
						     gm.utils.rgbToHex(0, 64, 0),
						     gm.utils.rgbToHex(0, 128, 0),
						     gm.utils.rgbToHex(0, 187, 0),
						     gm.utils.rgbToHex(0,230,0),
						     gm.utils.rgbToHex(0, 255,0),
						     gm.utils.rgbToHex(123,221,34),
						     gm.utils.rgbToHex(199,228,27),
						     gm.utils.rgbToHex(234,191,21),
						     gm.utils.rgbToHex(243,163,12),
						     gm.utils.rgbToHex(250,109,15)
						     ];
				var arrayDientich = [
								    "id_dt_db_ns10",
								    "id_dt_db_ns9",
								    "id_dt_db_ns8",
								    "id_dt_db_ns7",
								    "id_dt_db_ns6",
								    "id_dt_db_ns5",
								    "id_dt_db_ns4",
								    "id_dt_db_ns3",
								    "id_dt_db_ns2",
								    "id_dt_db_ns1",
								    
								     ];		
				//set to parent
				
				var s= '<table width="200" border="0" align="center" style="margin-left:40px;">';
				//s+= '<td colspan="2"><strong style="color:#ffffff;margin-left:10px;">'+title+'</strong></td>';
				s+= '<tr>';
				s+= '  <td width="40"><b style="color:#d7d7d7;">NS dự báo(%)</b></td>';
				s+= '  <td width="40"><b style="color:#d7d7d7;">Màu tô</b></td>';
				s+= '  <td width="25" align="right"><b style="color:#d7d7d7;">D.tích (ha)</b></td>';
				s+= '</tr>';

				for(var i=0;i<arrayNames.length;i++){
					s+= '<tr>';
					s+= '<td  width="40" ><strong style="color:#ffffff;margin-left:10px;">'+arrayNames[i]+ '</strong></td>';
					s+= '<td id="'+arrayIDs[i]+'" width="30" style="background:'+arrayColors[i]+ '">&nbsp;</td>';
					s+= '<td  width="40" align="right"><strong id='+arrayDientich[i]+' style="color:#ffffff;margin-left:10px;">'+'-'+ '</strong></td>';
					s+= '</tr>';
				}
				s+= '</table>'; 
				return s;
			},
		/**
		 * Tạo table template chú giải chat luong dat lua
		 * @param title
		 * @param arrayIDs
		 * @param arrayNames
		 * @param arrayColors
		 * @returns {String}
		 */
		CreateTableChugiaiTpl_ChatLuongDat:function(/*title,arrayIDs,arrayNames,arrayColors*/){
			 var title = "AAAA";
			 var arrayIDs =  [
					    '1',
					    '2',
					    '3',
					    '4',
					    '5',
					    '6',
					    '7',
					    '8',
					    '9',
					    '10',
					    ];
			 
			 var arrayNames = [
					    "10",
					    "9",
					    "8",
					    "7",
					    "6",
					    "5",
					    "4",
					    "3",
					    "2",
					    "1"
					    ];
			var arrayColors = [
					     gm.utils.rgbToHex(0, 64, 0),
					     gm.utils.rgbToHex(0, 128, 0),
					     gm.utils.rgbToHex(0, 187, 0),
					     gm.utils.rgbToHex(0,230,0),
					     gm.utils.rgbToHex(0, 255,0),
					     gm.utils.rgbToHex(123,221,34),
					     gm.utils.rgbToHex(199,228,27),
					     gm.utils.rgbToHex(234,191,21),
					     gm.utils.rgbToHex(243,163,12),
					     gm.utils.rgbToHex(250,109,15)
					     ];
			var arrayDientich = [
							    "id_dt_db_chatluongdat10",
							    "id_dt_db_chatluongdat9",
							    "id_dt_db_chatluongdat8",
							    "id_dt_db_chatluongdat7",
							    "id_dt_db_chatluongdat6",
							    "id_dt_db_chatluongdat5",
							    "id_dt_db_chatluongdat4",
							    "id_dt_db_chatluongdat3",
							    "id_dt_db_chatluongdat2",
							    "id_dt_db_chatluongdat1",
							    
							     ];		
			//set to parent
			
			var s= '<table width="200" border="0" align="center" style="margin-left:40px;">';
			//s+= '<td colspan="2"><strong style="color:#ffffff;margin-left:10px;">'+title+'</strong></td>';
			s+= '<tr>';
			s+= '  <td width="40"><b style="color:#d7d7d7;">Cấp độ</b></td>';
			s+= '  <td width="40"><b style="color:#d7d7d7;">Màu tô</b></td>';
			s+= '  <td width="25" align="right"><b style="color:#d7d7d7;">D.tích (ha)</b></td>';
			s+= '</tr>';

			for(var i=0;i<arrayNames.length;i++){
				s+= '<tr>';
				s+= '<td  width="40" ><strong style="color:#ffffff;margin-left:10px;">'+arrayNames[i]+ '</strong></td>';
				s+= '<td id="'+arrayIDs[i]+'" width="30" style="background:'+arrayColors[i]+ '">&nbsp;</td>';
				s+= '<td  width="40" align="right"><strong id='+arrayDientich[i]+' style="color:#ffffff;margin-left:10px;">'+'-'+ '</strong></td>';
				s+= '</tr>';
			}
			s+= '</table>'; 
			return s;
		},
		OnMapClick:function(posWKT){
			
			if(g_fn_selected == FN_DUBAO_VT){
				this.OnDuBaoVT(posWKT);
			}
		},
		OnDuBaoVT:function(posWKT){
			
			var table = '';
			var id = '';
			if (layer_xa.getVisibility()){
				table = 'tbl_xa_region';
				id = 'xa_id';
			} else if (layer_huyen.getVisibility()) {
				table = 'tbl_huyen_region';
				id = 'huyen_id';
			} else {
				table = 'tbl_tinh_region';
				id = 'tinh_id';	
			}
			getLanhthoClicked( 'tbl_xa_region','xa_id',posWKT);
			

		
			//alert($('input:radio[name=rs_maptype_options]:checked').val());
			//alert($('#rs_checkbox_taomap').attr('checked')?1:0);
			//alert($('#rs_checkbox_showdientich').attr('checked')?1:0);
			if($('input:radio[name=db_rs_maptype_options]:checked').val() != undefined){
				map_type = $('input:radio[name=db_rs_maptype_options]:checked').val();
			}else {
				map_type = -1;
			}
			var jsDate = gm.date.stringToJSONDate(g_rtc.string, g_dfDefault);
			if(parseInt(map_type)==2){
				var time_str = $('#extruder_dubao_textboxdate').datebox('getValue');
				jsDate = gm.date.stringToJSONDate(time_str, g_dfDefault);
				if (!Utils.isValidateDMY(time_str)){msgerror('Hãy chọn thời gian để tạo bản đồ ');return;}	
			}
			if(map_type == -1){
				msgerror('Hãy chọn kiểu lập bản đồ ');
				return;
			}
			
		/*	var bBuildMap;
			var bShowDT ;
			
			if ($('#rs_checkbox_taomap').is(':checked')) {
				bBuildMap = 1;
			} else {
				bBuildMap = 0;
			} 
			if ($('#rs_checkbox_showdientich').is(':checked')) {
				bShowDT = 1;
			} else {
				bShowDT = 0;
			} */
			//var vulua = gm.cbb.getValue("rs_cbbvulua");

		//	if(bBuildMap == 0)map_type = -1;
		//	if(bShowDT == 0) vulua = -1;
			//alert(map_type);
			 var isRendered = false;
			 var mapFile = '';
			 $.ajax({
						url: RENDER_SERVLET ,
						type: "POST",
						data:
					    { 
						  action: ACT_RENDER_MAP_DUBAO,
						  position: posWKT,
						  table:table,
						  id:id,
						  year: jsDate.year,
						  month:jsDate.month,
						  day:jsDate.day,
						  //time_int:time_int,//vd time 01/01/2012 to 15340
						  //doy: jsDate.doy, //day of year (1 -> 365)
						  opts_map_type: map_type, //chat luong dat lua, nang suat lua
						  //vulua: vulua
						},
						 async:false,
						 success:function(data) {
							 //window.open(url,"Download");
							 //alert('data:'+data);
							 if (data != "" && data != "null"){
								 isRendered = true;
							    var jsonObject = JSON.parse(data);
							    mapFile = jsonObject.data[0].map_file;
							    //alert(mapFile);
							    //g_div_chugiai_flip = jsonObject.data[0].div;
							   // $('#div_chugiai_vientham').html(g_div_chugiai_flip);	
							  
							   
							    if(map_type == 1){
							    	 var str_arraydt = jsonObject.data[0].dt_by_capdo;
							    	 var array_dt_cld = str_arraydt.split(",");
							      $("#id_dt_db_chatluongdat10").html(array_dt_cld[9]);
							      $("#id_dt_db_chatluongdat9").html(array_dt_cld[8]);
							      $("#id_dt_db_chatluongdat8").html(array_dt_cld[7]);
							      $("#id_dt_db_chatluongdat7").html(array_dt_cld[6]);
							      $("#id_dt_db_chatluongdat6").html(array_dt_cld[5]);
							      $("#id_dt_db_chatluongdat5").html(array_dt_cld[4]);
							      $("#id_dt_db_chatluongdat4").html(array_dt_cld[3]);
							      $("#id_dt_db_chatluongdat3").html(array_dt_cld[2]);
							      $("#id_dt_db_chatluongdat2").html(array_dt_cld[1]);
							      $("#id_dt_db_chatluongdat1").html(array_dt_cld[0]);
							    } else if(map_type == 2){
							    	 var str_arraydt = jsonObject.data[0].dt_by_ns;
							    	 var array_dt_ns = str_arraydt.split(",");
								      $("#id_dt_db_ns10").html(array_dt_ns[9]);
								      $("#id_dt_db_ns9").html(array_dt_ns[8]);
								      $("#id_dt_db_ns8").html(array_dt_ns[7]);
								      $("#id_dt_db_ns7").html(array_dt_ns[6]);
								      $("#id_dt_db_ns6").html(array_dt_ns[5]);
								      $("#id_dt_db_ns5").html(array_dt_ns[4]);
								      $("#id_dt_db_ns4").html(array_dt_ns[3]);
								      $("#id_dt_db_ns3").html(array_dt_ns[2]);
								      $("#id_dt_db_ns2").html(array_dt_ns[1]);
								      $("#id_dt_db_ns1").html(array_dt_ns[0]);
								    }
					
							    showPanel_createchugiai();
							 } //else alert('Data returned:'+data);
							
							return data;  
					    }});
			 
			 if(map_type != -1){
				if (isRendered == true){
					
					var url = mapserver_url_draw_hientrang.replace('<o>', mapFile);
					//msginfo('Tạo bản đồ hiện trạng thành công!');
					ShowMessageCreateMapSuccess('Bản đồ dự báo đang được tạo...');
					var currentime = new Date().getTime();
				 	layer_ruong_hientrang.url = url+'&random='+currentime;
				 	// cwrs_debug("map file url: "+ url);
		 		    //alert("map file url: "+ layer_ruong_hientrang.url);
				 	layer_ruong_hientrang.redraw();
				 	layer_ruong_hientrang.setVisibility(true);

				} else {
					 msgwarning('Hệ thống không xây dựng được bản đồ hiện trạng (không có dữ liệu hoặc dữ liệu không hợp lệ)');

				}
			 }
			 
			
			
		},
		OnDuBaoHQH:function(posWKT){
			
			var table = '';
			var id = '';
			if (layer_xa.getVisibility()){
				table = 'tbl_xa_region';
				id = 'xa_id';
			} else if (layer_huyen.getVisibility()) {
				table = 'tbl_huyen_region';
				id = 'huyen_id';
			} else {
				table = 'tbl_tinh_region';
				id = 'tinh_id';	
			}
			getLanhthoClicked( 'tbl_xa_region','xa_id',posWKT);
			
			if($('input:radio[name=db_rs_maptype_options]:checked').val() != undefined){
				map_type = $('input:radio[name=db_rs_maptype_options]:checked').val();
			}else {
				map_type = -1;
			}
			var jsDate = gm.date.stringToJSONDate(g_rtc.string, g_dfDefault);
			if(parseInt(map_type)==2){
				var time_str = $('#extruder_dubao_textboxdate').datebox('getValue');
				jsDate = gm.date.stringToJSONDate(time_str, g_dfDefault);
				if (!Utils.isValidateDMY(time_str)){msgerror('Hãy chọn thời gian để tạo bản đồ ');return;}	
			}
			$.ajax({
					url: RENDER_SERVLET ,
					type: "POST",
					data:
					{ 
						action: ACT_RENDER_MAP_DUBAO,
						position: posWKT,
						table:table,
						id:id,
						year: jsDate.year,
						month:jsDate.month,
						day:jsDate.day,
						opts_map_type: map_type, //chat luong dat lua, nang suat lua
					},
					async:false,
					success:function(data){
						//window.open(url,"Download");
						//alert('data:'+data);
						if (data != "" && data != "null"){
							 isRendered = true;
							 var jsonObject = JSON.parse(data);
							 mapFile = jsonObject.data[0].map_file;
							 return data;  
						}
				   }
						
			 });
			
		}
};

