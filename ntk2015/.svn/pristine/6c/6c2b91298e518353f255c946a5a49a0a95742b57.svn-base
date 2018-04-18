/** Extruder */
var last_extruder=null;
function openExtruder(name){
	
	if (name == 'baocao_build_graph_extruder'){
		$("#" + name).openMbExtruder();
		return;
	}
	
	var c = 0;
	if ($("#timkiem_extruder").isOpen() == true) c++;
	if ($("#hientrang_extruder").isOpen() == true) c++;
	if ($("#baocao_extruder").isOpen() == true) c++;
	if ($("#dangnhap_extruder").isOpen() == true) c++;
	if ($("#vientham_extruder").isOpen() == true) c++;
	if ($("#dubao_extruder").isOpen() == true) c++;
	//if ($("#baocao_build_graph_extruder").isOpen() == true) c++;
	
	//alert(c)
	if (c > 0)	$("#" + name).openMbExtruder(0);	
	else 
		$("#" + name).openMbExtruder();
	

	
	if (name != 'timkiem_extruder')	{ $("#timkiem_extruder").closeMbExtruder(0);$("#timkiem_extruder").hideFlap();}
	if (name != 'hientrang_extruder'){$("#hientrang_extruder").closeMbExtruder(0);$("#hientrang_extruder").hideFlap();}
	if (name != 'baocao_extruder')  { $("#baocao_extruder").closeMbExtruder(0);$("#baocao_extruder").hideFlap();}
	if (name != 'dangnhap_extruder')  { $("#dangnhap_extruder").closeMbExtruder(0);$("#dangnhap_extruder").hideFlap();}
	if (name != 'vientham_extruder')  { $("#vientham_extruder").closeMbExtruder(0);$("#vientham_extruder").hideFlap();}
	if (name != 'dubao_extruder')  { $("#dubao_extruder").closeMbExtruder(0);$("#dubao_extruder").hideFlap();}

	//if (name != 'baocao_build_graph_extruder')  { $("#baocao_build_graph_extruder").closeMbExtruder(0);$("#baocao_build_graph_extruder").hideFlap();}
	$("#timkiem_extruder").hideFlap();
	$("#hientrang_extruder").hideFlap();
	$("#dangnhap_extruder").hideFlap();
	$("#vientham_extruder").hideFlap();
	$("#dubao_extruder").hideFlap();
	//$("#baocao_build_graph_extruder").hideFlap();
	
	if (name == 'dangnhap_extruder'){
		if (g_acc_signedin)$("#acc_login_btnchange").attr('disabled',false);
		else $("#acc_login_btnchange").attr('disabled',true);
	}
	$("#" + name).showFlap();
	
}
function onCloseExtruder(){
	
	if (!($("#timkiem_extruder").isOpen() == true
		&& $("#hientrang_extruder").isOpen() == true
		&& $("#baocao_extruder").isOpen() == true
		&& $("#dangnhap_extruder").isOpen() == true
		&& $("#vientham_extruder").isOpen() == true
		&& $("#dubao_extruder").isOpen() == true
		//&& $("#baocao_build_graph_extruder").isOpen() == true
	
	)) {
	//	alert('đ')
	$("#timkiem_extruder").showFlap();
	if(last_extruder!=null)
	$("#"+last_extruder).showFlap();
	
	//$("#hientrang_extruder").showFlap();
	//$("#baocao_extruder").showFlap();
	}
	//$("#baocao_build_graph_extruder").hideFlap();
}
function onOpenExtruder(extruder_name){
	//alert(extruder_name)
	if (!($("#timkiem_extruder").isOpen() == true
		&& $("#hientrang_extruder").isOpen() == true
		&& $("#baocao_extruder").isOpen() == true
		&& $("#dangnhap_extruder").isOpen() == true
		&& $("#vientham_extruder").isOpen() == true
		&& $("#dubao_extruder").isOpen() == true
		//&& $("#baocao_build_graph_extruder").isOpen() == true
		
	
	)) {
	//	alert('đ')
	//$("#timkiem_extruder").showFlap();
	//$("#hientrang_extruder").showFlap();
	//$("#baocao_extruder").showFlap();
	}
	if(extruder_name!='timkiem_extruder'){
		$("#timkiem_extruder").hideFlap();
		$("#hientrang_extruder").hideFlap();
		$("#baocao_extruder").hideFlap();
		$("#dangnhap_extruder").hideFlap();
		$("#vientham_extruder").hideFlap();
		$("#dubao_extruder").hideFlap();
	}
	//$("#baocao_build_graph_extruder").hideFlap();
	
	//alert(extruder_name)
	$("#" + extruder_name).showFlap();
	openExtruder(extruder_name);
	if(extruder_name!='timkiem_extruder'){
		last_extruder=extruder_name;
	}
	switch(g_fn_selected)
		{
		case FN_BAOCAO_HIENTRANGLUA: 
		case FN_BAOCAO_COCAUGIONGLUA: 
		case FN_BAOCAO_THONGTINTHIENTAI: {$("#baocao_extruder").showFlap();} break;

		case FN_MAP_HIENTRANG_CCGL: 
		case FN_MAP_HIENTRANG_NUOC: 
		case FN_MAP_HIENTRANG_HTL: 
		case FN_MAP_HIENTRANG_DICHHAI: 
		case FN_MAP_HIENTRANG_THIENTAI: 
		case FN_MAP_HIENTRANG_NANGSUAT:{$("#hientrang_extruder").showFlap();} break;
		
		case FN_VIENTHAM: {$("#vientham_extruder").showFlap();} break;
		case FN_DUBAO_VT: {$("#dubao_extruder").showFlap();} break;
		//case FN_BAOCAO_BUILDGRAPH: {$("#baocao_build_graph_extruder").showFlap();} break;
		default:break;
		}
	
}
