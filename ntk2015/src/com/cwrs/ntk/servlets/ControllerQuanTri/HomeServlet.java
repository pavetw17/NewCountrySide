package com.cwrs.ntk.servlets.ControllerQuanTri;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Calendar;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import com.cwrs.ntk.common.Definitions;
import com.cwrs.ntk.common.JResult;
import com.cwrs.ntk.models.TblBienbanHophoidongEntity;
import com.cwrs.ntk.models.TblBienbanMohosoEntity;
import com.cwrs.ntk.models.TblChuyengiaEntity;
import com.cwrs.ntk.models.TblDetaiDuanEntity;
import com.cwrs.ntk.models.TblNhansuEntity;
import com.cwrs.ntk.models.TblNhansuThamgiaEntity;
import com.cwrs.ntk.models.TblThuyetminhDetaiDuanEntity;
import com.cwrs.ntk.models.TblTieuchiUngdungEntity;
import com.cwrs.ntk.models.TblTieuchiXaydungNtmEntity;
import com.cwrs.ntk.models.TblTochucEntity;
import com.cwrs.ntk.models.TblXadiemEntity;
import com.cwrs.ntk.servlets.dao.DBOperation;
import com.cwrs.ntk.servlets.dao.DlgChuyenGia;
import com.cwrs.ntk.servlets.dao.DlgKienNghi;
import com.cwrs.ntk.servlets.dao.DlgMain;
import com.cwrs.ntk.servlets.dao.DlgNhanSu;
import com.cwrs.ntk.servlets.dao.DlgOperation;
import com.cwrs.ntk.servlets.dao.DlgPhanLoaiBaoCao;
import com.cwrs.ntk.servlets.dao.DlgPhanLoaiDetaiDuan;
import com.cwrs.ntk.servlets.dao.DlgPhanLoaiKhuVuc;
import com.cwrs.ntk.servlets.dao.DlgPhanLoaiKq;
import com.cwrs.ntk.servlets.dao.DlgPhanLoaiPhieu;
import com.cwrs.ntk.servlets.dao.DlgPhanLoaiThanhVien;
import com.cwrs.ntk.servlets.dao.DlgPhanLoaiTinTuc;
import com.cwrs.ntk.servlets.dao.DlgPhanLoaiVanBan;
import com.cwrs.ntk.servlets.dao.DlgQuyen;
import com.cwrs.ntk.servlets.dao.DlgTaiKhoan;
import com.cwrs.ntk.servlets.dao.DlgTinTucHoatDong;
import com.cwrs.ntk.servlets.dao.DlgToChuc;
import com.cwrs.ntk.servlets.dao.DlgVaiTro;
import com.cwrs.ntk.servlets.dao.DlgVanBanPhapLy;
import com.cwrs.ntk.servlets.dao.DlgYKienChiDao;
import com.docxfactory.WordProcessingMerger;
/**
 * Created by VN on 3/31/2015.
 */
