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
    <select name="dlg_detai_duan_sp_cbb" id="dlg_detai_duan_sp_cbb" ></select>
    <br><br>
    <strong>Tình trạng</strong>
    <select name="dlg_detai_duan_sp_tinhtrang_cbb" id="dlg_detai_duan_sp_tinhtrang_cbb" >
    		<option value="-1">Tất cả</option>
    		<option value="1">Đang thực hiện</option>
    		<option value="2">Đã nghiệm thu</option>
    
    </select>
    <br><br>
    <strong>Tìm đề tài</strong>
    <input  id="dl_detai_duan_sp_find" style="margin-bottom: 13px; height: 24px" >
    <a class="btn_tim" onclick="findDT();" href="javascript:;"> Tìm </a>
	<table id="dlg_detai_duan_sp_show_datagrid"></table>
</div>

<script>
    var id_phannhom;
	$(document).ready(function() {
        cwrs_Data2ComboBox( HOME_SERVLET, ACT_GET_NHOM_DETAI_DUAN_TO_CBB, null, TYPE_DATA_HTML_CBB,'Tất cả', 'dlg_detai_duan_sp_cbb');
	    $('#dlg_detai_duan_sp_cbb').on('change', function() {
	      $('#dlg_detai_duan_sp_tinhtrang_cbb').val("-1");	
	      id_phannhom = this.value;
	      if(this.value == -1){
	    	 func_dlg_detai_duan_sp_show();
		  }else{
			 getval_detai_duan_sp_show("id_phannhom_detai_duan=" + this.value);
		  }
	    });
	    
	    $('#dlg_detai_duan_sp_tinhtrang_cbb').on('change', function() {
	    	  if(this.value == -1){
	    		  if(id_phannhom == -1 ){
	    			func_dlg_detai_duan_sp_show();
	    		  }else{
	    		 	getval_detai_duan_sp_show("id_phannhom_detai_duan=" + id_phannhom);
	    		  }
			  }else{
				 getval_detai_duan_sp_show("id_phannhom_detai_duan=" + id_phannhom + " and tinhtrang=" + this.value);
			  }
		});
	    
	});

  function findDT(){
	  var tukhoa = document.getElementById("dl_detai_duan_sp_find").value;
       var cond = "tendt ilike '%"+ tukhoa.replace("'", " '' ") +"%'";
       //alert(cond);
       getval_detai_duan_sp_show(cond);
  }	
	
  function getval_detai_duan_sp_show(sel) {
	    try {
	        $('#dlg_detai_duan_sp_show_datagrid').datagrid({
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
	        alert("func_dlg_detai_duan_sp_show have dlg_detai_duan_sp_show_datagrid: " + err);
	      }
  }

  function func_dlg_detai_duan_sp_show() {
    try {
      $('#dlg_detai_duan_sp_show_datagrid').datagrid({
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
      alert("func_dlg_detai_duan_sp_show have dlg_detai_duan_sp_show_datagrid: " + err);
    }

  
  }

  function onsubmenu_hienthi_vanban(id_detai){
		loadHtml("dlg_timkiem_dtda_sp_hienthi_show","./page/trangTimKiemDTDATheoSP_hienthi.jsp", false);
		func_dlg_timkiem_dtda_sp_hienthi(id_detai);
  }
</script>