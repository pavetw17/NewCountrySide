<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
         
<div style="padding: 10px 0 0 15px">

    <span style="color: #B5250A;
  font: bold 15px Verdana,Arial,sans-serif;
  margin: 0;
  text-decoration: underline;
  text-transform: uppercase;
  margin-bottom: 12px;" >Tìm kiếm theo tiêu chí ứng dụng NTM</span>
  <br><br>
    <strong>Tiêu chí</strong>
    <select name="dlg_detai_duan_TCUD_NTM_cbb" id="dlg_detai_duan_TCUD_NTM_cbb" ></select>
    
    <a class="btn_tim" onclick="findDT_theodieukien();" href="javascript:;"> Tìm </a>
    <br><br>
	<table id="dlg_detai_duan_TCUD_NTM_show_datagrid"></table>
	
</div>

<script>
	$(document).ready(function() {
        cwrs_Data2ComboBox(HOME_SERVLET, ACT_GET_TIEUCHI_XD_NTM_CHA_TO_CBB, 'id_tieuchi_cha is null', TYPE_DATA_HTML_CBB,'*', 'dlg_detai_duan_TCUD_NTM_cbb');
	});
	
	  function findDT_theodieukien(){
		  var id_tieuchi_cha = $('#dlg_detai_duan_TCUD_NTM_cbb').val();
	      if(id_tieuchi_cha == -1){
	    	  func_dlg_detai_duan_TCUD_NTM_show();
	      }else{
	    	  getval_dlg_detai_duan_TCUD_NTM_show( "id_tieuchi_cha=" + id_tieuchi_cha  );
	      }
	  } 	
	
	  function getval_dlg_detai_duan_TCUD_NTM_show(sel) {
		    try {
		        $('#dlg_detai_duan_TCUD_NTM_show_datagrid').datagrid({
		          width: 500,
		          height: 300,
		          nowrap: false,
		          striped: true,
		          fitColumns: true,
		          singleSelect: true,
		          collapsible: true,
		          url:( HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_DTDA_THEO_TIEUCHIUNGDUNG_NTM), 
		          queryParams:{
		            total: -1,
		            records: 0,
		            condition: sel
		          },
		          loadMsg: MSG_WAIT_LOADING,
		          sortName: 'id_tieuchi',
		          sortOrder: 'asc',
		          remoteSort: false,
		          idField:'id_tieuchi',
		          columns: [[
		                     {field: 'ten_tieuchi', title: 'Tên tiêu chí', width: 80, align: 'left', alignH: 'center',
		                   	  formatter:function(value,row){
		                  		  return '<a href="#" onclick="onsubmenu_hienthi_tieuchi('+row.id_tieuchi+','+row.id_thuyetminh_detai+','+row.id_xadiem+');">'+value+'</a>';
		                  	  }   
		                     },
		                     {field: 'masodt', title: 'Mã số thuyết minh', width: 80, align: 'center', alignH: 'center'},
		                     {field: 'ten_xadiem', title: 'Tên xã điểm', width: 80, align: 'center', alignH: 'center'},
		          ]],
		          pagination: true,
		          rownumbers: true,
		          onLoadSuccess: function (data) {
		          }
		        });
		      } catch (err) {
		        alert("func_dlg_detai_duan_TCUD_NTM_show have dlg_detai_duan_TCUD_NTM_show_datagrid: " + err);
		      }
	  }

  function func_dlg_detai_duan_TCUD_NTM_show() {
	    try {
	        $('#dlg_detai_duan_TCUD_NTM_show_datagrid').datagrid({
	          width: 500,
	          height: 300,
	          nowrap: false,
	          striped: true,
	          fitColumns: true,
	          singleSelect: true,
	          collapsible: true,
	          url:( HOME_SERVLET + 'action='+ ACT_GET_DATA_TO_FORM_DTDA_THEO_TIEUCHIUNGDUNG_NTM), 
	          queryParams:{
	            total: -1,
	            records: 0,
	            
	          },
	          loadMsg: MSG_WAIT_LOADING,
	          sortName: 'id_tieuchi',
	          sortOrder: 'asc',
	          remoteSort: false,
	          idField:'id_tieuchi',
	          columns: [[
	                     {field: 'ten_tieuchi', title: 'Tên tiêu chí', width: 80, align: 'left', alignH: 'center',
	                   	  formatter:function(value,row){
	                  		  return '<a href="#" onclick="onsubmenu_hienthi_tieuchi('+row.id_tieuchi+','+row.id_thuyetminh_detai+','+row.id_xadiem+');">'+value+'</a>';
	                  	  }   
	                     },
	                     {field: 'masodt', title: 'Mã số thuyết minh', width: 80, align: 'center', alignH: 'center'},
	                     {field: 'ten_xadiem', title: 'Tên xã điểm', width: 80, align: 'center', alignH: 'center'},
	          ]],
	          pagination: true,
	          rownumbers: true,
	          onLoadSuccess: function (data) {
	          }
	        });
	      } catch (err) {
	        alert("func_dlg_detai_duan_TCUD_NTM_show have dlg_detai_duan_TCUD_NTM_show_datagrid: " + err);
	      }
  }

  function onsubmenu_hienthi_tieuchi(id_tieuchi,id_thuyetminh_detai,id_xadiem){
		loadHtml("dlg_timkiem_dtda_sp_hienthi_show","./page/trangTimKiemDTDATheoTCUD_NTM_hienthi.jsp", false);
		window.scrollTo(400, 0);
		func_dlg_timkiem_tcud_NTM_hienthi(id_tieuchi,id_thuyetminh_detai,id_xadiem);
	}
  
  
</script>