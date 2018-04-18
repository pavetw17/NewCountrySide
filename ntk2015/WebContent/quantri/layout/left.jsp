<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<ul class="sidebar-menu ">
  <li class="has-sub"><a href="javascript:void(0)"  >
    <span class="icon-box"><i class="icon-book"></i></span>
    Form nhập liệu<span class="arrow"></span></a>
    <ul class="sub">
        <li><a href="javascript:void(0)" onclick="onsubmenu_quanlyphanloai_baocao(); return false;" > Phân loại báo cáo </a></li>
        <li><a href="javascript:void(0)" onclick="onsubmenu_quanlyphanloai_kq(); return false;" > Phân loại kết quả </a></li>
        <li><a href="javascript:void(0)" onclick="onsubmenu_quanlyvaitro(); return false;" > Nhóm vai trò </a></li>
        <li><a href="javascript:void(0)" onclick="onsubmenu_tochuc(); return false;" > Thông tin tổ chức </a></li>
        <li><a href="javascript:void(0)" onclick="onsubmenu_nhansu(); return false;" > Thông tin nhân sự </a></li>
        <li><a href="javascript:void(0)" onclick="onsubmenu_thumuc(); return false;" > Thư mục </a></li>
    </ul>
  </li>
  <li class="has-sub"><a href="javascript:void(0)" >
    <span class="icon-box"><i class="icon-book"></i></span>
    Quản lý biên bản<span class="arrow"></span></a>
    <ul class="sub">
         <li><a href="javascript:void(0)" onclick="onsubmenu_bb_mohoso(); return false;" > Biên bản mở hồ sơ </a></li>
		<li><a href="javascript:void(0)" onclick="onsubmenu_bb_hophoidong(); return false;" > Biên bản họp hội đồng </a></li>
		<li><a href="javascript:void(0)" onclick="onsubmenu_bb_kiemphieu(); return false;" > Biên bản kiểm phiếu </a></li>
    </ul>
  </li>
   <li class="has-sub"><a href="javascript:void(0)" >
    <span class="icon-box"><i class="icon-book"></i></span>
    Quản lý họp<span class="arrow"></span></a>
    <ul class="sub">
         <li><a href="javascript:void(0)" onclick="onsubmenu_phanloaithanhvien(); return false;" > Danh sách thành viên họp </a></li>
		<li><a href="javascript:void(0)" onclick="onsubmenu_quanlychuyengia(); return false;" > Danh sách chuyên gia </a></li>
		<li><a href="javascript:void(0)" onclick="onsubmenu_quanlykiennghi(); return false;" > Kiến nghị </a></li>
        <li><a href="javascript:void(0)" onclick="onsubmenu_quanlyphanloai_phieu(); return false;" > Phân loại phiếu </a></li>
        <li><a href="javascript:void(0)" onclick="onsubmenu_quanly_phieu(); return false;" > Quản lý phiếu </a></li>
    </ul>
  </li>
  <li class="has-sub"><a href="javascript:void(0)" >
    <span class="icon-box"><i class="icon-book"></i></span>
    Hoạt động tin tức<span class="arrow"></span></a>
    <ul class="sub">
        <li><a href="javascript:void(0)" onclick="onsubmenu_tintuchoatdong_phanloai(); return false;" > Tin tức phân loại  </a></li>
        <li><a href="javascript:void(0)" onclick="onsubmenu_tintuchoatdong(); return false;" > Tin Tức hoạt động </a></li>
    </ul>
  </li>
  <li class="has-sub"><a href="javascript:void(0)" >
    <span class="icon-box"><i class="icon-book"></i></span>
    Bài viết giới thiệu<span class="arrow"></span></a>
    <ul class="sub">
        <li><a href="javascript:void(0)" onclick="onsubmenu_gioithieu_kqxdNTM(); return false;" > Kết quả xây dựng NTM  </a></li>
        <li><a href="javascript:void(0)" onclick="onsubmenu_gioithieu_udncDTDA(); return false;" > Ứng dụng nghiên cứu ĐTDA  </a></li>
    </ul>
  </li>
  <li class="has-sub"><a href="javascript:void(0)" onclick="onsubmenu_ketqua_danhgiahangnam(); return false;" >
    <span class="icon-box"><i class="icon-book"></i></span>
    Đánh giá kết quả hàng năm</a>
  </li>
  <li class="has-sub"><a href="javascript:void(0)" >
    <span class="icon-box"><i class="icon-book"></i></span>
    Kết quả xây dựng NTM<span class="arrow"></span></a>
    <ul class="sub">
        <li><a href="javascript:void(0)" onclick="onsubmenu_hinhanh_kqxdNTM(); return false;" >Hình ảnh kết quả  </a></li>
        <li><a href="javascript:void(0)" onclick="onsubmenu_banghinh_kqxdNTM(); return false;" >Băng hình kết quả  </a></li>
    </ul>
  </li>
 <li class="has-sub"><a href="javascript:void(0)" >
    <span class="icon-box"><i class="icon-book"></i></span>
    CT KHCN xây dựng NTM <span class="arrow"></span></a>
    <ul class="sub">
        <li><a href="javascript:void(0)" onclick="onsubmenu_vanbanykienchidao(); return false;" >Ý kiến chỉ đạo </a></li>
    </ul>
  </li>
  <li class="has-sub"><a href="javascript:void(0)">
    <span class="icon-box"><i class="icon-book"></i></span>
    Quản lý văn bản <span class="arrow"></span></a>
    <ul class="sub">
      <li><a href="javascript:void(0)" onclick="onsubmenu_danhsachvanban_phanloai(); return false;" >Danh sách phân loại văn bản</a></li>
      <li><a href="javascript:void(0)" onclick="onsubmenu_danhsachvanbanphaply(); return false;" >Danh sách văn bản pháp lý</a></li>
    </ul>
  </li>
  <li class="has-sub"><a href="javascript:" class=""><span class="icon-box"><i class="icon-book"></i></span>
    Bộ tiêu chí quốc gia  <span class="arrow"></span></a>
    <ul class="sub">
            <li><a href="javascript:void(0)" onclick="onsubmenu_quanlyphanloai_khuvuc(); return false;" > Phân loại khu vực </a></li>
            <li><a href="javascript:void(0)" onclick="onsubmenu_tieuchi_xd_ntm_cha(); return false;" >Nhóm tiêu chí xây dựng </a></li>
            <li><a href="javascript:void(0)" onclick="onsubmenu_tieuchi_xd_ntm_con(); return false;" >Tiêu chí NTM </a></li>
            <li><a href="javascript:void(0)" onclick="onsubmenu_tieuchi_ungdung(); return false;" >Tiêu chí ĐTDA </a></li>
    </ul>
  </li>
  <li class="has-sub"><a href="javascript:" class=""><span class="icon-box"><i
          class="icon-book"></i></span> Thông tin các ĐTDA <span class="arrow"></span></a>
    <ul class="sub">
       <li><a href="javascript:void(0)" onclick="onsubmenu_quanlyphanloai_detai_duan(); return false;" > Phân loại đề tài dự án </a></li>
       <li><a href="javascript:void(0)" onclick="onsubmenu_quanlyphanloai_sanpham(); return false;" > Phân loại sản phẩm </a></li>
       <li><a href="javascript:void(0)" onclick="onsubmenu_detai_duan(); return false;" > Đề tài dự án </a></li>
       <li><a href="javascript:void(0)" onclick="onsubmenu_thuyetminh_detai(); return false;" > Thuyết minh đề tài dự án </a></li>
       <li><a href="javascript:void(0)" onclick="onsubmenu_sanpham(); return false;" > Sản phẩm thuyết minh </a></li>
    </ul>
  </li>
  <li class="has-sub"><a href="javascript:" class=""><span class="icon-box"><i
          class="icon-book"></i></span> Hình ảnh ĐTDA<span class="arrow"></span></a>
    <ul class="sub">
       <li><a href="javascript:void(0)" onclick="onsubmenu_hinhanh_kqncDTDA(); return false;" >Hình ảnh nghiên cứu  </a></li>
       <li><a href="javascript:void(0)" onclick="onsubmenu_banghinh_kqncDTDA(); return false;" >Băng hình nghiên cứu  </a></li>
    </ul>
  </li>
  <li class="has-sub"><a href="javascript:" class=""><span class="icon-box"><i
          class="icon-book"></i></span> Quản lý tham gia <span class="arrow"></span></a>
    <ul class="sub">
       <li><a href="javascript:void(0)" onclick="onsubmenu_tochuc_thamgia(); return false;" > Tổ chức tham gia </a></li>
       <li><a href="javascript:void(0)" onclick="onsubmenu_nhansu_thamgia(); return false;" > Nhân sự tham gia </a></li>
    </ul>
  </li>
    <li class="has-sub"><a href="javascript:" class=""><span class="icon-box"><i
          class="icon-book"></i></span> Thông tin dự án thực hiện <span class="arrow"></span></a>
    <ul class="sub">
       <li><a href="javascript:void(0)" onclick="onsubmenu_detai_tochuc(); return false;" > Tổ chức thực hiện </a></li>
       <li><a href="javascript:void(0)" onclick="onsubmenu_kehoach_capkinhphi(); return false;" > Kế hoạch cấp kinh phí </a></li>
       <li><a href="javascript:void(0)" onclick="onsubmenu_tiendo_capkinhphi(); return false;" > Tiến độ cấp kinh phí </a></li>
       <li><a href="javascript:void(0)" onclick="onsubmenu_noidung_capkinhphi(); return false;" > Nôi dung cấp kinh phí </a></li>
       <li><a href="javascript:void(0)" onclick="onsubmenu_quanly_giaidoan(); return false;" > Quản lý giai đoạn </a></li>
       <li><a href="javascript:void(0)" onclick="onsubmenu_noidung_congviec(); return false;" > Nội dung công việc </a></li>
       <li><a href="javascript:void(0)" onclick="onsubmenu_phanvon_hangmuc(); return false;" > Phân vốn theo hạng mục </a></li>
       <li><a href="javascript:void(0)" onclick="onsubmenu_tiendo_giaingan(); return false;" > Tiến độ giải ngân </a></li>
       <li><a href="javascript:void(0)" onclick="onsubmenu_coche_chinhsach(); return false;" > Cơ chế chính sách </a></li>
       <li><a href="javascript:void(0)" onclick="onsubmenu_giaiphap_khcn(); return false;" > Giải pháp KHCN </a></li>
    </ul>
  </li>
  <li class="has-sub"> <a href="javascript:void(0)" class=""><span class="icon-box">
     <i class="icon-book"></i></span> Tiến độ bảng biểu <span class="arrow"></span></a>
    <ul class="sub">
      <li class=""><a href="javascript:void(0)" onclick="onsubmenu_bangbieu_tiendochung(); return false;">Tiến độ chung</a></li>
      <li class=""><a href="javascript:void(0)" onclick="onsubmenu_bangbieu_capkinhphi(); return false;">Cấp kinh phí</a></li>
      <li class=""><a href="javascript:void(0)" onclick="onsubmenu_bangbieu_giangan(); return false;">Giải ngân</a></li>
    </ul>
  </li>
  <li class="has-sub"> <a href="javascript:void(0)" class=""><span class="icon-box">
     <i class="icon-book"></i></span> Tiến độ biểu đồ <span class="arrow"></span></a>
    <ul class="sub">
    <li class=""><a href="javascript:void(0)" onclick="onsubmenu_bieudo_tiendochung(); return false;">Tiến độ chung</a></li>
      <li class=""><a href="javascript:void(0)" onclick="onsubmenu_bieudo_capkinhphi(); return false;">Cấp kinh phí</a></li>
      <li class=""><a href="javascript:void(0)" onclick="onsubmenu_bieudo_giaingan(); return false;">Giải ngân</a></li>
    </ul>
  </li>
  <li class="has-sub"> <a href="javascript:void(0)" class=""><span class="icon-box">
     <i class="icon-user"></i></span> Quản lý tài khoản <span class="arrow"></span></a>
    <ul class="sub">
      <li class=""><a href="javascript:void(0)" onclick="onsubmenu_danhsachquyen(); return false;">Danh sách quyền</a></li>
      <li class=""><a href="javascript:void(0)" onclick="onsubmenu_danhsachtaikhoan(); return false;">Danh sách tài khoản</a></li>
      <li><a class="" href="./profile.html">Thông tin tài khoản</a></li>
    </ul>
  </li>