@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	@Resource(name = "jdbc/ntm")
    private DataSource ds;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequests(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequests(request,response);
    }

    protected void processRequests(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
       /* System.out.println("check value: " + request.getParameter("values"));*/
        String codeRequest = request.getParameter("action");
        //System.out.println("--- Code Request: ---" + codeRequest);
       
        if (codeRequest==null ||"null".equalsIgnoreCase(codeRequest))return;
        PrintWriter writeResponse = response.getWriter();
        DBOperation dbo = new DBOperation();
        Connection conn = null;
        try {
            conn = ds.getConnection();
            dbo.setConnection(conn);
            switch(Integer.parseInt(codeRequest)) {
                case Definitions.ACT_DB_CHECK_DATA_EXISTS: checkDataExists(dbo,request,writeResponse); break;
                case Definitions.ACT_DB_MAX_DATA: checkMAX(dbo, request, writeResponse ); break;

                /* Danh sach phan quyen*/
                case Definitions.ACT_GET_DATA_TO_FORM_SHOW_DANHSACHQUYEN: getDatatoDanhSachPhanQuyenForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_DANHSACHQUYEN: getDatatoEditDanhSachPhanQuyenForm(dbo,request,response,writeResponse); break;
                case Definitions.ACT_GET_LIST_DANHSACHQUYEN_TO_CHECKBOX: getListQuyen2ComboHtml(dbo, request, writeResponse);break;
                
                /*Danh sach tai khoan*/
                case Definitions.ACT_GET_DATA_TO_FORM_SHOW_DS_TAIKHOAN: getDatatoDanhSachTaiKhoanForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_DS_TAIKHOAN: getDatatoEditDanhSachTaiKhoanForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_USERLIST: getData2EditUser(dbo, request, writeResponse);break;
                
                /* Danh sach phan loai van ban */
                case Definitions.ACT_GET_DATA_TO_FORM_SHOW_DS_PHANLOAIVANBAN: getDatatoDs_PhanLoaiVanBanForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_DS_PHANLOAIVANBAN: getDatatoEditDs_PhanLoaiVanBanForm(dbo, request, response, writeResponse); break;
                case Definitions.ACT_GET_VANBAN_PHANLOAI_TO_CBB: getVanBanPhanLoai2Cbb(dbo, request, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_FORM_SHOW_DS_VANBANPHAPLY: getDatatoDs_VanBanPhapLyForm(dbo, request, response, writeResponse); break;
                case Definitions.ACT_GET_DATA_TO_EDIT_DS_VANBANPHAPLY: getDatatoEditDs_VanBanPhapLyForm(dbo, request, response, writeResponse); break;
                
                /*Y kien chi dao*/
                case Definitions.ACT_GET_DATA_TO_FORM_SHOW_DS_YKIENCHIDAO: getDatatoDs_YKienChiDaoForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_DS_YKIENCHIDAO: getDatatoEditDs_YKienChiDaoForm(dbo, request, response, writeResponse); break;
                
                /*Tin tuc hoat dong*/
                case Definitions.ACT_GET_DATA_TO_FORM_SHOW_TINTUCHOATDONG_PHANLOAI: getDatato_PhanLoaiTinTucHoatDongForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_TINTUCHOATDONG_PHANLOAI: getDatatoEdit_PhanLoaiTinTucHoatDongForm(dbo, request, response, writeResponse); break;
                case Definitions.ACT_GET_TINTUCHOATDONG_TO_CBB: getTinTucPhanLoai2Cbb(dbo, request, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_FORM_SHOW_TINTUCHOATDONG: getDatato_TinTucHoatDongForm(dbo, request, response, writeResponse); break;
                case Definitions.ACT_GET_DATA_TO_EDIT_DS_TINTUCHOATDONG: getDatatoEdit_TinTucHoatDongForm(dbo, request, response, writeResponse); break;
                
                /*To chuc*/
                case Definitions.ACT_GET_DATA_TO_FORM_TOCHUC: getDatato_ToChucForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_TOCHUC: getDatatoEdit_ToChucForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_TOCHUC_TO_CBB: getToChuc2Cbb(dbo, request, writeResponse);break;
                
                /*Nhan su*/
                case Definitions.ACT_GET_DATA_TO_FORM_SHOW_NHANSU: getDatato_NhanSuForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_NHANSU: getDatatoEdit_NhanSuForm(dbo, request, writeResponse);break;
                
                /*Phan loai thanh vien*/
                case Definitions.ACT_GET_DATA_TO_FORM_PHANLOAI_THANHVIEN: getDatato_PhanLoaiThanhVienForm(dbo, request, response, writeResponse); break;
                case Definitions.ACT_GET_DATA_TO_EDIT_PHANLOAI_THANHVIEN: getDatatoEdit_PhanLoaiThanhVienForm(dbo, request, response, writeResponse); break;
                 
                /*Kien nghi*/
                case Definitions.ACT_GET_DATA_TO_FORM_SHOW_KIENNGHI: getDatatoKienNghiForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_KIENNGHI: getDatatoEditKienNghiForm(dbo, request, response, writeResponse);break;
                
                /*phan loai phieu*/
                case Definitions.ACT_GET_DATA_TO_FORM_SHOW_PHANLOAI_PHIEU: getDatatoPhanLoaiPhieuForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_PHANLOAI_PHIEU: getDatatoEditPhanLoaiPhieuForm(dbo, request, response, writeResponse);break;

                /*phanloai_detai_duan*/
                case Definitions.ACT_GET_DATA_TO_FORM_SHOW_PHANLOAI_DETAI_DUAN: getDatatoPhanLoaiDetaiDuanForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_PHANLOAI_DETAI_DUAN: getDatatoEditPhanLoaiDetaiDuanForm(dbo, request, response, writeResponse);break;
                
                /*phan loai bao cao*/
                case Definitions.ACT_GET_DATA_TO_FORM_SHOW_PHANLOAI_BAOCAO: getDatatoPhanLoaiBaoCaoForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_PHANLOAI_BAOCAO: getDatatoEditPhanLoaiBaoCaoForm(dbo, request, response, writeResponse);break;
                
                /*vai tro*/
                case Definitions.ACT_GET_DATA_TO_FORM_SHOW_VAITRO: getDatatoVaiTroForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_VAITRO: getDatatoEditVaiTroForm(dbo, request, response, writeResponse);break;
                
                /*phan loai ket qua*/
                case Definitions.ACT_GET_DATA_TO_FORM_SHOW_PHANLOAI_KQ: getDatatoPhanLoaiKqForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_PHANLOAI_KQ: getDatatoEditPhanLoaiKqForm(dbo, request, response, writeResponse);break;
                
                /*phan loai khu vuc*/
                case Definitions.ACT_GET_DATA_TO_FORM_SHOW_PHANLOAI_KHUVUC: getDatatoPhanLoaiKhuVucForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_PHANLOAI_KHUVUC: getDatatoEditPhanLoaiKhuVucForm(dbo, request, response, writeResponse);break;
                
                /*Chuyen gia*/
                case Definitions.ACT_GET_DATA_TO_FORM_CHUYENGIA: getDatatoChuyenGiaForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_CHUYENGIA: getDatatoEditChuyenGiaForm(dbo, request, response, writeResponse);break;
                
                /*De tai du an*/
                case Definitions.ACT_GET_NHOM_DETAI_DUAN_TO_CBB: getNhomDeTaiDuAn2Cbb(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_FORM_DETAI_DUAN: getDatatoDeTaiDuAnForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_DETAI_DUAN: getDatatoEditDeTaiDuAnForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DETAI_DUAN_TO_CBB: getDeTaiDuAn2Cbb(dbo, request, response, writeResponse);break;
                
                /*Thuyet minh de tai du an*/
                case Definitions.ACT_GET_DATA_TO_FORM_THUYETMINH_DETAI: getDatatoThuyetMinhDeTaiForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_THUYETMINH_DETAI: getDatatoEditThuyetMinhDeTaiForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_THUYETMINH_DETAI_TO_CBB: getThuyetMinh2Cbb(dbo, request, response, writeResponse);break;
               
                /*Tieu chi xay dung ntm*/
                case Definitions.ACT_GET_DATA_TO_FORM_TIEUCHI_XD_NTM_CHA: getDatatoTieuChiNTMChaForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_TIEUCHI_XD_NTM_CHA: getDatatoEditTieuChiNTMChaForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_TIEUCHI_XD_NTM_CHA_TO_CBB: getTieuChiNTMCha2Cbb(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_FORM_TIEUCHI_XD_NTM_CON: getDatatoTieuChiNTMConForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_TIEUCHI_XD_NTM_CON: getDatatoEditTieuChiNTMConForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_KHUVUC_TO_CBB: getKhuVuc2Cbb(dbo, request, response, writeResponse);break;
                
                /*Tieu chi ung dung*/
                case Definitions.ACT_GET_DATA_TO_FORM_TIEUCHI_UNGDUNG: getDatatoTieuChiUngDungForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_TIEUCHI_UNGDUNG: getDatatoEditTieuChiUngDungForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_TIEUCHI_CON_TO_CBB: getTieuChiCon2Cbb(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_XADIEM_TO_CBB: getXaDiem2Cbb(dbo, request, response, writeResponse);break;
                
                /*Nhan su tham gia*/
                case Definitions.ACT_GET_DATA_TO_FORM_NHANSU_THAMGIA: getDatatoNhanSuThamGiaForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_NHANSU_THAMGIA: getDatatoEditNhanSuThamGiaForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_NHANSU_TO_CBB: getNhanSu2Cbb(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_VAITRO_TO_CBB: getVaiTro2Cbb(dbo, request, response, writeResponse);break;
                
                /*Bien ban hop hoi dong*/
                case Definitions.ACT_GET_DATA_TO_FORM_BIENBAN_HOPHOIDONG: getDatatoBienBanHopHoiDongForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_BIENBAN_HOPHOIDONG: getDatatoEditBienBanHopHoiDongForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_CHUYENGIA_TO_CBB: getChuyenGia2Cbb(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_OUT_BIENBAN_HOPHOIDONG: getDatatoOutBienBanHopHoiDongForm(dbo, request, response, writeResponse);break;
             
                /*Bien ban mo ho so*/
                case Definitions.ACT_GET_DATA_TO_FORM_BIENBAN_MOHOSO: getDatatoBienBanMoHoSoForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_BIENBAN_MOHOSO: getDatatoEditBienBanMoHoSoForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_OUT_BIENBAN_MOHOSO: getDatatoOutBienBanMoHoSoForm(dbo, request, response, writeResponse);break;
                
                /*Bien ban kiem phieu*/
                case Definitions.ACT_GET_DATA_TO_FORM_BIENBAN_KIEMPHIEU: getDatatoBienBanKiemPhieuForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_BIENBAN_KIEMPHIEU: getDatatoEditBienBanKiemPhieuForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_OUT_BIENBAN_KIEMPHIEU: getDatatoOutBienBanKiemPhieuForm(dbo, request, response, writeResponse);break;
                
                /*To chuc tham gia*/
                case Definitions.ACT_GET_DATA_TO_FORM_TOCHUC_THAMGIA: getDatatoToChucThamGiaForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_TOCHUC_THAMGIA: getDatatoEditToChucThamGiaForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_OUT_TOCHUC_THAMGIA: getDatatoOutToChucThamGiaForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_PHANLOAI_KQ_TO_CBB: getPhanLoaiKq2Cbb(dbo, request, response, writeResponse);break;
                
                /*Phieu*/
                case Definitions.ACT_GET_DATA_TO_FORM_PHIEU: getDatatoPhieuForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_PHIEU: getDatatoEditPhieuForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_OUT_PHIEU: getDatatoOutPhieuForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_PHANLOAI_PHIEU_TO_CBB: getPhanLoaiPhieu2Cbb(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_KIENNGHI_TO_CBB: getKienNghi2Cbb(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_PHANLOAI_THANHVIEN_TO_CBB: getPhanLoaiThanhVien2Cbb(dbo, request, response, writeResponse);break;
                
                /*Giai doan*/
                case Definitions.ACT_GET_DATA_TO_FORM_GIAIDOAN: getDatatoGiaiDoanForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_GIAIDOAN: getDatatoEditGiaiDoanForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_GIAI_DOAN_TO_CBB: getGiaiDoan2Cbb(dbo, request, response, writeResponse);break;
                
                /*De tai to chuc*/
                case Definitions.ACT_GET_DATA_TO_FORM_DETAI_TOCHUC: getDatatoDeTaiToChucForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_DETAI_TOCHUC: getDatatoEditDeTaiToChucForm(dbo, request, response, writeResponse);break;
                
                /*Phan loai san pham*/
                case Definitions.ACT_GET_DATA_TO_FORM_PHANLOAI_SANPHAM: getDatatoPhanLoaiSanPhamForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_PHANLOAI_SANPHAM: getDatatoEditPhanLoaiSanPhamForm(dbo, request, response, writeResponse);break;
                
                /*San pham*/
                case Definitions.ACT_GET_DATA_TO_FORM_SANPHAM: getDatatoSanPhamForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_SANPHAM: getDatatoEditSanPhamForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_PHANLOAI_SANPHAM_TO_CBB: getPhanLoaiSanPham2Cbb(dbo, request, response, writeResponse);break;
                
                /*Ke hoach cap kinh phi*/
                case Definitions.ACT_GET_DATA_TO_FORM_KH_CAPKINHPHI: getDatatoKHCapKinhPhiForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_KH_CAPKINHPHI: getDatatoEditKHCapKinhPhiForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_KH_CAPKINHPHI_CBB: getTienDoCapKinhPhi2Cbb(dbo, request, response, writeResponse);break;
               
                /*Tien do cap kinh phi*/
                case Definitions.ACT_GET_DATA_TO_FORM_TD_CAPKINHPHI: getDatatoTDCapKinhPhiForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_TD_CAPKINHPHI: getDatatoEditTDCapKinhPhiForm(dbo, request, response, writeResponse);break;
                
                /*Phan bo von theo hang muc*/
                case Definitions.ACT_GET_DATA_TO_FORM_PHANBOVON_THEOHANGMUC: getDatatoPhanVonHangMucForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_PHANBOVON_THEOHANGMUC: getDatatoEditPhanVonHangMucForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_TOCHUC_DETAI_TOCHUC_TO_CBB: getTOCHUCDeTaiToChuc2Cbb(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DETAI_DETAI_TOCHUC_TO_CBB: getDETAIDeTaiToChuc2Cbb(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_THUYETMINH_DETAI_TOCHUC_TO_CBB: getTHUYETMINHDeTaiToChuc2Cbb(dbo, request, response, writeResponse);break;
                
                /*Noi dung cong viec thuyet minh */                
                case Definitions.ACT_GET_DATA_TO_FORM_NOIDUNG_THUYETMINH_NHOM: getDatatoNoiDungThuyetMinhNhomForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_NOIDUNG_THUYETMINH_NHOM: getDatatoEditNoiDungThuyetMinhNhomForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_FORM_NOIDUNG_THUYETMINH_CON: getDatatoNoiDungThuyetMinhConForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_NOIDUNG_THUYETMINH_CON: getDatatoEditNoiDungThuyetMinhConForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_NOIDUNG_THUYETMINH_NHOM_TO_CBB: getNoiDungThuyetMinhNhom2Cbb(dbo, request, response, writeResponse);break;
                
                
                case Definitions.ACT_GET_DATA_TO_FORM_TIENDO_GIAINGAN: getDatatoTienDoGiaiNganForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_TIENDO_GIAINGAN: getDatatoEditTienDoGiaiNganForm(dbo, request, response, writeResponse);break;
                
                case Definitions.ACT_GET_DATA_TO_FORM_COCHE_CHINHSACH: getDatatoCoCheChinhSachForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_COCHE_CHINHSACH: getDatatoEditCoCheChinhSachForm(dbo, request, response, writeResponse);break;
                
                case Definitions.ACT_GET_DATA_TO_FORM_GIAIPHAP_KHCN: getDatatoGiaiPhapKHCNForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_GIAIPHAP_KHCN: getDatatoEditGiaiPhapKHCNForm(dbo, request, response, writeResponse);break;
                
                case Definitions.ACT_GET_DATA_TO_BAIVIET_GIOITHIEU_NTM: getDatatoBaiVietGioiThieuNTMForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_BAIVIET_GIOITHIEU_NTM: getDatatoEditBaiVietGioiThieuForm(dbo, request, response, writeResponse);break;
                
                case Definitions.ACT_GET_DATA_TO_BAIVIET_GIOITHIEU_UDNC_DTDA: getDatatoBaiVietGioiThieuDTDAForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_BAIVIET_GIOITHIEU_UDNC_DTDA: getDatatoEditBaiVietGioiDTDAForm(dbo, request, response, writeResponse);break;
                
                case Definitions.ACT_GET_DATA_TO_KETQUA_DANHGIA_HANGNAM: getDatatoKetQuaDanhGiaHangNamForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_KETQUA_DANHGIA_HANGNAM: getDatatoEditKetQuaDanhGiaHangNamForm(dbo, request, response, writeResponse);break;
                
                
                case Definitions.ACT_GET_DATA_TO_FORM_UPLOAD_BANGHINH_DETAI: getDatatoUploadBangHinhDeTaiForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_FORM_UPLOAD_HINHANH_DETAI: getDatatoUploadHinhAnhDeTaiForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_FOLDER_HINHANH_DETAI_TO_CBB: getFolderHinhAnhDeTai2Cbb(dbo, request, response, writeResponse);break;
                
                case Definitions.ACT_GET_DATA_TO_FORM_THUMUC: getDatatoThuMucForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_THUMUC: getDatatoEditThuMucForm(dbo, request, response, writeResponse);break;
                
                case Definitions.ACT_GET_DATA_TO_FORM_UPLOAD_BANGHINH_NTM: getDatatoUploadBangHinhNTMForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_FORM_UPLOAD_HINHANH_NTM: getDatatoUploadHinhAnhNTMForm(dbo, request, response, writeResponse);break;
                
                case Definitions.ACT_GET_DATA_TO_FORM_NOIDUNG_CAPKINHPHI: getDatatoNoiDungCapKinhPhiForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_NOIDUNG_CAPKINHPHI: getDatatoEditNoiDungCapKinhPhiForm(dbo, request, response, writeResponse);break;
                
                case Definitions.ACT_GET_DATA_TO_FORM_DTDA_THEO_TIEUCHIUNGDUNG_NTM: getDatattoDTDATheoTCUDNTMForm(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_TO_EDIT_DTDA_THEO_TIEUCHIUNGDUNG_NTM: getDatattoEditDTDATheoTCUDNTMForm(dbo, request, response, writeResponse);break;
               
                case Definitions.ACT_GET_DATA_OUT_TINTUCHOATDONG: getDataOutTinTucHoatDong(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_OUT_GIOITHIEU_KQXDNTM: getDataOutKQXDNTM(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_OUT_GIOITHIEU_KQNCDTDA: getDataOutKQNCDTDA(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_OUT_KETQUA_DANHGIA_HANGNAM: getDataOutKQDanhGiaHangNam(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_OUT_TIEUCHI_XD_NTM_CON: getDataOutTieuChiXDNTMCon(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_OUT_TIEUCHI_DETAI_DUAN: getDataOutTieuChiDeTaiDuAn(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_OUT_NHANSU_THAMGIA: getDataOutNhanSuThamGia(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_OUT_DETAI_TOCHUC: getDataOutDeTaiToChuc(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_OUT_KH_CAPKINHPHI: getDataOutKHCapKinhPhi(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_OUT_TD_CAPKINHPHI: getDataOutTDCapKinhPhi(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_OUT_NOIDUNG_CAPKINHPHI: getDataOutNoiDungCapKinhPhi(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_OUT_NOIDUNG_THUYETMINH_CON: getDataOutNoiDungThuyetMinhCon(dbo, request, response, writeResponse);break;
                case Definitions.ACT_GET_DATA_OUT_TIENDO_GIAINGAN: getDataOutTienDoGiaiNgan(dbo, request, response, writeResponse);break;

                case Definitions.ACT_GET_DATA_FORM_BANGBIEU_CAPKINHPHI: getDataFormBangBieuCapKinhPhi(dbo, request, response, writeResponse);break;
                
                 
                
                //Insert/Update to Database
                case Definitions.ACT_DB_INSERT_UPDATE_MULTI_OBJECT: execInsertUpdatedMultiRecords2DBByClient(dbo, request, writeResponse);break;
                case Definitions.ACT_DB_UPDATE_DATAGRID: execUpdateDataGrid(dbo, request, writeResponse); break; //using the grid eidt save 
                case Definitions.ACT_DB_DELETE_OBJECT : deleteRecord(dbo, request, writeResponse); break;
            
                default:System.err.println("UNKNOW ACTION");  	break;
            }
        } catch (SQLException e) {
            System.out.println( "HomeServlet SQLException: " + e.toString());
        } finally {
            if (conn != null) {
                dbo.closeConnection();
            }
        }
    }



	private void getDataFormBangBieuCapKinhPhi(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		// TODO Auto-generated method stub
		String maXuat = request.getParameter("maXuat");
		System.out.println(maXuat);
			 try 
			    { 
				 Calendar cal = Calendar.getInstance();
				 int month = cal.get(Calendar.MONTH) + 1;
				 int year = cal.get(Calendar.YEAR);
				 String path = getServletContext().getRealPath("uploads/");
				 path += "/" + "bangbieu" + "/" + year + "/" + month + "/" ;
					
				 File f_year = new File(path);
					if (!f_year.exists()) {
						f_year.mkdirs();
					}
					
				/*	 WordProcessingCompiler.compile( 
						        "C:/testReport/exercises/templates/top_level_items.docx", 
						        "C:/testReport/exercises/templates/top_level_items.dfw");*/
			      WordProcessingMerger.load("C:/testReport/exercises/templates/top_level_items.dfw"); 
			 
			     /* for (int i = 0; i < 3; i++) 
			      { 
			        WordProcessingMerger.paste("Account"); 
			      } */
			      WordProcessingMerger.save("C:/testReport/top_level_items.pdf"); 
			      WordProcessingMerger.close(); 
			      //WordProcessingMerger.save(path + "top_level_items.pdf"); 
			      
			     // String linkHinh = "uploads/" + "bangbieu" + "/" + year + "/" + month + "/" + "top_level_items.pdf"; 
			     // writeResponse.print(linkHinh);
			    } 
			 
			    catch (Throwable e) 
			    { 
			      System.err.println(e); 
			    }
			 
			 
	}

	private void getDataOutTienDoGiaiNgan(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				"ngaygiaingan",  "sotien",   "a.ghichu",  "tendt", "tentc",  "masodt",  
				"ten_noidung"
        };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "  tbl_tiendo_giaingan a inner join tbl_tochuc b on a.id_tochuc= b.id_tochuc "
	    		+ " inner join tbl_detai_duan c on a.id_detai = c.id_detai"
	    		+ " inner join tbl_noidung_cv d on a.id_noidung = d.id_noidung"
	    		+ " inner join tbl_thuyetminh_detai_duan e on a.id_thuyetminhdetai = e.id_thuyetminh_detai_duan "));
	}

	private void getDataOutNoiDungThuyetMinhCon(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				"ten_noidung", " masodt", " thoigian_batdau", "tentc",
				 "thoigian_ketthuc",  "tengiaidoan",  "phantram_hoanthanh",  "(select ten_noidung from tbl_noidung_cv where id_noidung = a.id_noidung_cha)  as nhom_noidung"
        };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "  tbl_noidung_cv a inner join tbl_thuyetminh_detai_duan b on a.id_thuyetminh_detai = b.id_thuyetminh_detai_duan "
	    		+ " inner join tbl_giaidoan c on a.id_giaidoan = c.id_giaidoan"
	    		+ "  inner join tbl_tochuc d on a.id_tochuc= d.id_tochuc "));
	}

	private void getDataOutNoiDungCapKinhPhi(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				"ten_noidung", "f.ghichu",   "a.sotien" , "tendt" , "tentc","masodt"
        };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, " tbl_noidung_capkinhphi a  inner join tbl_noidung_cv b on a.id_noidung = b.id_noidung "
	    		+ "  inner join tbl_tochuc c on a.id_tochuc= c.id_tochuc"
	    		+ "  inner join tbl_detai_duan d on a.id_detai = d.id_detai"
	    		+ "  inner join tbl_thuyetminh_detai_duan e on a.id_thuyetminhdetai = e.id_thuyetminh_detai_duan"
	    		+ "  inner join tbl_tiendo_capkinhphi f on f.id_tiendo_capkinhphi = a.id_tiendo_capkinhphi"
	    		+ " "));
	}

	private void getDataOutTDCapKinhPhi(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				"sotien",  "a.ghichu",  "tendt" ,  "tentc",  "masodt",  "ngaycap "
		};
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_tiendo_capkinhphi a inner join tbl_thuyetminh_detai_duan b on a.id_thuyetminhdetai = b.id_thuyetminh_detai_duan"
	    		+ " inner join tbl_tochuc c on a.id_tochuc= c.id_tochuc"
	    		+ " inner join tbl_detai_duan d on a.id_detai = d.id_detai"));
	}

	private void getDataOutKHCapKinhPhi(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				"sotien",  "a.ghichu",  "tendt" ,  "tentc", " masodt",  "ngaydukiencap "
       };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_kh_capkinhphi a inner join tbl_thuyetminh_detai_duan b on a.id_thuyetminhdetai = b.id_thuyetminh_detai_duan"
	    		+ " inner join tbl_tochuc c on a.id_tochuc= c.id_tochuc"
	    		+ " inner join tbl_detai_duan d on a.id_detai = d.id_detai"));
	
	}

	private void getDataOutDeTaiToChuc(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				 "tendt" , " tentc",  "masodt", " maso" 
       };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_detai_tochuc a inner join tbl_thuyetminh_detai_duan b on a.id_thuyetminhdetai = b.id_thuyetminh_detai_duan "
	    		+ " inner join tbl_tochuc c on a.id_tochuc= c.id_tochuc"
	    		+ " inner join tbl_detai_duan d on a.id_detai = d.id_detai"));
	
	}

	private void getDataOutNhanSuThamGia(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				"hoten " , " noidungthamgia"," masodt", "ten_vaitro", "sothangthamgia", "tentc"  
       };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_nhansu_thamgia a  inner join tbl_nhansu b on a.id_nhansu= b.id_nhansu "
	    		+ " inner join tbl_tochuc d on d.id_tochuc= b.id_tochuc"
	    		+ " inner join tbl_thuyetminh_detai_duan e on a.id_thuyetminh_detai = e.id_thuyetminh_detai_duan"
	    		+ " inner join tbl_vaitro f on a.id_vaitro = f.id_vaitro"));

	}

	private void getDataOutTieuChiDeTaiDuAn(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
 		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				"ten_tieuchi",  "masodt",  "ten_xadiem "  
       };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_tieuchi_ungdung a inner join tbl_xadiem b on a.id_xadiem = b.id_xadiem "
	    		+ " inner join tbl_thuyetminh_detai_duan c on a.id_thuyetminh_detai = c.id_thuyetminh_detai_duan "
	    		+ " inner join tbl_tieuchi_xaydung_ntm d on a.id_tieuchi = d.id_tieuchi"));

	}

	private void getDataOutTieuChiXDNTMCon(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				"(select  ten_tieuchi from tbl_tieuchi_xaydung_ntm where id_tieuchi in (select id_tieuchi_cha from tbl_tieuchi_xaydung_ntm where id_tieuchi = 20 and id_tieuchi_cha is not null))  as ten_tieuchi_cha ",
				"ten_tieuchi",  "noidung_tieuchi",  "chitieu_phaidat",  "ten_khuvuc"  
       };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_tieuchi_xaydung_ntm a inner join tbl_phanloai_khuvuc b on a.id_khuvuc = b.id_khuvuc "));
	}

	private void getDataOutKQDanhGiaHangNam(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				"ten_tieuchi",  "tiendo_hoanthanh",  "ghichu", " ngay_danhgia",  "danhgiachonam",  "ten_xadiem",
		"case when tieuchi_ungdung_khcn = 1 then ('Có') else ('Không')  end as tieuchi_ungdung_khcn"   
       };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_danhgia_kq_theonam a "
	    		+ " inner join tbl_xadiem b on a.id_xadiem = b.id_xadiem"
	    		+ " inner join tbl_tieuchi_xaydung_ntm c on a.id_tieuchi = c.id_tieuchi"));

	}

	private void getDataOutKQNCDTDA(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				"tentieude",  "ngaycongbo",  
		 "case when a.tinhtrang = true then ('Hiện') else ('Ẩn')  end as tinhtrang",  
		  "tomtatnoidung",  "noidungbv",  "noidung",  "tentc",  "masodt",  "tendt" , "ten_xadiem"
       };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_baiviet_detai a "
	    		+ " inner join tbl_xadiem b on a.id_xadiem = b.id_xadiem "
	    		+ " inner join tbl_tochuc c on a.id_tochuc = c.id_tochuc "
	    		+ " inner join tbl_thuyetminh_detai_duan d on a.id_thuyetminhdetai = d.id_thuyetminh_detai_duan"
	    		+ " inner join tbl_detai_duan e on a.id_detai = e.id_detai"));

	}

	private void getDataOutKQXDNTM(DBOperation dbo, HttpServletRequest request,
			HttpServletResponse response, PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				"tentieude",  "ngaycongbo",  
				"case when tinhtrang = true then ('Hiện') else ('Ẩn')  end as tinhtrang",  
					"tomtatnoidung",  "noidungbv",  "ten_xadiem"
       };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_baiviet a inner join tbl_xadiem b on a.id_xadiem = b.id_xadiem"));

	}

	private void getDataOutTinTucHoatDong(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				"tieude","ngaytao",
				"tomtat","noidung","ten_phanloai"
		};
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_tintuc INNER JOIN tbl_phanloai_tintuc ON tbl_tintuc.id_phanloai_tintuc = tbl_phanloai_tintuc.id_phanloai_tintuc"));

	}

	private void getDatattoEditDTDATheoTCUDNTMForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String IdTieuchi = request.getParameter("IdTieuchi");
		String[] values = new String[] {
        		"a.id_tieuchi", "a.id_thuyetminh_detai" , "a.id_xadiem", "ten_xadiem",  "masodt",  "ten_tieuchi" ,
        		"(select  ten_tieuchi from tbl_tieuchi_xaydung_ntm where id_tieuchi in "
        		+ "	(select id_tieuchi_cha from tbl_tieuchi_xaydung_ntm where id_tieuchi = "+IdTieuchi+" and id_tieuchi_cha is not null))  as ten_tieuchi_cha"

        };

	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, " tbl_tieuchi_ungdung a  inner join tbl_xadiem b on a.id_xadiem = b.id_xadiem "
        		+ " inner join tbl_thuyetminh_detai_duan c on a.id_thuyetminh_detai = c.id_thuyetminh_detai_duan "
        		+ " inner join tbl_tieuchi_xaydung_ntm d on a.id_tieuchi = d.id_tieuchi "));

		
	}

	private void getDatattoDTDATheoTCUDNTMForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;
        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"a.id_tieuchi", "a.id_thuyetminh_detai" , "a.id_xadiem", "ten_xadiem",  "masodt",  "ten_tieuchi" 

        };
        writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values," tbl_tieuchi_ungdung a  inner join tbl_xadiem b on a.id_xadiem = b.id_xadiem "
        		+ " inner join tbl_thuyetminh_detai_duan c on a.id_thuyetminh_detai = c.id_thuyetminh_detai_duan "
        		+ " inner join tbl_tieuchi_xaydung_ntm d on a.id_tieuchi = d.id_tieuchi ",null));

		
	}

	private void getDatatoEditNoiDungCapKinhPhiForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				"id_detai", "id_thuyetminhdetai", "id_tochuc", "id_noidung","id_tiendo_capkinhphi", 
			       "sotien"
		};
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_noidung_capkinhphi"));

	}

	private void getDatatoNoiDungCapKinhPhiForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;
        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"a.id_detai", "id_thuyetminhdetai", "a.id_tochuc", "a.id_noidung", "ten_noidung", "id_tiendo_capkinhphi", 
        	       "sotien","tentc" ,"tendt"

        };
        writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,"tbl_noidung_capkinhphi a inner join tbl_noidung_cv b on a.id_noidung = b.id_noidung  inner join tbl_tochuc c on a.id_tochuc= c.id_tochuc "
        		+ " inner join tbl_detai_duan d on a.id_detai = d.id_detai","id_tiendo_capkinhphi"));

	}

	private void getTienDoCapKinhPhi2Cbb(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getTienDoCapKinhPhi2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}

	private void getDatatoEditKetQuaDanhGiaHangNamForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				"id_xadiem", "id_tieuchi", "tiendo_hoanthanh", "ghichu", "ngay_danhgia", 
			       "id_nguoidanhgia", "danhgiachonam", "tieuchi_ungdung_khcn"
		};
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_danhgia_kq_theonam"));

	}

	private void getDatatoKetQuaDanhGiaHangNamForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"ten_xadiem","tiendo_hoanthanh", "id ","ngay_danhgia","case when tieuchi_ungdung_khcn = 1 then ('Có'::text) else ('Không'::text)  end as tieuchi_ungdung_khcn"

        };
        writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,"tbl_danhgia_kq_theonam a inner join tbl_xadiem b on a.id_xadiem = b.id_xadiem","id"));

	}

	private void getDatatoEditBaiVietGioiDTDAForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				"id_baiviet", "tentieude","ngaycongbo","case when tinhtrang = true then ('true') else ('false')  end as tinhtrang", "id_xadiem",
				"tomtatnoidung","noidungbv","noidung","id_tochuc","id_thuyetminhdetai","id_detai"
		};
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_baiviet_detai"));

	}

	private void getDatatoBaiVietGioiThieuDTDAForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"id_baiviet", "tentieude","ngaycongbo","case when tinhtrang = true then ('Hiển'::text) else ('Ẩn'::text)  end as tinhtrang"

        };
        writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,"tbl_baiviet_detai","id_baiviet"));

	}

	private void getDatatoEditBaiVietGioiThieuForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				"id_baiviet", "tentieude","ngaycongbo","case when tinhtrang = true then ('true') else ('false')  end as tinhtrang", "id_xadiem",
				"tomtatnoidung","noidungbv","noidung"
		};
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_baiviet"));

	}

	private void getDatatoBaiVietGioiThieuNTMForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"id_baiviet", "tentieude","ngaycongbo","case when tinhtrang = true then ('Hiển'::text) else ('Ẩn'::text)  end as tinhtrang"

        };
        writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,"tbl_baiviet","id_baiviet"));

	}

	private void getDatatoUploadHinhAnhNTMForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"id_picture", "pathfile","ten_xadiem"

        };
        String table = "  tbl_picture a inner join tbl_xadiem b on a.id_xadiem = b.id_xadiem ";
        writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,table,"id_picture"));

	}

	private void getDatatoUploadBangHinhNTMForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"id_picture", "pathfile","tenanh","ten_xadiem"

        };
        
    String table = "  tbl_picture a inner join tbl_xadiem b on a.id_xadiem = b.id_xadiem ";
    writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,table,"id_picture"));

	}

	private void getDatatoUploadBangHinhDeTaiForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"id_picture", "pathfile","tendt","tenanh"

        };
        
    String table = "  tbl_picture_detai a inner join tbl_detai_duan b on a.id_detai = b.id_detai ";
    writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,table,"id_picture"));

	}

	private void getDatatoEditThuMucForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				" id_xadiem", "foldername", "id_detai", "type_media"
       };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_picture_folder"));

	}

	private void getDatatoThuMucForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"id_folder", "foldername","type_media"

        };
        writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,"tbl_picture_folder","id_folder"));

	}

	private void getFolderHinhAnhDeTai2Cbb(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgOperation dop = new DlgOperation();
    	String condition = request.getParameter("condition");
    	int type = Integer.parseInt(request.getParameter("type"));
    	String topsymbol = request.getParameter("topsymbol");
    	String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
    	String prefix_to_name =  request.getParameter("prefix_to_name");
    	String s = dop.getFolderHinhAnhDeTai2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
    	writeResponse.print(s);
	}

	private void getDatatoUploadHinhAnhDeTaiForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"id_picture", "pathfile","tendt"

        };
        String table = "  tbl_picture_detai a inner join tbl_detai_duan b on a.id_detai = b.id_detai ";
        writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,table,"id_picture"));

	}

	private void getDatatoEditGiaiPhapKHCNForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				" ten_giaiphap_khcn", "noidung_giaiphap_khcn", "id_thuyetminh_detai", 
				" quytrinh_thuc_hien", "file_giaiphap", "file_quytrinh", "tenfile_giaiphap", 
				" tenfile_quytrinh", "a.id_detai",  "a.id_tochuc", " tukhoa " , "masodt", "tendt", "tentc"
			     
       };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_giaiphap_khcn a inner join tbl_thuyetminh_detai_duan b on a.id_thuyetminh_detai = b.id_thuyetminh_detai_duan "
	    		+ " inner join tbl_detai_duan c on a.id_detai = c.id_detai "
	    		+ " inner join tbl_tochuc d on a.id_tochuc = d.id_tochuc"));

	}

	private void getDatatoGiaiPhapKHCNForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"id_giaiphap_khcn", "ten_giaiphap_khcn","noidung_giaiphap_khcn","quytrinh_thuc_hien"

        };
        writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,"tbl_giaiphap_khcn","ten_giaiphap_khcn"));

	}

	private void getDatatoEditCoCheChinhSachForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				"ten_coche_chinhsach", "noidung_coche_chinhsach", 
			       "maso_coche_chinhsach", "id_thuyetminh_detai", "filenoidung", "tenfile", 
			       "a.id_tochuc",  "a.id_detai", "tukhoa"  , "masodt", "tendt", "tentc"
			     
       };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_coche_chinhsach a inner join tbl_thuyetminh_detai_duan b on a.id_thuyetminh_detai = b.id_thuyetminh_detai_duan "
	    		+ " inner join tbl_detai_duan c on a.id_detai = c.id_detai "
	    		+ " inner join tbl_tochuc d on a.id_tochuc = d.id_tochuc "));

	}

	private void getDatatoCoCheChinhSachForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"id_coche_chinhsach", "ten_coche_chinhsach","noidung_coche_chinhsach","maso_coche_chinhsach"

        };
        writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,"tbl_coche_chinhsach","ten_coche_chinhsach"));

		
	}

	private void getDatatoEditTienDoGiaiNganForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				 "ngaygiaingan", "sotien"," ghichu", "id_detai",  
			     "id_thuyetminhdetai", "id_tochuc", "id_noidung"
			     
       };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_tiendo_giaingan"));

	}

	private void getDatatoTienDoGiaiNganForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"id_tiendogiaingan", "ngaygiaingan","a.ghichu","sotien","tendt","tentc"

        };
        writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,"tbl_tiendo_giaingan a inner join tbl_tochuc b on a.id_tochuc= b.id_tochuc "
        		+ " inner join tbl_detai_duan c on a.id_detai = c.id_detai","id_noidung"));

	}

	private void getNoiDungThuyetMinhNhom2Cbb(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	DlgOperation dop = new DlgOperation();
    	String condition = request.getParameter("condition");
    	int type = Integer.parseInt(request.getParameter("type"));
    	String topsymbol = request.getParameter("topsymbol");
    	String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
    	String prefix_to_name =  request.getParameter("prefix_to_name");
    	String s = dop.getNoiDungThuyetMinhNhom2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
    	writeResponse.print(s);
	}

	private void getDatatoEditNoiDungThuyetMinhConForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				 "ten_noidung", "id_thuyetminh_detai", /*"kq_phaidat",*/ "thoigian_batdau", 
			       "thoigian_ketthuc", "id_giaidoan", "phantram_hoanthanh","id_noidung_cha"/*, 
			        "dukien_kinhphi", "path", "phantram_prj"*/
			     
       };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_noidung_cv"));
	}

	private void getDatatoNoiDungThuyetMinhConForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"id_noidung","tentc", "ten_noidung", "thoigian_batdau","thoigian_ketthuc"

        };
        String table = " tbl_noidung_cv a inner join "
        		+ " tbl_tochuc b on a.id_tochuc = b.id_tochuc ";
        writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,table ,"tentc"));

	}

	private void getDatatoEditNoiDungThuyetMinhNhomForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				  "ten_noidung", "id_thuyetminh_detai", /*"kq_phaidat",*/ "thoigian_batdau", 
			       "thoigian_ketthuc", "id_tochuc", "id_giaidoan", "phantram_hoanthanh" 
			       /*"dukien_kinhphi", "path", "phantram_prj"*/
			     
       };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_noidung_cv"));

		
	}

	private void getDatatoNoiDungThuyetMinhNhomForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"id_noidung", "ten_noidung"

        };
        writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,"tbl_noidung_cv ","ten_noidung"));

	}

	private void getGiaiDoan2Cbb(DBOperation dbo, HttpServletRequest request,
			HttpServletResponse response, PrintWriter writeResponse) {
    	DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		writeResponse.print(dop.getGiaiDoan2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name));
		
	}

	private void getDETAIDeTaiToChuc2Cbb(DBOperation dbo,
    		HttpServletRequest request, HttpServletResponse response,
    		PrintWriter writeResponse) {
    	DlgOperation dop = new DlgOperation();
    	String condition = request.getParameter("condition");
    	int type = Integer.parseInt(request.getParameter("type"));
    	String topsymbol = request.getParameter("topsymbol");
    	String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
    	String prefix_to_name =  request.getParameter("prefix_to_name");
    	String s = dop.getDETAIDeTaiToChuc2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
    	writeResponse.print(s);
    }
    private void getTHUYETMINHDeTaiToChuc2Cbb(DBOperation dbo,
    		HttpServletRequest request, HttpServletResponse response,
    		PrintWriter writeResponse) {
    	DlgOperation dop = new DlgOperation();
    	String condition = request.getParameter("condition");
    	int type = Integer.parseInt(request.getParameter("type"));
    	String topsymbol = request.getParameter("topsymbol");
    	String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
    	String prefix_to_name =  request.getParameter("prefix_to_name");
    	String s = dop.getTHUYETMINHDeTaiToChuc2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
    	writeResponse.print(s);
    }
	private void getTOCHUCDeTaiToChuc2Cbb(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getTOCHUCDeTaiToChuc2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}

	private void getDatatoEditPhanVonHangMucForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				 "noidung_tieuchi", "a.id_detai", "a.id_tochuc", "id_thuyetminhdetai", 
				  "filenoidung ",
				  "tenfile" ,
				  "tukhoa" ,  "masodt", "tendt", "tentc"
			     
       };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_phanbovon_theohangmuc a inner join tbl_thuyetminh_detai_duan b on a.id_thuyetminhdetai = b.id_thuyetminh_detai_duan "
	    		+ " inner join tbl_detai_duan c on a.id_detai = c.id_detai "
	    		+ " inner join tbl_tochuc d on a.id_tochuc = d.id_tochuc"));

	}

	private void getDatatoPhanVonHangMucForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"tentc", "tenfile", "tukhoa","id_tieuchi"

        };
        String table = " tbl_phanbovon_theohangmuc a inner join "
        		+ " tbl_tochuc b on a.id_tochuc = b.id_tochuc ";
        writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,table ,"tentc"));

	}

	private void getDatatoEditTDCapKinhPhiForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				"sotien", "ghichu", "id_detai", "id_tochuc", "id_thuyetminhdetai", 
			       "ngaycap "
       };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_tiendo_capkinhphi"));

	}

	private void getDatatoTDCapKinhPhiForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"id_tiendo_capkinhphi", "sotien", "ghichu",  
        	      " ngaycap","tentc"
        };
        
        writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,"tbl_tiendo_capkinhphi a inner join tbl_tochuc b on a.id_tochuc= b.id_tochuc" ,"id_tiendo_capkinhphi"));

	}

	private void getDatatoEditKHCapKinhPhiForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				"sotien", "ghichu", "id_detai", "id_tochuc", "id_thuyetminhdetai", 
			       "ngaydukiencap "
       };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_kh_capkinhphi"));

	}

	private void getDatatoKHCapKinhPhiForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"id_kh_capkinhphi", "sotien", "ghichu",  
        		 "tentc",  " ngaydukiencap"
        };
        
        writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,"tbl_kh_capkinhphi a inner join tbl_tochuc b on a.id_tochuc= b.id_tochuc" ,null));

	}

	private void getPhanLoaiSanPham2Cbb(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		writeResponse.print(dop.getPhanLoaiSanPham2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name));

	}

	private void getDatatoEditSanPhamForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				"id_loaisp",  "tensanpham",  "chitieuchatluong",  "donvido", "ten_phanloai_sp"
				,"id_thuyetminh_detai", "masodt"
       };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, " tbl_sanpham a inner join tbl_phanloai_sp b on a.id_loaisp = b.id_phanloai_sp "
	    		+ " inner join tbl_thuyetminh_detai_duan c on a.id_thuyetminh_detai = c.id_thuyetminh_detai_duan"));

	}

	private void getDatatoSanPhamForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"id_sanpham ",
        	    "tensanpham", "chitieuchatluong", "donvido"
        };
        
        writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,"tbl_sanpham" ,"tensanpham"));

	}

	private void getDatatoEditPhanLoaiSanPhamForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				"id_phanloai_sp ", 
        		"ten_phanloai_sp", 
       };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_phanloai_sp"));
	}

	private void getDatatoPhanLoaiSanPhamForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"*"
        };
        
        writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,"tbl_phanloai_sp" ,"ten_phanloai_sp"));
	}

	private void getDatatoEditDeTaiToChucForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				"id_detai ", 
        		"id_tochuc", 
        		"id_thuyetminhdetai", 
        		"maso"
       };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_detai_tochuc"));
	}

	private void getDatatoDeTaiToChucForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"a.id_detai" ,  "a.id_tochuc",  "id_thuyetminhdetai",  "maso", " tentc", " masodt"
        };
        
        writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,"tbl_detai_tochuc a "
        		+ " inner join tbl_thuyetminh_detai_duan b on a.id_thuyetminhdetai = b.id_thuyetminh_detai_duan"
        		+ " inner join tbl_tochuc c on a.id_tochuc= c.id_tochuc" ,null));
	
	}

	private void getDatatoEditGiaiDoanForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				"tengiaidoan", 
				"noidung", 
				"id_thuyetminh_detai", 
				"tungay", 
			    "denngay"
       };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_giaidoan"));
	}

	private void getDatatoGiaiDoanForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"id_giaidoan", 
        		 "tengiaidoan",
        		 "masodt", 
        		 "tungay ", 
        		 "noidung ", 
        	     "denngay"
        };
        
        String table = " tbl_giaidoan a "
        		+ "	inner join tbl_thuyetminh_detai_duan c on a.id_thuyetminh_detai = c.id_thuyetminh_detai_duan ";
        
        writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,table ,"tengiaidoan"));
	
	}

	private void getPhanLoaiThanhVien2Cbb(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		writeResponse.print(dop.getPhanLoaiThanhVien2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name));

	}

	private void getKienNghi2Cbb(DBOperation dbo, HttpServletRequest request,
			HttpServletResponse response, PrintWriter writeResponse) {
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		writeResponse.print(dop.getKienNghi2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name));

	}

	private void getPhanLoaiPhieu2Cbb(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		writeResponse.print(dop.getPhanLoaiPhieu2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name));

	}

	private void getDatatoOutPhieuForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				" hoten" ,   "masodt" ,  " diemdanhgia_tonghop",  " tenkiennghi",  " giaithich_kiennghi", "ten_phanloai_phieu",  " vitri",   
				 "tenphieu",   "noidung_phieu"  
       };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_phieu a inner join tbl_chuyengia b on a.id_chuyengia = b.id_chuyengia "
	    		+ " inner join tbl_thuyetminh_detai_duan c on a.id_thuyetminh_detai = c.id_thuyetminh_detai_duan "
	    		+ " inner join tbl_kiennghi d on a.id_kiennghi = d.id_kiennghi "
	    		+ " inner join tbl_phanloai_phieu e on a.id_phanloaiphieu = e.id_phanloaiphieu"));
	}

	private void getDatatoEditPhieuForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				" id_chuyengia ", 
				" id_thuyetminh_detai ", 
				" diemdanhgia_tonghop", 
			    " id_kiennghi", 
			    " giaithich_kiennghi", 
			    " id_phanloaiphieu", 
			    " vitri", 
			    " tenphieu", 
			    " noidung_phieu"
       };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_phieu"));
	}

	private void getDatatoPhieuForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
         		 "id_phieu",
        	     "tenphieu",
        	     "masodt", 
        	     "hoten"
        };
        
        String table = " tbl_phieu a "
        		+ " inner join tbl_chuyengia b on a.id_chuyengia = b.id_chuyengia "
        		+ "	inner join tbl_thuyetminh_detai_duan c on a.id_thuyetminh_detai = c.id_thuyetminh_detai_duan ";
        
        writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,table ,"tenphieu"));
	
	}

	private void getPhanLoaiKq2Cbb(DBOperation dbo, HttpServletRequest request,
			HttpServletResponse response, PrintWriter writeResponse) {
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		writeResponse.print(dop.getPhanLoaiKq2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name));

	}

	private void getDatatoOutToChucThamGiaForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				"tendt" ,    "masodt" ,  "tentc",  "so_canbo_dh_thamgia" ,    "so_canbo_ts_thamgia" ,   "so_canbo_ths_thamgia" ,    "nha_xuong" ,   " trangthietbi" ,   
				"kinhnghiem_thanhtuu_khcn" , "ten_phanloai", "ten_vaitro  "
       };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_tochuc_thamgia a inner join  tbl_thuyetminh_detai_duan b on a.id_thuyetminhdetai = b.id_thuyetminh_detai_duan "
	    		+ " inner join tbl_detai_duan c on a.id_detai = c.id_detai "
	    		+ " inner join tbl_tochuc d on a.id_tochuc = d.id_tochuc"
	    		+ " inner join tbl_phanloai_kq e on e.id_phanloai = a.id_phanloaiketqua"
	    		+ " inner join tbl_vaitro f on f.id_vaitro = a.id_vaitro"));

	}

	private void getDatatoEditToChucThamGiaForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
		String[] values = new String[] {
				"id_detai ",
				"  id_tochuc ",
				"  so_canbo_dh_thamgia ",
				"  so_canbo_ts_thamgia ",
				"  so_canbo_ths_thamgia ",
				"  nha_xuong ",
				"  trangthietbi ",
				"  id_vaitro ",
				"  kinhnghiem_thanhtuu_khcn ",
				"  id_phanloaiketqua ",
				"  id_thuyetminhdetai "
       };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_tochuc_thamgia"));

	}
	
	private void getDatatoToChucThamGiaForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"id_tochuc_thamgia_detai ", 
        		"tentc ", 
        		"ten_vaitro ",
        		"so_canbo_dh_thamgia ",
        		"so_canbo_ts_thamgia ", 
        		"so_canbo_ths_thamgia ",
        		"masodt "
        };
        
        String table = "tbl_tochuc_thamgia a "
        		+ "	inner join tbl_tochuc b on a.id_tochuc = b.id_tochuc "
        		+ " inner join tbl_vaitro c on a.id_vaitro = c.id_vaitro "
        + " inner join tbl_thuyetminh_detai_duan d on a.id_thuyetminhdetai = d.id_thuyetminh_detai_duan ";
        
        writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,table ,"tentc"));
	
	}

	private void getDatatoOutBienBanKiemPhieuForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"masodt ",
        		 "sophieu_phatra ",
        		 " sophieu_thuve ",
        		  "sophieu_hople ",
        		  "sophieu_khonghople ",
        		  "diemtb ",
        		  "ngay ",
        		  "file_bienban ",
        		  "tenfile ",
        };
        String table = "tbl_bienban_kiemphieu a inner join tbl_thuyetminh_detai_duan b "
        		+ " on a.id_thuyetminh_detai = b.id_thuyetminh_detai_duan ";
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, table));

	}

	private void getDatatoEditBienBanKiemPhieuForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		 "sophieu_phatra ",
        		 " sophieu_thuve ",
        		  "sophieu_hople ",
        		  "sophieu_khonghople ",
        		  "diemtb ",
        		  "ngay ",
        		  "file_bienban ",
        		  "tenfile ",
        };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, "tbl_bienban_kiemphieu"));

	}

	private void getDatatoBienBanKiemPhieuForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"id_thuyetminh_detai",
        		"tenfile",
        		"diemtb ",
        		"ngay ",
        };
        writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,"tbl_bienban_kiemphieu","tenfile"));
	
	}

	private void getDatatoOutBienBanMoHoSoForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"tendt",
        		"qd_thanhlaphoidong ",
        		" ngay_ra_quyetdinh  ",
        		" diadiem  ",
        		" thoigian_mohoso  ",
        		" tongso_hoso " ,
        		" so_hoso_hople "  ,
        		" thoigian_kibienban ",  
        		" ngay_kibienban  ",
        		" duongdanhoso  ",
        		" thoigian_mohoso " ,
        };		
        		
        String table ="	tbl_bienban_mohoso a "
        		+ "	inner join tbl_detai_duan b on a.id_detai = b.id_detai ";
        
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, table));
	}

	
	private void getDatatoEditBienBanMoHoSoForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		TblBienbanMohosoEntity.BIENBAN_MOHOSO_ID_DETAI,
        		TblBienbanMohosoEntity.BIENBAN_MOHOSO_QUYETDINH,
        		TblBienbanMohosoEntity.BIENBAN_MOHOSO_NGAYRA_QUYETDINH,
        		TblBienbanMohosoEntity.BIENBAN_MOHOSO_DIADIEM,
        		TblBienbanMohosoEntity.BIENBAN_MOHOSO_THOIGIAN_MOHOSO,
        		TblBienbanMohosoEntity.BIENBAN_MOHOSO_TONGSO,
        		TblBienbanMohosoEntity.BIENBAN_MOHOSO_HOPLE,
        		TblBienbanMohosoEntity.BIENBAN_MOHOSO_THOIGIAN_KIBIENBAN,
        		TblBienbanMohosoEntity.BIENBAN_MOHOSO_NGAY_KIBIENBAN,
        		TblBienbanMohosoEntity.BIENBAN_MOHOSO_DUONGDAN_HOSO,
        		TblBienbanMohosoEntity.BIENBAN_MOHOSO_THOIGIAN_MOHOSO,
        };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, TblBienbanMohosoEntity.BIENBAN_MOHOSO_TBL));

	}

	private void getDatatoBienBanMoHoSoForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		TblBienbanMohosoEntity.BIENBAN_MOHOSO_ID_DETAI,
        		TblBienbanMohosoEntity.BIENBAN_MOHOSO_NGAYRA_QUYETDINH,
        		TblBienbanMohosoEntity.BIENBAN_MOHOSO_DIADIEM,
        		TblBienbanMohosoEntity.BIENBAN_MOHOSO_QUYETDINH,
        		TblBienbanMohosoEntity.BIENBAN_MOHOSO_THOIGIAN_MOHOSO,
        };
        writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,TblBienbanMohosoEntity.BIENBAN_MOHOSO_TBL,TblBienbanMohosoEntity.BIENBAN_MOHOSO_ID_DETAI));
	}

	private void getDatatoOutBienBanHopHoiDongForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"b.tentc", 
        		"c.hoten as ten_thuki", 
        		"d.hoten as ten_truongbankiemphieu" , 
        		"e.hoten as ten_thanhvienkiemphieu01", 
        		"f.hoten as ten_thanhvienkiemphieu02", 
        		"g.hoten as ten_chutich_hoidong",
        		"quyetdinh_thanhlap_hoidong", 
        		"ngay_ra_quyetdinh", 
        		"diadiem", 
        		"thoigian", 
        		"sothanhvien_hoidong_comat",
        		"tongso_thanhvien_hoidong", 
        		"noidunglamviec", 
        		"ketluan", 
        		"file_bienban", 
        		"tenfile", 
        		"a.id_detai", 
        		"h.tendt"
        };
        String table = " tbl_bienban_hophoidong a "
        		+ " inner join tbl_tochuc b on a.id_tochuc_trungtuyen = b.id_tochuc "
        		+ " inner join tbl_chuyengia c on a.id_thuki = c.id_chuyengia "
        		+ " inner join tbl_chuyengia d on a.id_truongbankiemphieu = d.id_chuyengia "
        		+ " inner join tbl_chuyengia e on a.id_thanhvienkiemphieu01 = e.id_chuyengia "
        		+ " inner join tbl_chuyengia f on a.id_thanhvienkiemphieu02 = f.id_chuyengia "
        		+ " inner join tbl_chuyengia g on a.id_chutich_hoidong = g.id_chuyengia "
        		+ " inner join tbl_detai_duan h on a.id_detai = h.id_detai";
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, table));
	}

	private void getChuyenGia2Cbb(DBOperation dbo, HttpServletRequest request,
			HttpServletResponse response, PrintWriter writeResponse) {
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		writeResponse.print(dop.getChuyenGia2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name));

	}

	private void getDatatoEditBienBanHopHoiDongForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		TblBienbanHophoidongEntity.BIENBAN_HOPHOIDONG_ID_DETAI,
        		TblBienbanHophoidongEntity.BIENBAN_HOPHOIDONG_QUYETDINH_THANHLAP_HOIDONG,
        		TblBienbanHophoidongEntity.BIENBAN_HOPHOIDONG_NGAY_RA_QUYETDINH,
        		TblBienbanHophoidongEntity.BIENBAN_HOPHOIDONG_DIADIEM,
        		TblBienbanHophoidongEntity.BIENBAN_HOPHOIDONG_THOIGIAN,
        		TblBienbanHophoidongEntity.BIENBAN_HOPHOIDONG_SOTHANHVIEN_HOIDONG,
        		TblBienbanHophoidongEntity.BIENBAN_HOPHOIDONG_TONGSO_THANHVIEN,
        		TblBienbanHophoidongEntity.BIENBAN_HOPHOIDONG_ID_THUKI,
        		TblBienbanHophoidongEntity.BIENBAN_HOPHOIDONG_NOIDUNG_LAMVIEC,
        		TblBienbanHophoidongEntity.BIENBAN_HOPHOIDONG_ID_TRUONGBAN_KIMEPHIEU,
        		TblBienbanHophoidongEntity.BIENBAN_HOPHOIDONG_ID_TRUONGBAN_KIMEPHIEU,
        		TblBienbanHophoidongEntity.BIENBAN_HOPHOIDONG_ID_TOCHUC_TRUNGTUYEN,
        		TblBienbanHophoidongEntity.BIENBAN_HOPHOIDONG_ID_CHUTICH_HOIDONG,
        		TblBienbanHophoidongEntity.BIENBAN_HOPHOIDONG_KETLUAN,
        		TblBienbanHophoidongEntity.BIENBAN_HOPHOIDONG_FILE_BIENBAN,
        		TblBienbanHophoidongEntity.BIENBAN_HOPHOIDONG_TENFILE,
        };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, TblBienbanHophoidongEntity.BIENBAN_HOPHOIDONG_TBL));

	}

	private void getDatatoBienBanHopHoiDongForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		TblBienbanHophoidongEntity.BIENBAN_HOPHOIDONG_ID_DETAI,
        		TblBienbanHophoidongEntity.BIENBAN_HOPHOIDONG_TENFILE,
        		TblBienbanHophoidongEntity.BIENBAN_HOPHOIDONG_QUYETDINH_THANHLAP_HOIDONG,
        		TblBienbanHophoidongEntity.BIENBAN_HOPHOIDONG_NGAY_RA_QUYETDINH,
        		TblBienbanHophoidongEntity.BIENBAN_HOPHOIDONG_DIADIEM,
        		TblBienbanHophoidongEntity.BIENBAN_HOPHOIDONG_THOIGIAN 
        };
        writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,TblBienbanHophoidongEntity.BIENBAN_HOPHOIDONG_TBL,TblBienbanHophoidongEntity.BIENBAN_HOPHOIDONG_ID_DETAI));
	}

	private void getVaiTro2Cbb(DBOperation dbo, HttpServletRequest request,
			HttpServletResponse response, PrintWriter writeResponse) {
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getVaiTro2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}

	private void getNhanSu2Cbb(DBOperation dbo, HttpServletRequest request,
			HttpServletResponse response, PrintWriter writeResponse) {
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getNhanSu2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}

	private void getDatatoEditNhanSuThamGiaForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		TblNhansuThamgiaEntity.NHANSU_THAMGIA_ID_THUYETMINH,
        		TblNhansuThamgiaEntity.NHANSU_THAMGIA_ID_VAITRO,
        		"a." + TblNhansuThamgiaEntity.NHANSU_THAMGIA_ID_NHANSU,
        		TblNhansuThamgiaEntity.NHANSU_THAMGIA_NOIDUNG, 
        		TblNhansuThamgiaEntity.NHANSU_THAMGIA_SOTHANG, 
        		"d." + TblTochucEntity.TOCHUC_ID 
        };
        String table = TblNhansuThamgiaEntity.NHANSU_THAMGIA_TBL +  " a " +
                       " inner join " + TblNhansuEntity.NHANSU_TBL + " b on a." + TblNhansuThamgiaEntity.NHANSU_THAMGIA_ID_NHANSU + "= b." + TblNhansuEntity.NHANSU_ID + 
                       " inner join " + TblTochucEntity.TOCHUC_TBL + " d on d." + TblTochucEntity.TOCHUC_ID + "= b." + TblNhansuEntity.NHANSU_ID_TOCHUC ;
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, table));
	}

	private void getDatatoNhanSuThamGiaForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		TblNhansuThamgiaEntity.NHANSU_THAMGIA_ID_NHANSU_DETAI,
        		TblNhansuEntity.NHANSU_HOTEN,
        		TblNhansuThamgiaEntity.NHANSU_THAMGIA_NOIDUNG, 
        		TblTochucEntity.TOCHUC_TEN
        };
        String table = TblNhansuThamgiaEntity.NHANSU_THAMGIA_TBL +  " a " +
                       " inner join " + TblNhansuEntity.NHANSU_TBL + " b on a." + TblNhansuThamgiaEntity.NHANSU_THAMGIA_ID_NHANSU + "= b." + TblNhansuEntity.NHANSU_ID + 
                       " inner join " + TblTochucEntity.TOCHUC_TBL + " d on d." + TblTochucEntity.TOCHUC_ID + "= b." + TblNhansuEntity.NHANSU_ID_TOCHUC ;
        writeResponse.print(dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,table,TblNhansuEntity.NHANSU_HOTEN));
    }

	private void getDatatoEditTieuChiUngDungForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgMain dlgMain = new DlgMain();
        String[] values = new String[] { 
        		TblTieuchiUngdungEntity.TIEUCHI_UNGDUNG_ID_TIEUCHI, 
        		TblTieuchiUngdungEntity.TIEUCHI_UNGDUNG_ID_THUYETMINH, 
        		TblTieuchiUngdungEntity.TIEUCHI_UNGDUNG_ID_XADIEM 
        };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, TblTieuchiUngdungEntity.TIEUCHI_UNGDUNG_TBL));
	}

	private void getXaDiem2Cbb(DBOperation dbo, HttpServletRequest request,
			HttpServletResponse response, PrintWriter writeResponse) {
    	DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		writeResponse.print(dop.getXaDiem2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name));
	}
    
    
    private void getThuyetMinh2Cbb(DBOperation dbo, HttpServletRequest request,
			HttpServletResponse response, PrintWriter writeResponse) {
    	DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getThuyetMinhDeTai2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}

	private void getDatatoTieuChiUngDungForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
        		"a." + TblTieuchiUngdungEntity.TIEUCHI_UNGDUNG_ID_TIEUCHI,
        		"a." + TblTieuchiUngdungEntity.TIEUCHI_UNGDUNG_ID_XADIEM, 
        		"a." + TblTieuchiUngdungEntity.TIEUCHI_UNGDUNG_ID_THUYETMINH, 
        		TblXadiemEntity.XADIEM_TEN, 
        		TblThuyetminhDetaiDuanEntity.THUYETMINH_DETAI_MASO, 
        		TblTieuchiXaydungNtmEntity.TIEUCHI_XD_NTM_TEN, 
        };
        String table =  TblTieuchiUngdungEntity.TIEUCHI_UNGDUNG_TBL  + " a "
        		+ " inner join " + TblXadiemEntity.XADIEM_TBL + " b on a." + TblTieuchiUngdungEntity.TIEUCHI_UNGDUNG_ID_XADIEM + " = b."+ TblXadiemEntity.XADIEM_ID 
        		+ " inner join " + TblThuyetminhDetaiDuanEntity.THUYETMINH_DETAI_TBL + " c on a." + TblTieuchiUngdungEntity.TIEUCHI_UNGDUNG_ID_THUYETMINH + " = c." + TblThuyetminhDetaiDuanEntity.THUYETMINH_DETAI_ID
        		+ " inner join " + TblTieuchiXaydungNtmEntity.TIEUCHI_XD_NTM_TBL + " d on a." + TblTieuchiUngdungEntity.TIEUCHI_UNGDUNG_ID_TIEUCHI + " = d." + TblTieuchiUngdungEntity.TIEUCHI_UNGDUNG_ID_TIEUCHI;
        String s = (String)dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values,table,TblTieuchiXaydungNtmEntity.TIEUCHI_XD_NTM_TEN);
        writeResponse.print(s);
	}

	private void getTieuChiCon2Cbb(DBOperation dbo, HttpServletRequest request,
			HttpServletResponse response, PrintWriter writeResponse) {
    	DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getTieuChiCon2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}
	
	
	private void getKhuVuc2Cbb(DBOperation dbo, HttpServletRequest request,
			HttpServletResponse response, PrintWriter writeResponse) {
    	DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getKhuVuc2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}

	private void getDatatoEditTieuChiNTMConForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	DlgMain dlgMain = new DlgMain();
         String[] values = new String[] { 
         		TblTieuchiXaydungNtmEntity.TIEUCHI_XD_NTM_ID_TIEUCHI_ID_CHA, 
         		TblTieuchiXaydungNtmEntity.TIEUCHI_XD_NTM_TEN, 
         		TblTieuchiXaydungNtmEntity.TIEUCHI_XD_NTM_NOIDUNG, 
         		TblTieuchiXaydungNtmEntity.TIEUCHI_XD_NTM_CHITIEU, 
         		TblTieuchiXaydungNtmEntity.TIEUCHI_XD_NTM_ID_KHUVUC 
         };
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"), values, TblTieuchiXaydungNtmEntity.TIEUCHI_XD_NTM_TBL));
	}

	private void getDatatoTieuChiNTMConForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] { 
        		TblTieuchiXaydungNtmEntity.TIEUCHI_XD_NTM_ID, 
        		TblTieuchiXaydungNtmEntity.TIEUCHI_XD_NTM_TEN, 
        		TblTieuchiXaydungNtmEntity.TIEUCHI_XD_NTM_NOIDUNG, 
        		TblTieuchiXaydungNtmEntity.TIEUCHI_XD_NTM_CHITIEU
        };
        
        String s = (String)dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values, TblTieuchiXaydungNtmEntity.TIEUCHI_XD_NTM_TBL,TblTieuchiXaydungNtmEntity.TIEUCHI_XD_NTM_TEN);
        writeResponse.print(s);
	}

	private void getTieuChiNTMCha2Cbb(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getTieuChiNTMCha2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}

	private void getDatatoEditTieuChiNTMChaForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	DlgMain dlgMain = new DlgMain();
           String[] values = new String[] { 
           		TblTieuchiXaydungNtmEntity.TIEUCHI_XD_NTM_ID, 
           		TblTieuchiXaydungNtmEntity.TIEUCHI_XD_NTM_TEN 
           };
  	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"),values, TblTieuchiXaydungNtmEntity.TIEUCHI_XD_NTM_TBL));
	}

	private void getDatatoTieuChiNTMChaForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] { 
        		TblTieuchiXaydungNtmEntity.TIEUCHI_XD_NTM_ID, 
        		TblTieuchiXaydungNtmEntity.TIEUCHI_XD_NTM_TEN 
        };
        
        String s = (String)dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values, TblTieuchiXaydungNtmEntity.TIEUCHI_XD_NTM_TBL,TblTieuchiXaydungNtmEntity.TIEUCHI_XD_NTM_TEN);
        writeResponse.print(s);
	}

	private void getDatatoEditThuyetMinhDeTaiForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	DlgMain dlgMain = new DlgMain();
        String[] values = new String[] { 
        		 "a.id_detai",  "id_thuyetminh_detai_duan",  "masodt",  "muctieu_detai",  "ngaybatdau",  "tinhtrangdt" ,"tendt" 
        		};
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"),values, " tbl_thuyetminh_detai_duan a inner join tbl_detai_duan b on a.id_detai = b.id_detai"));
	}

	private void getDatatoThuyetMinhDeTaiForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] { 
        		TblThuyetminhDetaiDuanEntity.THUYETMINH_DETAI_ID, 
        		TblThuyetminhDetaiDuanEntity.THUYETMINH_DETAI_MASO, 
        		TblThuyetminhDetaiDuanEntity.THUYETMINH_DETAI_MUCTIEU, 
        		TblThuyetminhDetaiDuanEntity.THUYETMINH_DETAI_NGAY_BATDAU, 
        		TblThuyetminhDetaiDuanEntity.THUYETMINH_DETAI_TINHTRANG 
        };
        String s = (String)dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values, TblThuyetminhDetaiDuanEntity.THUYETMINH_DETAI_TBL,TblThuyetminhDetaiDuanEntity.THUYETMINH_DETAI_MASO);
        writeResponse.print(s);
	}

	private void getDeTaiDuAn2Cbb(DBOperation dbo, HttpServletRequest request,
			HttpServletResponse response, PrintWriter writeResponse) {
    	DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getDeTaiDuAn2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}

	private void getDatatoEditDeTaiDuAnForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	DlgMain dlgMain = new DlgMain();
          String[] values = new String[] { 
          		"id_detai",  
          		"tendt",  
          		"linhvuckh", 
          		"tgthuchien",  
          		"kinhphi",  
          		"id_phannhom_detai_duan",  
          		"tinhtrang",  
          		"ngaythuchien ", 
          		"ten_phannhom_detai"
          		
          		};
	    writeResponse.print(dlgMain.getDatatoEdit_Form(dbo, request.getParameter("condition"),values," tbl_detai_duan a inner join tbl_phanloai_detai_duan b on a.id_phannhom_detai_duan = b.id_phannhom_detai"));
	}

	private void getDatatoDeTaiDuAnForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] { 
        		TblDetaiDuanEntity.DETAI_DUAN_ID, 
        		TblDetaiDuanEntity.DETAI_DUAN_TEN,
        		TblDetaiDuanEntity.DETAI_DUAN_LINHVUC_KH,
        		TblDetaiDuanEntity.DETAI_DUAN_TG_THUCHIEN,
        		TblDetaiDuanEntity.DETAI_DUAN_KINHPHI,
        		TblDetaiDuanEntity.DETAI_DUAN_ID_PHANNHOM };
        String s = (String)dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values, TblDetaiDuanEntity.DETAI_DUAN_TBL,TblDetaiDuanEntity.DETAI_DUAN_TEN);
        writeResponse.print(s);
	}

	private void getNhomDeTaiDuAn2Cbb(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getNhomDeTaiDuAn2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}

	private void getDatatoEditPhanLoaiKhuVucForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	DlgPhanLoaiKhuVuc dlgPhanLoaiKhuVuc = new DlgPhanLoaiKhuVuc();
	    writeResponse.print(dlgPhanLoaiKhuVuc.getDatatoEditPhanLoaiKhuVucForm(dbo, request.getParameter("condition")));
		
	}

	private void getDatatoPhanLoaiKhuVucForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgPhanLoaiKhuVuc dlgPhanLoaiKhuVuc = new DlgPhanLoaiKhuVuc();
        String s = (String)dlgPhanLoaiKhuVuc.getDatatoPhanLoaiKhuVucForm(dbo, total, records, limit, offset, condition, true);
        writeResponse.print(s);
	}

	private void getDatatoEditPhanLoaiKqForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	DlgPhanLoaiKq dlgPhanLoaiKq = new DlgPhanLoaiKq();
	    writeResponse.print(dlgPhanLoaiKq.getDatatoEditPhanLoaiKqForm(dbo, request.getParameter("condition")));
		
	}

	private void getDatatoPhanLoaiKqForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgPhanLoaiKq dlgPhanLoaiKq = new DlgPhanLoaiKq();
        String s = (String)dlgPhanLoaiKq.getDatatoPhanLoaiKqForm(dbo, total, records, limit, offset, condition, true);
