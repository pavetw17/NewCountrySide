<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    input[type="text"]{
        margin: 0;
    }
</style>

<div>
    <strong>Tên đăng nhập</strong>
    <input  id="dl_dstaikhoan_finduser" style="margin-bottom: 5px;margin-top: 10px; height: 24px" >
    <input TYPE="BUTTON" NAME="" VALUE="Tìm" style="margin-bottom: 5px;margin-top: 10px; height: 24px"  onclick="finduser()">
    <input TYPE="BUTTON" NAME="" VALUE="Thêm người dùng" style="margin-bottom: 5px;margin-top: 10px; height: 24px"  onclick="insert()">
</div>

<table id="dlg_taikhoan_datagrid"></table>

<script type="text/javascript" language="javascript">
     (function($){ 
     $.parser={auto:true,onComplete:function(_1){
     },plugins:["linkbutton","menu","menubutton","splitbutton","progressbar","tree","combobox","combotree","numberbox","validatebox","searchbox","numberspinner","timespinner","calendar","datebox","datetimebox","layout","panel","datagrid","propertygrid","treegrid","tabs","accordion","window","dialog"],parse:function(_2){
     var _3=$.parser.plugins[14];var r=$(".easyui-datebox",_2);
     //alert(_2)
     if(r.length){if(r[_3]){	//alert(_3)alert(r[_3])
     r[_3]();
     }
     }
     }
     };
     $(function(){if(!window.easyloader&&$.parser.auto){$.parser.parse();}});
     })(jQuery); 

    var dlgThis = null;
    var datagrid_id = '#dlg_taikhoan_datagrid';
    var datagrid_pkey = 'id_taikhoan';
    var datagrid_tablename = 'tbl_taikhoan';
    var odatagrid = null;
    var lastRowIndex = -1;

    function finduser(){
        //update datagrid
        var user = document.getElementById("dl_dstaikhoan_finduser").value;
        var cond = "tentk ilike '%25"+ user.replace("'", " '' ")   +"%25'"; //% encode %25
        //alert(cond);
        func_dlg_qlquyen_dstaikhoan_show(false,'',ACT_GET_DATA_USERLIST+"&condition="+cond);
        /* odatagrid.datagrid('load',
                {
                    url:root_href + HOME_SERVLET,
                    action: ACT_GET_DATA_USERLIST,
                    condition:cond
                }
        ); */
    }
    
    function updateActions(){	 //show row current
        var rowcount = odatagrid.datagrid('getRows').length;
        for(var i=0; i<rowcount; i++){
            odatagrid.datagrid('updateRow',{
                index:i,
                row:{action:''}
            });
        }
    }

    function hasRowEditing(){
        var rows = odatagrid.datagrid('getRows');
        for (var i = 0; i<rows.length; i++){
            if (rows[i].editing){
                return true;
            }
        }
        return false;
    }

    function saverow(index){
        //validate
        if(!validate_row(index))return;

        var dsquyen = "";
        for( var x=0; x < ($("input[name='quyen[]']").length); x++)
            if ($("input[name='quyen[]']")[x].checked==true){
                dsquyen += ($("input[name='quyen[]']")[x].value) +",";
            }

        if(dsquyen.endsWith(',')){
            dsquyen = dsquyen.substring(0, dsquyen.length - 1);
        }

        //alert({rowIndex:index});
        var column_add = "id_quyen";
        var jr = datagrid_insert_multirow_editing(odatagrid,column_add,'tbl_taikhoan',{rowIndex:index},dsquyen); //tra ve key them vao

        if (jr.success){
            msginfo('Cập nhật thành công!');
            var row = odatagrid.datagrid('getRows')[index];
            odatagrid.datagrid('endEdit', index);
            if(parseInt(jr.val)!=0){//jr.val = 0 when update one existed so skip.
                row[datagrid_pkey] = jr.val;
            }
        }
    }

    function editrow(index){
    	
    	var dsquyen = "";
		var mangquyen = "";
        var row  = odatagrid.datagrid('getRows')[index];
        var checkAllRow  = odatagrid.datagrid('getRows');
    	for (var i = 0; i<checkAllRow.length; i++){
    		if(checkAllRow[i].editing == true){
    			msgalert_autoclose('Thông báo','Bạn đang thao tác dòng','error');
    			return;
    		}
    	}
        
    	$('#dlg_dtra_ds_quyen').show();
    	cwrs_Data2CheckboxBox(root_href + QUYEN_SERVLET, ACT_GET_LIST_DANHSACHQUYEN_TO_CHECKBOX, null, TYPE_DATA_HTML_CBB,null, 'dlg_dtra_ds_quyen');
        if (row[datagrid_pkey] == undefined) alert('undefined');
        //    array_dt_row_orginal[row[datagrid_pkey]] = row['ttgc_cd_dientich'];
             //if (hasRowEditing()){msgwarning(MSG_NEED_SAVE_EDITING);return;}
        odatagrid.datagrid('beginEdit', index);
        lastRowIndex = index;
        //alert(lastRowIndex)
        $.ajax({url:root_href + HOME_SERVLET ,									
			    data:{ 
				  action: ACT_GET_DATA_TO_EDIT_DS_TAIKHOAN,
				  condition: 'id_taikhoan ='+ row[datagrid_pkey]
					
				},
				async:false,
			    success:function(jsonData) {
					//alert(jsonData);
					var jsonObject = JSON.parse(jsonData);
					
					if (jsonObject.rows[0].id_quyen != null) {
						dsquyen = jsonObject.rows[0].id_quyen;
						mangquyen = dsquyen.split(',');
					  	}
			    }});
					for( var i=0; i < mangquyen.length; i++ )
					    for( var x=0; x< ($("input[name='quyen[]']").length); x++)
					    	if ($("input[name='quyen[]']")[x].value == mangquyen[i]){
					    		$("input[name='quyen[]']")[x].checked=true;
					    } 
    }
    
    function cancelrow(index){
    	$('#dlg_dtra_ds_quyen').hide();
        var row = odatagrid.datagrid('getRows')[index];
        if (row[datagrid_pkey]==undefined)deleterow(index, false);
        else{
            odatagrid.datagrid('cancelEdit', index);
        }
    }

    function deleterow(index, noconfirm){
        //var o = odatagrid.datagrid('getEditor', {index:index, field:'ttgc_cd_ngaygieocay'}).target;
        //alert(o)

        var row  = odatagrid.datagrid('getRows')[index];
        <%-- alert(index);
         alert(row);
         alert("row[datagrid_pkey]="+row[datagrid_pkey]);
         alert("noconfirm=" + noconfirm); --%>
        if (row[datagrid_pkey] == undefined) {
            msgconfirm('Thông báo',MSG_DELETE_NOT_SAVED_ON_DATAGRID,function(r){
                if (r){
                    $("#dlg_dtra_ds_quyen").html("");
                    odatagrid.datagrid('deleteRow', index);
                    updateActions();
                }
            });
        }else {
            if (noconfirm){
                datagrid_delete_row(root_href + HOME_SERVLET, odatagrid, index, datagrid_tablename, datagrid_pkey +'='+row[datagrid_pkey]);

            } else
                msgconfirm('Thông báo',MSG_DELETE_ON_DATAGRID,function(r){
                    if (r){
                        if (datagrid_delete_row(root_href + HOME_SERVLET, odatagrid, index, datagrid_tablename, datagrid_pkey +'='+row[datagrid_pkey]));
                    }
                });
        }
    }

    function insert(){
        cwrs_Data2CheckboxBox(root_href + QUYEN_SERVLET, ACT_GET_LIST_DANHSACHQUYEN_TO_CHECKBOX, null, TYPE_DATA_HTML_CBB,null, 'dlg_dtra_ds_quyen');

        var row = odatagrid.datagrid('getSelected');
        if (row){
            var index = odatagrid.datagrid('getRowIndex', row);
        } else {
            index = 0;
        }
        if (index <0)index =0;
        odatagrid.datagrid('insertRow', {
            index: index,
            row:{
                status:'P'
            }
        });
        lastRowIndex = index;
        odatagrid.datagrid('selectRow',index);
        odatagrid.datagrid('beginEdit',index);
    }


    <%--return target jquery if failed or--%>
    function validate_row(index){

        var o = null;
        var row = odatagrid.datagrid('getRows')[index];

        g_ErrorNotifier.clear(); //declare global.js and classes.js

        //check user
        o = odatagrid.datagrid('getEditor', {index:index, field:'tentk'}).target;
        var username = $(o).val();
        if (username =='') g_ErrorNotifier.add('Chưa nhập tên tài khoản');

        //check pass
        o = odatagrid.datagrid('getEditor', {index:index, field:'matkhau'}).target;
        var pass = $(o).val();
        if (pass =='') g_ErrorNotifier.add('Chưa nhập mật khẩu');

        if($('input[name="quyen[]"]:checked').length == 0){
            g_ErrorNotifier.add('Chưa chọn quyền');
        }

        if (g_ErrorNotifier.hasErrors()){
            msgerror(g_ErrorNotifier.getErrorMessages());
            return false;
        }

        var r  = -1;
        if (row.id_taikhoan == undefined){//add
            r = checkDataExists(root_href + HOME_SERVLET ,'tbl_taikhoan',"tentk='"+ username.replace("'", " '' ")  +"'");
        } else {//edit
            r = checkDataExists(root_href + HOME_SERVLET , 'tbl_taikhoan',"tentk='"+ username.replace("'", " '' ")  +"'" +' AND '+'id_taikhoan <>'+ row.id_taikhoan);
        }
        if (r >0){msgerror('Tài khoản bạn vừa nhập đã tồn tại trong hệ thống.'); return false;}
        else if (r < 0){msgerror('Xảy ra lỗi trong quá trình kiểm tra dữ liệu. Bạn hãy kiểm tra lại kết nối mạng hoặc ấn F5 và làm lại thao tác.'); return false;}
        else if (r == 0){ }

        return true;
    }

    function validate_all_row_editing(){
        var rows = odatagrid.datagrid('getRows');
        var array_row_editing = [];
        //validate từng row
        for (var i =0; i< rows.length; i++){
            if (rows[i].editing){
                if (!validate_row(i)) {return false;}
            }
        }
        //check trùng dữ liệu giữa các row đang edit
        for (var i =0; i< rows.length; i++){
            if (rows[i].editing){
                //alert('push '+i)
                array_row_editing.push(i);
            }
        }
        var t1=0;
        var t2=0;
        var jsDate1;
        var jsDate2;
        for (var i =0; i< array_row_editing.length-1; i++)
            for (var j =i+1; j< array_row_editing.length; j++){
                var user1 = $(odatagrid.datagrid('getEditor', {index:array_row_editing[i], field:'tentk'}).target).val();
                var user2 = $(odatagrid.datagrid('getEditor', {index:array_row_editing[j], field:'tentk'}).target).val();


                if (user1==user2){
                    msgerror('Bản ghi thứ '+(array_row_editing[i]+1) +' và '+(array_row_editing[j]+1)+' bạn vừa nhập có cùng tên đăng nhập.');
                    return false;
                }
            }
        return true;
    }

    function func_dlg_qlquyen_dstaikhoan_show(isEdit, condition,action){
        try{
            lastRowIndex = -1;
            odatagrid =$(datagrid_id).datagrid({
                width:950,
                height:200,
                singleSelect:true,
                showFooter:true,
                url:( root_href + HOME_SERVLET + 'action='+ action),
                queryParams:{
                    total: -1,
                    records: 0
                },
                loadMsg: MSG_WAIT_LOADING,
                sortName: datagrid_pkey,
                sortOrder: 'asc',
                remoteSort: false,
                idField:datagrid_pkey,
                rowStyler:function(index,row){// tạo chữ đậm khi thêm mới row (khi pkey chưa có)
                    if (row.user_id == undefined){
                        return 'font-weight:bold;';//'background-color:pink;color:blue;font-weight:bold;';
                    }
                },
                columns:[[
                    {field:'tentk',title:'Tên đăng nhập',width:145,
                        rowspan:2,
                        editor:'text'

                    },
                    {field:'matkhau',title:'Mật khẩu',width:110,
                        rowspan:2,
                        editor:  'text',
                         formatter: function(value,rowData,index){
                            	//Must return a string, for cell replacement is formatter. 
                            	return '******';
            					//The mouse moved up a pop-up hint, principle can be Fanhu string to parse the HTML format to        
            					//return '<a title="'+value+'">'+value+'</a>';
                        } 

                    },
                    {field:'action',title:'Thao tác',width:80,align:'center',rowspan:2,
                        formatter:function(value,row,index){
                            if (row.editing){
                                var s = '<a href="#" onclick="saverow('+index+')">Lưu</a> - ';
                                var c = '<a href="#" onclick="cancelrow('+index+')">Hủy</a>';
                                return s+c;
                            } else {
                                var e = '<a href="#" onclick="editrow('+index+')">Sửa</a> - ';
                                var d = '<a href="#" onclick="deleterow('+index+')">Xóa</a>';
                                return e+d;
                            }
                        }
                    }

                ]],
                pagination:true,
                rownumbers:true,
                //fitColumns:true,
                onLoadSuccess:function(data){

                },

                onBeforeEdit:function(index,row){
                    row.editing = true;
                    //$(odatagrid.datagrid('getEditor', {index:index, field:'ttgc_cd_canhdong_id'}).target).val(1500);

                    updateActions();

                },
                onAfterEdit:function(index,row){

                    row.editing = false;
                    updateActions();
                    //alert('onAfterEdit');
                },
                onCancelEdit:function(index,row){
                    row.editing = false;
                    updateActions();
                }
            });
        }
        catch(err){  alert(err);  };


        dlgThis = $('#dlg_qlquyen_dstaikhoan_show').dialog({
            title:"Danh sách tài khoản" +'- ',
            modal:false , open: function() {$(this).dialog('widget').draggable('option', {containment: false});},
            width: 985,
            height: 500,
            position: [240, 90],
            buttons: {
                "Bảng phân quyền": function() {
                    onsubmenu_danhsachquyen();
                },
          
                "Đóng": function() {
                    $( this ).dialog( "close" );

                }
            }
        });
    }

</script>

  <%--    "Cập nhật toàn bộ": function() {
                    //validate all row editing
                	var fields = odatagrid.datagrid('getColumnFields',{frozen:false});
                	var rows = odatagrid.datagrid('getRows');
                	
                	alert("fields="+ fields +"--- rows=" + rows  );
                	for (var i = 0; i<rows.length; i++){
                		alert(rows[i].editing);
                	}
                }, --%>

<table style="margin-top: 13px;">
    <tr>
        <td><b>Danh sách quyền </b></td>
    </tr>
    <tr>
        <td>
            <div name="dlg_dtra_ds_quyen"
                 id="dlg_dtra_ds_quyen"
                 style="overflow: auto; width: 300px; height: 100px; border: 1px solid #336699; padding-left: 5px">
            </div>
        </td>
    </tr>
</table>