</ul>

<script>
  function loadHtml(div, html, async, loadonce){
    if (async == undefined) {
      async = true;
    }
    if (loadonce == undefined) loadonce = false;
    if (loadonce){
      var content = $('#'+div).html();
      content = content.trim();
      // alert(content);
      if (content != ''){ return true;}
    }
    $.ajax({ 
      url: html ,
      type: "GET",
      async:async,
      error: function (request, status, error) {
        alert(request.responseText);
      },
      success:function(_data) {
        //alert(_data);
        $("#"+ div).html(_data);
        return _data;
      }
    });

  }
 
  function onsubmenu_danhsachvanban_phanloai(){
    loadHtml("dlg_qlvanban_phanloai_show","./page/quanlyvanban_phanloai.jsp", false);
    func_dlg_qlvanban_phanloai_show();
  }

  function onsubmenu_danhsachquyen(){
    loadHtml("dlg_qlquyen_dsquyen_show","./page/quanlyquyen_danhsachquyen.jsp", false);
    func_dlg_qlquyen_dsquyen_show();
  }
  
  function onsubmenu_danhsachtaikhoan(){
	loadHtml("dlg_qlquyen_dstaikhoan_show","./page/quanlyquyen_danhsachtaikhoan.jsp", false);
	func_dlg_qlquyen_dstaikhoan_show(false,'',ACT_GET_DATA_TO_FORM_SHOW_DS_TAIKHOAN);
  }
  
  function onsubmenu_danhsachvanbanphaply(){
	loadHtml("dlg_qlvanban_phaply_show","./page/quanlyvanban_phaply.jsp", false);
	func_dlg_qlvanban_phaply_show();
  }
  
  function onsubmenu_vanbanykienchidao(){
	loadHtml("dlg_qlvanban_ykienchidao_show","./page/quanlyvanban_ykienchidao.jsp", false);
	func_dlg_qlvanban_ykienchidao_show();
  }
  
  function onsubmenu_tintuchoatdong_phanloai(){
	loadHtml("dlg_tintuchoatdong_phanloai_show","./page/quanlytintuc_hoatdong_phanloai.jsp", false);
	func_dlg_tintuchoatdong_phanloai_show();
  }
  
  function onsubmenu_tintuchoatdong(){
	loadHtml("dlg_tintuchoatdong_show","./page/quanlytintuc_hoatdong.jsp", false);
	func_dlg_tintuchoatdong_show();
  }
  
  function onsubmenu_phanloaithanhvien(){
	loadHtml("dlg_phanloai_thanhvien_show","./page/quanlyphanloai_thanhvien.jsp", false);
	func_dlg_phanloai_thanhvien_show();
  }
  
  function onsubmenu_tochuc(){
		loadHtml("dlg_tochuc_show","./page/quanly_tochuc.jsp", false);
		func_dlg_tochuc_show();
  }
  
  function onsubmenu_nhansu(){
		loadHtml("dlg_nhansu_show","./page/quanly_nhansu.jsp", false);
		func_dlg_nhansu_show();
  }
  
  function onsubmenu_quanlychuyengia(){
		loadHtml("dlg_quanlychuyengia_show","./page/quanlychuyengia.jsp", false);
		func_dlg_quanlychuyengia_show();
	  }
  function onsubmenu_quanlykiennghi(){
		loadHtml("dlg_kiennghi_show","./page/quanlykiennghi.jsp", false);
		func_dlg_kiennghi_show();
	  }
  function onsubmenu_quanlyphanloai_phieu(){
		loadHtml("dlg_phanloai_phieu_show","./page/quanlyphanloai_phieu.jsp", false);
		func_dlg_phanloai_phieu_show();
	  }
  function onsubmenu_quanlyphanloai_detai_duan(){
		loadHtml("dlg_phanloai_detai_duan_show","./page/quanlyphanloai_detai_duan.jsp", false);
		func_dlg_phanloai_detai_duan_show();
	  }
  function onsubmenu_quanlyphanloai_baocao(){
		loadHtml("dlg_phanloai_baocao_show","./page/quanlyphanloai_baocao.jsp", false);
		func_dlg_phanloai_baocao_show();
	  }
  function onsubmenu_quanlyvaitro(){
		loadHtml("dlg_vaitro_show","./page/quanlyvaitro.jsp", false);
		func_dlg_vaitro_show();
	  }
  function onsubmenu_quanlyphanloai_kq(){
		loadHtml("dlg_phanloai_kq_show","./page/quanlyphanloai_kq.jsp", false);
		func_dlg_phanloai_kq_show();
	  }
  function onsubmenu_quanlyphanloai_khuvuc(){
		loadHtml("dlg_phanloai_khuvuc_show","./page/quanlyphanloai_khuvuc.jsp", false);
		func_dlg_phanloai_khuvuc_show();
	  }
  
  
  	function onsubmenu_detai_duan(){
		loadHtml("dlg_detai_duan_show","./page/quanlydetai_duan.jsp", false);
		func_dlg_detai_duan_show();
	}
  	
  	function onsubmenu_thuyetminh_detai(){
		loadHtml("dlg_thuyetminh_detai_show","./page/quanlythuyetminh_detai.jsp", false);
		func_dlg_thuyetminh_detai_show();
	}
  	
  	function onsubmenu_tieuchi_xd_ntm_cha(){
		loadHtml("dlg_tieuchi_xd_ntm_cha_show","./page/quanlytieuchi_xd_ntm_cha.jsp", false);
		func_dlg_tieuchi_xd_ntm_cha_show();
	}
  	
  	function onsubmenu_tieuchi_xd_ntm_con(){
		loadHtml("dlg_tieuchi_xd_ntm_con_show","./page/quanlytieuchi_xd_ntm_con.jsp", false);
		func_dlg_tieuchi_xd_ntm_con_show();
	}
  	
  	function onsubmenu_tieuchi_ungdung(){
		loadHtml("dlg_tieuchi_ungdung_show","./page/quanlytieuchi_ungdung.jsp", false);
		func_dlg_tieuchi_ungdung_show();
	}
  
	function onsubmenu_nhansu_thamgia(){
		loadHtml("dlg_nhansu_thamgia_show","./page/quanlynhansu_thamgia.jsp", false);
		func_dlg_nhansu_thamgia_show();
	}
	
	function onsubmenu_bb_hophoidong(){
		loadHtml("dlg_bb_hophoidong_show","./page/quanlybb_hophoidong.jsp", false);
		func_dlg_quanly_bb_hophoidong();
	}
	
	function onsubmenu_bb_mohoso(){
		loadHtml("dlg_bb_mohoso_show","./page/quanlybb_mohoso.jsp", false);
		func_dlg_quanly_bb_mohoso();
	}
	
	function onsubmenu_bb_kiemphieu(){
		loadHtml("dlg_bb_kiemphieu_show","./page/quanlybb_kiemphieu.jsp", false);
		func_dlg_quanly_bb_kiemphieu();
	}
	
	function onsubmenu_tochuc_thamgia(){
		loadHtml("dlg_tochuc_thamgia_show","./page/quanly_tochuc_thamgia.jsp", false);
		func_dlg_quanly_tochuc_thamgia();
	}
	
	function onsubmenu_quanly_phieu(){
		loadHtml("dlg_phieu_show","./page/quanly_phieu.jsp", false);
		func_dlg_quanly_phieu();
	}
	
	function onsubmenu_quanly_giaidoan(){
		loadHtml("dlg_giaidoan_show","./page/quanly_giaidoan.jsp", false);
		func_dlg_quanly_giaidoan();
	}
	
	function onsubmenu_detai_tochuc(){
		loadHtml("dlg_detai_tochuc_show","./page/quanly_detai_tochuc.jsp", false);
		func_dlg_quanly_detai_tochuc();
	}
	
	function onsubmenu_quanlyphanloai_sanpham(){
		loadHtml("dlg_phanloai_sanpham_show","./page/quanlyphanloai_sanpham.jsp", false);
		func_dlg_quanly_phanloai_sanpham();
	}
	
	function onsubmenu_sanpham(){
		loadHtml("dlg_sanpham_show","./page/quanly_sanpham.jsp", false);
		func_dlg_quanly_sanpham();
	}
	
	function onsubmenu_tiendo_capkinhphi(){
		loadHtml("dlg_tiendo_capkinhphi_show","./page/quanly_tiendo_capkinhphi.jsp", false);
		func_dlg_quanly_tiendo_capkinhphi();
	}
	
	function onsubmenu_kehoach_capkinhphi(){
		loadHtml("dlg_kehoach_capkinhphi_show","./page/quanly_kehoach_capkinhphi.jsp", false);
		func_dlg_quanly_kehoach_capkinhphi();
	}
	
	function onsubmenu_phanvon_hangmuc(){
		loadHtml("dlg_phanvon_hangmuc_show","./page/quanly_phanvon_hangmuc.jsp", false);
		func_dlg_quanly_phanvon_hangmuc();
	}
	
	function onsubmenu_tiendo_giaingan(){
		loadHtml("dlg_tiendo_giaingan_show","./page/quanly_tiendo_giaingan.jsp", false);
		func_dlg_quanly_tiendo_giaingan();
	}
	
	function onsubmenu_noidung_congviec(){
		loadHtml("dlg_noidungcv_nhom_show","./page/quanly_noidungcv_nhom.jsp", false);
		func_dlg_quanly_noidungcv_nhom();
	}
	
	function onsubmenu_coche_chinhsach(){
		loadHtml("dlg_coche_chinhsach_show","./page/quanly_coche_chinhsach.jsp", false);
		func_dlg_quanly_coche_chinhsach();
	}
	
	function onsubmenu_giaiphap_khcn(){
		loadHtml("dlg_giaiphap_khcn_show","./page/quanly_giaiphap_khcn.jsp", false);
		func_dlg_quanly_giaiphap_khcn();
	}
	
	function onsubmenu_thumuc(){
		loadHtml("dlg_hinhanh_thumuc_show","./page/quanly_hinhanh_thumuc.jsp", false);
		func_dlg_quanly_hinhanh_thumuc();
	}
	
	function onsubmenu_hinhanh_kqncDTDA(){
		loadHtml("dlg_hinhanh_kqncDTDA_show","./page/quanly_hinhanh_kqncDTDA.jsp", false);
		func_dlg_quanly_hinhanh_kqncDTDA();
	}
	
	function onsubmenu_banghinh_kqncDTDA(){
		loadHtml("dlg_banghinh_kqncDTDA_show","./page/quanly_banghinh_kqncDTDA.jsp", false);
		func_dlg_quanly_banghinh_kqncDTDA();
	}
	
	function onsubmenu_hinhanh_kqxdNTM(){
		loadHtml("dlg_hinhanh_kqxdNTM_show","./page/quanly_hinhanh_kqxdNTM.jsp", false);
		func_dlg_quanly_hinhanh_kqxdNTM();
	}
	
	function onsubmenu_banghinh_kqxdNTM(){
		loadHtml("dlg_banghinh_kqxdNTM_show","./page/quanly_banghinh_kqxdNTM.jsp", false);
		func_dlg_quanly_banghinh_kqxdNTM();
	}
	
	function onsubmenu_banghinh_kqxdNTM(){
		loadHtml("dlg_banghinh_kqxdNTM_show","./page/quanly_banghinh_kqxdNTM.jsp", false);
		func_dlg_quanly_banghinh_kqxdNTM();
	}
	
	function onsubmenu_gioithieu_kqxdNTM(){
		loadHtml("dlg_gioithieu_kqxdNTM_show","./page/quanly_gioithieu_kqxdNTM.jsp", false);
		func_dlg_quanly_gioithieu_kqxdNTM();
	}
	
	function onsubmenu_gioithieu_udncDTDA(){
		loadHtml("dlg_gioithieu_kqncDTDA_show","./page/quanly_gioithieu_kqncDTDA.jsp", false);
		func_dlg_quanly_gioithieu_kqncDTDA();
	}
	
	function onsubmenu_ketqua_danhgiahangnam(){
		loadHtml("dlg_ketqua_danhgiahangnam_show","./page/quanly_ketqua_danhgiahangnam.jsp", false);
		func_dlg_quanly_ketqua_danhgiahangnam();
	} 
	
	function onsubmenu_noidung_capkinhphi(){
		loadHtml("dlg_noidung_capkinhphi_show","./page/quanly_noidung_capkinhphi.jsp", false);
		func_dlg_quanly_noidung_capkinhphi();
	}
	
	function onsubmenu_bangbieu_capkinhphi(){
		loadHtml("dlg_bangbieu_capkinhphi_show","./page/quanly_bangbieu_capkinhphi.jsp", false);
		func_dlg_quanly_bangbieu_capkinhphi();
	} 
	
	function onsubmenu_xoaanh(link_vanban,btn_name,msg_name){
		$.ajax({
	        url: root_href + UPLOAD_SERVLET, 
	        data:{
	          action: CODE_DELETE,
	          deleteFile: link_vanban
	        }, 
	        async:false,
	        success:function(jsonData) {
	        	
	      	  $('#'+ btn_name + '').show();
	      	  $('#'+ msg_name +'').hide();
	      	 
			  return;
	        }});
	}
	
	
  
</script>