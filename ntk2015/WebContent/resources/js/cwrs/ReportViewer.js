cwrs_report_viewer = function(uri, htmlData) {
  
  //Get the HTML Elements
  imageDialog = $("#dlg_report_viewer");
  imageTag    = $('#dlg_report_viewer_image');
  
  if (uro != null){
  //Split the URI so we can get the file name
  uriParts = uri.split("/");
  //Set the image src
  imageTag.attr('src', uri);
  } else
  $('#dlg_report_viewer_html').html = htmlData;
  //When the image has loaded, display the dialog
  imageTag.load(function(){
    
    $('#dlg_report_viewer').dialog({
      modal: false,
      resizable: true,
      draggable: true,
      width: 'auto',
      title: uriParts[uriParts.length - 1],
	  buttons: {
			"Báo cáo dạng văn bản": function() {
				deleteRow_DlgShowThongtinThitruong();
			},
			"Báo cáo dạng biểu đồ": function() {
				show_dlg_add_thongtinthitruong(/*isEdit*/true);

			},
			"Lưu": function() {

				show_dlg_add_thongtinthitruong(false);

			},
			"Đóng": function() {
				$( this ).dialog( "close" );
				
			}
	  }
    });
    
  }); 
}