//        System.err.println("Json response: " + s );
        writeResponse.print(s);
		
	}

	private void getDatatoEditVaiTroForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	DlgVaiTro dlgVaiTro = new DlgVaiTro();
	    writeResponse.print(dlgVaiTro.getDatatoEditVaiTroForm(dbo, request.getParameter("condition")));
		
	}

	private void getDatatoVaiTroForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgVaiTro dlgVaiTro = new DlgVaiTro();
        String s = (String)dlgVaiTro.getDatatoVaiTroForm(dbo, total, records, limit, offset, condition, true);
//        System.err.println("Json response: " + s );
        writeResponse.print(s);
		
	}

	private void getDatatoEditPhanLoaiBaoCaoForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	DlgPhanLoaiBaoCao dlgbaoBaoCao = new DlgPhanLoaiBaoCao();
	    writeResponse.print(dlgbaoBaoCao.getDatatoEditPhanLoaiBaoCaoForm(dbo, request.getParameter("condition")));
		
	}

	private void getDatatoPhanLoaiBaoCaoForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgPhanLoaiBaoCao dlgbaoBaoCao = new DlgPhanLoaiBaoCao();
        String s = (String)dlgbaoBaoCao.getDatatoPhanLoaiBaoCaoForm(dbo, total, records, limit, offset, condition, true);
        System.err.println("Json response: " + s );
        writeResponse.print(s);
		
	}

	private void getDatatoEditPhanLoaiDetaiDuanForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgPhanLoaiDetaiDuan dlgPhanLoaiDeTaiDuAn = new DlgPhanLoaiDetaiDuan();
	    writeResponse.print(dlgPhanLoaiDeTaiDuAn.getDatatoEditPhanLoaiDetaiDuanForm(dbo, request.getParameter("condition")));
		
	}

	private void getDatatoPhanLoaiDetaiDuanForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgPhanLoaiDetaiDuan dlgPhanLoaiDeTaiDuAn = new DlgPhanLoaiDetaiDuan();
        String s = (String)dlgPhanLoaiDeTaiDuAn.getDatatoPhanLoaiDetaiDuanForm(dbo, total, records, limit, offset, condition, true);
