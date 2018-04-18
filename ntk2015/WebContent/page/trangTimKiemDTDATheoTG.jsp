<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
         
<div style="padding: 10px 0 0 15px">

    <span style="color: #B5250A;
  font: bold 15px Verdana,Arial,sans-serif;
  margin: 0;
  text-decoration: underline;
  text-transform: uppercase;
  margin-bottom: 12px;" >Tìm kiếm theo sản phẩm</span>
<br><br>
    <strong>Nhóm đề tài</strong>
    <select name="dlg_detai_duan_TG_cbb" id="dlg_detai_duan_TG_cbb" ></select>
    <br><br>
     <strong>Tình trạng</strong>
    <select name="dlg_detai_duan_TG_tinhtrang_cbb" id="dlg_detai_duan_TG_tinhtrang_cbb" >
    		<option value="-1">Tất cả</option>
    		<option value="0">Được phê duyệt</option>
    		<option value="1">Đang thực hiện</option>
    		<option value="2">Đã nghiệm thu</option>
    
    </select>
    <br><br>
    <strong>Thời gian bắt đầu</strong>
    <input  id="dl_detai_duan_TG_tg_dau" style="margin-bottom: 13px; height: 24px" class="datepicker" >
    <br>
    <strong>Thời gian kết thúc</strong>
    <input  id="dl_detai_duan_TG_tg_ketthuc" style="margin-bottom: 13px; height: 24px" class="datepicker"  >
    <br>
    <a class="btn_tim" onclick="findDT_theodieukien();" href="javascript:;"> Tìm theo quãng thời gian </a>
    <br><br>
    <strong>Tìm đề tài</strong>
    <input  id="dl_detai_duan_TG_find" style="margin-bottom: 13px; height: 24px" >
    <a class="btn_tim" onclick="findDT();" href="javascript:;"> Tìm theo tên </a>
	<table id="dlg_detai_duan_TG_show_datagrid"></table>
</div>

<script>
    var id_phannhom;
    var ngay_bd = 0;
    var ngay_kt = 0;
	$(document).ready(function() {
		
		$('.datepicker').datepicker({
					dateFormat: "dd/mm/yy",
					changeMonth : true,
					changeYear : true,
					yearRange : '2015:2025',
		}).attr("readonly","readonly");
	    $(".datepicker").datepicker("setDate",  new Date());
		
        cwrs_Data2ComboBox( HOME_SERVLET, ACT_GET_NHOM_DETAI_DUAN_TO_CBB, null, TYPE_DATA_HTML_CBB,'Tất cả', 'dlg_detai_duan_TG_cbb');
	   
	});
	
	  function findDT_theodieukien(){
		  ngay_bd = $('#dl_detai_duan_TG_tg_dau').val();
	      ngay_kt = $('#dl_detai_duan_TG_tg_ketthuc').val();
	      id_phannhom = $('#dlg_detai_duan_TG_cbb').val();
	      var id_tinhtrang =  $('#dlg_detai_duan_TG_tinhtrang_cbb').val();
	      
	      if(id_phannhom == -1){
	    	  if(id_tinhtrang == -1){
	    		  getval_detai_duan_TG_show(" ngaythuchien BETWEEN " + gm.date.stringDate2Int(ngay_bd) + " and " + gm.date.stringDate2Int(ngay_kt) );
	    	  }else{
	    		  getval_detai_duan_TG_show("tinhtrang=" + id_tinhtrang + " and ngaythuchien BETWEEN " + gm.date.stringDate2Int(ngay_bd) + " and " + gm.date.stringDate2Int(ngay_kt) );
	    	  }
	      }else{
	    	  if(id_tinhtrang == -1){
	    		  getval_detai_duan_TG_show( "id_phannhom_detai_duan=" + id_phannhom + "and ngaythuchien BETWEEN " + gm.date.stringDate2Int(ngay_bd) + " and " + gm.date.stringDate2Int(ngay_kt) );
	    	  }else{
	    		  getval_detai_duan_TG_show("id_phannhom_detai_duan=" + id_phannhom + "and tinhtrang=" + id_tinhtrang + " and ngaythuchien BETWEEN " + gm.date.stringDate2Int(ngay_bd) + " and " + gm.date.stringDate2Int(ngay_kt) );
	    	  }
	      }
	  } 	
	

  function findDT(){
	  var tukhoa = document.getElementById("dl_detai_duan_TG_find").value;
       var cond = "tendt ilike '%"+ tukhoa.replace("'", " '' ") +"%'";
       //alert(cond);
       getval_detai_duan_TG_show(cond);
  }	
  
  
	
  function getval_detai_duan_TG_show(sel) {
	    try {
	        $('#dlg_detai_duan_TG_show_datagrid').datagrid({
	          width: 500,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:(  HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_DETAI_DUAN), 
	          queryParams:{
	            total: -1,
	            records: 0,
	            condition: sel
	          },
	          loadMsg: MSG_WAIT_LOADING,
	          sortName: 'id_detai',
	          sortOrder: 'asc',
	          remoteSort: false,
	          idField:'id_detai',
	          columns: [[
	                     {field: 'tendt', title: 'Tên đề tài', width: 80, align: 'left', alignH: 'center',
	                   	  formatter:function(value,row){
	                  		  return '<a href="#" onclick="onsubmenu_hienthi_vanban('+row.id_detai+');">'+value+'</a>';
	                  	  }   
	                     },
	                     {field: 'linhvuckh', title: 'Lĩnh vực', width: 80, align: 'center', alignH: 'center'},
	                     {field: 'tgthuchien', title: 'Thời gian', width: 80, align: 'center', alignH: 'center'},
	                     {field: 'kinhphi', title: 'Kinh phí', width: 80, align: 'left', alignH: 'center'},
	          ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_detai_duan_TG_show have dlg_detai_duan_TG_show_datagrid: " + err);
	      }
  }

  function func_dlg_detai_duan_TG_show() {
    try {
      $('#dlg_detai_duan_TG_show_datagrid').datagrid({
        width: 500,
        height: 300,
        nowrap: false,
        striped: true,
        fitColumns: true,
        singleSelect: true,
        collapsible: true,
        url:(  HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_DETAI_DUAN),  
        queryParams:{
          total: -1,
          records: 0
        },
        loadMsg: MSG_WAIT_LOADING,
        sortName: 'id_detai',
        sortOrder: 'asc',
        remoteSort: false,
        idField:'id_detai',
        columns: [[
          {field: 'tendt', title: 'Tên đề tài', width: 80, align: 'left', alignH: 'center',
        	  formatter:function(value,row){
       		  return '<a href="#" onclick="onsubmenu_hienthi_vanban('+row.id_detai+');">'+value+'</a>';
       	  }   
          },
          {field: 'linhvuckh', title: 'Lĩnh vực', width: 80, align: 'center', alignH: 'center'},
          {field: 'tgthuchien', title: 'Thời gian', width: 80, align: 'center', alignH: 'center'},
          {field: 'kinhphi', title: 'Kinh phí', width: 80, align: 'left', alignH: 'center'},
        ]],
        pagination: true,
        rownumbers: true,
        onLoadSuccess: function (data) {
        }
      });
    } catch (err) {
      alert("func_dlg_detai_duan_TG_show have dlg_detai_duan_TG_show_datagrid: " + err);
    }

  
  }

  function onsubmenu_hienthi_vanban(id_detai){
		loadHtml("dlg_timkiem_dtda_sp_hienthi_show","./page/trangTimKiemDTDATheoSP_hienthi.jsp", false);
		func_dlg_timkiem_dtda_sp_hienthi(id_detai);
  }
</script>