//        System.err.println("Json response: " + s );
        writeResponse.print(s);
		
		
	}

	private void getDatatoEditPhanLoaiPhieuForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	DlgPhanLoaiPhieu dlgPhanloaiPhieu = new DlgPhanLoaiPhieu();
	    writeResponse.print(dlgPhanloaiPhieu.getDatatoEditPhanLoaiPhieuForm(dbo, request.getParameter("condition")));
		
	}

	private void getDatatoPhanLoaiPhieuForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgPhanLoaiPhieu dlgPhanloaiPhieu = new DlgPhanLoaiPhieu();
        String s = (String)dlgPhanloaiPhieu.getDatatoPhanLoaiPhieuForm(dbo, total, records, limit, offset, condition, true);
        writeResponse.print(s);
	}

	private void getDatatoEditKienNghiForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	DlgKienNghi dlgKienNghi = new DlgKienNghi();
	    writeResponse.print(dlgKienNghi.getDatatoEditKienNghiForm(dbo, request.getParameter("condition")));
	}

	private void getDatatoKienNghiForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgKienNghi dlgKienNghi = new DlgKienNghi();
        String s = (String)dlgKienNghi.getDatatoKienNghiForm(dbo, total, records, limit, offset, condition, true);
//        System.err.println("Json response: " + s );
        writeResponse.print(s);
	}

	private void getDatatoEditChuyenGiaForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	DlgChuyenGia dlgChuyenGia = new DlgChuyenGia();
	    writeResponse.print(dlgChuyenGia.getDatatoEditChuyenGiaForm(dbo, request.getParameter("condition")));
	}

	private void getDatatoChuyenGiaForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgMain dlgMain = new DlgMain();
        String[] values = new String[] {
	         TblChuyengiaEntity.CHUYENGIA_ID ,
	         TblChuyengiaEntity.CHUYENGIA_CHUCVU ,
	         TblChuyengiaEntity.CHUYENGIA_DIENTHOAI ,
	         TblChuyengiaEntity.CHUYENGIA_DONVI_CONGTAC ,
	         TblChuyengiaEntity.CHUYENGIA_HOTEN 
        };
        String s = (String)dlgMain.getRetrieveDataFromDatabase_Form(dbo, total, records, limit, offset, condition, true, values, TblChuyengiaEntity.CHUYENGIA_TBL, TblChuyengiaEntity.CHUYENGIA_HOTEN);
        writeResponse.print(s);
	}

	private void getDatatoEdit_NhanSuForm(DBOperation dbo,
			HttpServletRequest request, PrintWriter writeResponse) {
		DlgNhanSu dlgNhanSu = new DlgNhanSu();
        writeResponse.print(dlgNhanSu.getDatato_EditNhanSuForm(dbo, request.getParameter("condition")));
	}
	
	private void getDatato_NhanSuForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgNhanSu dlgNhanSu = new DlgNhanSu();
        String s = (String)dlgNhanSu.getDatato_NhanSuForm(dbo, total, records, limit, offset, condition, true);
//        System.err.println("Json response: " + s );
        writeResponse.print(s);
	}

	private void getToChuc2Cbb(DBOperation dbo, HttpServletRequest request,
			PrintWriter writeResponse) {
		DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getToChuc2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}
	
	private void getDatatoEdit_ToChucForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		DlgToChuc dlgToChuc = new DlgToChuc();
        writeResponse.print(dlgToChuc.getDatatoEdit_ToChucForm(dbo, request.getParameter("condition")));
	}

	private void getDatato_ToChucForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgToChuc dlgToChuc = new DlgToChuc();
        String s = (String)dlgToChuc.getDatato_ToChucForm(dbo, total, records, limit, offset, condition, true);
//        System.err.println("Json response: " + s );
        writeResponse.print(s);
	}

	private void getDatatoEdit_PhanLoaiThanhVienForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	DlgPhanLoaiThanhVien dlgPhanLoaiThanhVien = new DlgPhanLoaiThanhVien();
        writeResponse.print(dlgPhanLoaiThanhVien.getDatatoEditPhanLoaiThanhVienForm(dbo, request.getParameter("condition")));
	}

	private void getDatato_PhanLoaiThanhVienForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	 int  total = Integer.parseInt(request.getParameter("total"));
         int  records = Integer.parseInt(request.getParameter("records"));
         int  page = Integer.parseInt(request.getParameter("page"));
         int  rows = Integer.parseInt(request.getParameter("rows"));

         String  condition = request.getParameter("condition");
         int limit = rows;
         int offset = (page - 1)*rows;

         DlgPhanLoaiThanhVien dlgPhanLoaiThanhVien = new DlgPhanLoaiThanhVien();
         String s = (String)dlgPhanLoaiThanhVien.getDatatoPhanLoaiThanhVienForm(dbo, total, records, limit, offset, condition, true);
//         System.err.println("Json response: " + s );
         writeResponse.print(s);
	}
	
	 private void getDatatoEdit_TinTucHoatDongForm(DBOperation dbo,
				HttpServletRequest request, HttpServletResponse response,
				PrintWriter writeResponse) {
		 DlgTinTucHoatDong dlgTinTucHoatDong = new DlgTinTucHoatDong();
	     writeResponse.print(dlgTinTucHoatDong.getDatatoEdit_TinTucHoatDongForm(dbo, request.getParameter("condition"),true));
	}

	private void getDatato_TinTucHoatDongForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	 int  total = Integer.parseInt(request.getParameter("total"));
         int  records = Integer.parseInt(request.getParameter("records"));
         int  page = Integer.parseInt(request.getParameter("page"));
         int  rows = Integer.parseInt(request.getParameter("rows"));

         String  condition = request.getParameter("condition");
         int limit = rows;
         int offset = (page - 1)*rows;

         DlgTinTucHoatDong dlgTinTucHoatDong = new DlgTinTucHoatDong();
         String s = (String)dlgTinTucHoatDong.getDatato_TinTucHoatDongForm(dbo, total, records, limit, offset, condition, true);
         writeResponse.print(s);
	}

	private void getTinTucPhanLoai2Cbb(DBOperation dbo,	HttpServletRequest request, PrintWriter writeResponse) {
    	DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getTinTucPhanLoai2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}

	private void getDatatoEdit_PhanLoaiTinTucHoatDongForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	  DlgPhanLoaiTinTuc dlgPhanLoaiTinTuc = new DlgPhanLoaiTinTuc();
	      writeResponse.print(dlgPhanLoaiTinTuc.getDatatoEditDs_PhanLoaiTinTucForm(dbo, request.getParameter("condition")));
	}

	private void getDatato_PhanLoaiTinTucHoatDongForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
		  int  total = Integer.parseInt(request.getParameter("total"));
          int  records = Integer.parseInt(request.getParameter("records"));
          int  page = Integer.parseInt(request.getParameter("page"));
          int  rows = Integer.parseInt(request.getParameter("rows"));

          String  condition = request.getParameter("condition");
          int limit = rows;
          int offset = (page - 1)*rows;

          DlgPhanLoaiTinTuc dlgPhanLoaiTinTuc = new DlgPhanLoaiTinTuc();
          String s = (String)dlgPhanLoaiTinTuc.getDatatoDs_PhanLoaiTinTucForm(dbo, total, records, limit, offset, condition, true);
//          System.err.println("Json response: " + s );
          writeResponse.print(s);
	}

	private void getDatatoEditDs_YKienChiDaoForm(DBOperation dbo,
			HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	DlgYKienChiDao dlgYKienChiDao = new DlgYKienChiDao();
        writeResponse.print(dlgYKienChiDao.getDatatoEditDs_YKienChiDaoForm(dbo, request.getParameter("condition"),true));
	}

	private void getDatatoDs_YKienChiDaoForm(DBOperation dbo,HttpServletRequest request, HttpServletResponse response,
			PrintWriter writeResponse) {
    	 int  total = Integer.parseInt(request.getParameter("total"));
         int  records = Integer.parseInt(request.getParameter("records"));
         int  page = Integer.parseInt(request.getParameter("page"));
         int  rows = Integer.parseInt(request.getParameter("rows"));

         String  condition = request.getParameter("condition");
         int limit = rows;
         int offset = (page - 1)*rows;

         DlgYKienChiDao dlgYKienChiDao = new DlgYKienChiDao();
         String s = (String)dlgYKienChiDao.getDatatoDs_YKienChiDaoForm(dbo, total, records, limit, offset, condition, true);
         writeResponse.print(s);
	}

	private void getVanBanPhanLoai2Cbb(DBOperation dbo,HttpServletRequest request, PrintWriter writeResponse) {
    	DlgOperation dop = new DlgOperation();
		String condition = request.getParameter("condition");
		int type = Integer.parseInt(request.getParameter("type"));
		String topsymbol = request.getParameter("topsymbol");
		String prefix_to_id = request.getParameter("prefix_to_id"); //chèn thêm prefix_to_id vào trước id value
		String prefix_to_name =  request.getParameter("prefix_to_name");
		String s = dop.getVanBanPhanLoai2Cbb(dbo, condition, type, topsymbol,prefix_to_id,prefix_to_name);
		writeResponse.print(s);
	}

	public void getListQuyen2ComboHtml(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
		DlgQuyen dlgquyen = new DlgQuyen();
		String s = (String)dlgquyen.getListQuyen2ComboHtml(dbo, null, true);
		writeResponse.print(s);
	}
    
    public void getDatatoDanhSachPhanQuyenForm(DBOperation dbo, HttpServletRequest request, HttpServletResponse response, PrintWriter writeResponse){
//      System.out.println("page=" + request.getParameter("page"));
//      System.out.println("rows=" + request.getParameter("rows"));
//      System.out.println("total=" + request.getParameter("total"));
//      System.out.println("records=" + request.getParameter("records"));

      int  total = Integer.parseInt(request.getParameter("total"));
      int  records = Integer.parseInt(request.getParameter("records"));
      int  page = Integer.parseInt(request.getParameter("page"));
      int  rows = Integer.parseInt(request.getParameter("rows"));

      String  condition = request.getParameter("condition");
      int limit = rows;
      int offset = (page - 1)*rows;

      DlgQuyen dlgquyen = new DlgQuyen();
      String s = (String)dlgquyen.getDatatoDanhSachPhanQuyenForm(dbo, total, records, limit, offset, condition, true);
//      System.err.println("Json response: " + s );
      writeResponse.print(s);
    }
    
    public void getDatatoEditDanhSachPhanQuyenForm (DBOperation dbo, HttpServletRequest request, HttpServletResponse response, PrintWriter writeResponse){
        DlgQuyen dlgquyen = new DlgQuyen();
        writeResponse.print(dlgquyen.getDatatoEditDanhSachPhanQuyenForm(dbo,request.getParameter("condition")));
    }

    public void getDatatoDanhSachTaiKhoanForm(DBOperation dbo, HttpServletRequest request, HttpServletResponse response, PrintWriter writeResponse){
      int  total = Integer.parseInt(request.getParameter("total"));
      int  records = Integer.parseInt(request.getParameter("records"));
      int  page = Integer.parseInt(request.getParameter("page"));
      int  rows = Integer.parseInt(request.getParameter("rows"));

      String  condition = request.getParameter("condition");
      int limit = rows;
      int offset = (page - 1)*rows;

      DlgTaiKhoan dlgtaikhoan = new DlgTaiKhoan();
      String s = (String)dlgtaikhoan.getDatatoDanhSachTaiKhoanForm(dbo, total, records, limit, offset, condition, true);
//      System.err.println("Json response: " + s );
      writeResponse.print(s);
    }  
    
    public void getDatatoEditDanhSachTaiKhoanForm (DBOperation dbo, HttpServletRequest request, HttpServletResponse response, PrintWriter writeResponse){
        DlgTaiKhoan dlgtaikhoan = new DlgTaiKhoan();
        writeResponse.print(dlgtaikhoan.getDatatoEditDanhSachTaiKhoanForm(dbo,request.getParameter("condition")));
    }
  
    
    public void checkDataExists(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
        DlgOperation dop = new DlgOperation();
        writeResponse.print(dop.checkDataExists(dbo,request,writeResponse));
    }

    public void checkMAX(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
        DlgOperation dop = new DlgOperation();
        writeResponse.print(dop.checkMAX(dbo,request,writeResponse));

    }

    public void getDatatoDs_PhanLoaiVanBanForm(DBOperation dbo, HttpServletRequest request, HttpServletResponse response, PrintWriter writeResponse){
        int  total = Integer.parseInt(request.getParameter("total"));
        int  records = Integer.parseInt(request.getParameter("records"));
        int  page = Integer.parseInt(request.getParameter("page"));
        int  rows = Integer.parseInt(request.getParameter("rows"));

        String  condition = request.getParameter("condition");
        int limit = rows;
        int offset = (page - 1)*rows;

        DlgPhanLoaiVanBan dlgPhanLoaiVanBan = new DlgPhanLoaiVanBan();
        String s = (String)dlgPhanLoaiVanBan.getDatatoDs_PhanLoaiVanBanForm(dbo, total, records, limit, offset, condition, true);
//        System.err.println("Json response: " + s );
        writeResponse.print(s);
    }

    public void getDatatoEditDs_PhanLoaiVanBanForm (DBOperation dbo, HttpServletRequest request, HttpServletResponse response, PrintWriter writeResponse){
        DlgPhanLoaiVanBan dlgPhanLoaiVanBan = new DlgPhanLoaiVanBan();
        writeResponse.print(dlgPhanLoaiVanBan.getDatatoEditDs_PhanLoaiVanBanForm(dbo, request.getParameter("condition")));
    }

    public void getDatatoDs_VanBanPhapLyForm(DBOperation dbo, HttpServletRequest request, HttpServletResponse response, PrintWriter writeResponse){
      int  total = Integer.parseInt(request.getParameter("total"));
      int  records = Integer.parseInt(request.getParameter("records"));
      int  page = Integer.parseInt(request.getParameter("page"));
      int  rows = Integer.parseInt(request.getParameter("rows"));

      String  condition = request.getParameter("condition");
      int limit = rows;
      int offset = (page - 1)*rows;

      DlgVanBanPhapLy dlgVanBanPhapLy = new DlgVanBanPhapLy();
      String s = (String)dlgVanBanPhapLy.getDatatoDs_VanBanPhapLyForm(dbo, total, records, limit, offset, condition, true);
      //System.err.println("Json response: " + s );
      writeResponse.print(s);
    }
    
    public void getDatatoEditDs_VanBanPhapLyForm (DBOperation dbo, HttpServletRequest request, HttpServletResponse response, PrintWriter writeResponse){
        DlgVanBanPhapLy dlgVanBanPhapLy = new DlgVanBanPhapLy();
        writeResponse.print(dlgVanBanPhapLy.getDatatoEditDs_VanBanPhapLyForm(dbo, request.getParameter("condition"),true));
    }
    
    public void  execInsertUpdatedMultiRecords2DBByClient(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse) {
        // System.out.println("execInsertUpdatedMultiRecords2DBByClient...");
		try {
			String ret = dbo.execInsertUpdatedMultiRecords2DBByClient(
					/*single/multiple SQL query */request.getParameter("sqlquery")
			        ,/*condition */request.getParameter("condition")
			        ,/*values */request.getParameter("values")
			        ,/*sql type order in query */request.getParameter("sqlTypeOrder")
			        ,/*ids */request.getParameter("ids")
			);
			writeResponse.print(ret);
		} catch (ParseException e) {
			 System.out.println( "execInsertUpdatedMultiRecords2DBByClient ParseException: " + e.toString());
		}
    }

    public void deleteRecord(DBOperation dbo, HttpServletRequest request, PrintWriter writeResponse){
        String condition = request.getParameter("condition");
        /*System.out.println("Delete Record: " + condition);*/
        String tableName = request.getParameter("tableName");
        DlgOperation dop = new DlgOperation();
        JResult jro = dop.deleteObject(dbo, tableName, condition);
        writeResponse.print(jro.toString());
    }
    
    public int execUpdateDataGrid(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
    	String tablename = request.getParameter("tablename");
    			
    	String insertFields = request.getParameter("insertFields");		
    	String insertValues = request.getParameter("insertValues");
    	
    	String updateFields = request.getParameter("updateFields");
    	String updateValues = request.getParameter("updateValues");
    	String returnid = request.getParameter("returnid");
    	System.out.println("insertFields =" + insertFields);
    	System.out.println("insertValues =" + insertValues);
    	System.out.println("updateFields = " +updateFields);
    	System.out.println("updateValues =" + updateValues);
    	System.out.println("tablename =" + tablename);
    	System.out.println("returnid =" + returnid);

    	writeResponse.print(dbo.execUpdateDataGrid(tablename,insertFields,insertValues,updateFields,updateValues,returnid));
    	return Definitions.DB_INT_OK;
    }
    
    public void getData2EditUser(DBOperation dbo, HttpServletRequest request,PrintWriter writeResponse){
    	System.out.println("page=" + request.getParameter("page"));
    	System.out.println("rows=" + request.getParameter("rows"));
    	System.out.println("total=" + request.getParameter("total"));
    	System.out.println("records=" + request.getParameter("records"));
    	//if ("null".equalsIgnoreCase(request.getParameter("records"))) total = -1;
    	
    	int  total = -1;//Integer.parseInt(request.getParameter("total"));
    	int  records = -1;//Integer.parseInt(request.getParameter("records"));
    	int  page = Integer.parseInt(request.getParameter("page"));
    	int  rows = Integer.parseInt(request.getParameter("rows"));
    	
    	String  condition = request.getParameter("condition"); 
    	int limit = rows;
    	int offset = (page - 1)*rows;
    	DlgTaiKhoan dlgTaiKhoan = new DlgTaiKhoan();
    	String s = (String)dlgTaiKhoan.getDatatoDanhSachTaiKhoanForm(dbo, total, records, limit, offset, condition, true);
    	//System.err.println(s);
    	writeResponse.print(s);
    }
}
