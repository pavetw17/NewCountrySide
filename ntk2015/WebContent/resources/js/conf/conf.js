var mapserver_addr = //'192.168.1.250:8084' ;
					'113.160.58.90:568'; 
/*["http://labs.metacarta.com/wms-c/Basic.py",
 "http://monitor.metacarta.com/wms-c/Basic.py"];*/
var mapserver_folder_conf= 'dbscl';

var mapserver_addr1 = 'http://' + 'luadbscl.vn:568' + '/cgi-bin/mapserv.exe?map=/ms4w/apps/dbscl/htdocs/vn.map';
var mapserver_addr2 = 'http://' + '210.245.89.35:568'        + '/cgi-bin/mapserv.exe?map=/ms4w/apps/dbscl/htdocs/vn.map';
var mapserver_addr3 = 'http://' + 'r1.phanmemthuyloi.vn:568'        + '/cgi-bin/mapserv.exe?map=/ms4w/apps/dbscl/htdocs/vn.map';
var mapserver_addr4 = 'http://' + 'bvtv.phanmemthuyloi.vn:569'        + '/cgi-bin/mapserv.exe?map=/ms4w/apps/dbscl/htdocs/vn.map';
var mapserver_addr5 = 'http://' + 'r2.phanmemthuyloi.vn:568'        + '/cgi-bin/mapserv.exe?map=/ms4w/apps/dbscl/htdocs/vn.map';
var mapserver_addr6 = 'http://' + '?'        + '/cgi-bin/mapserv.exe?map=/ms4w/apps/dbscl/htdocs/vn.map';
var mapserver_addr7 = 'http://' + 'r3.phanmemthuyloi.vn:568'        + '/cgi-bin/mapserv.exe?map=/ms4w/apps/dbscl/htdocs/vn.map';
var mapserver_addr8 = 'http://' + mapserver_addr        + '/cgi-bin/mapserv.exe?map=/ms4w/apps/dbscl/htdocs/vn.map';

var mapserver_addr_map_file = [
                    //   mapserver_addr1
                               //,mapserver_addr2
                    //         ,mapserver_addr3
                               //,mapserver_addr4
                               //,mapserver_addr5
                               
                               //,mapserver_addr7
                     mapserver_addr8
                               ];
var mapserver_url_draw_hientrang = 'http://' + mapserver_addr + '/cgi-bin/mapserv.exe?map=/ms4w/apps/dbscl/htdocs/'+ '<o>'+'&TRANSPARENT=true&FORMAT=image%2Fpng&ISBASELAYER=false&SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&STYLES=&EXCEPTIONS=application%2Fvnd.ogc.se_inimage&SRS=EPSG%3A4756&';
var mapserver_url_draw_vientham = 'http://' + mapserver_addr + '/cgi-bin/mapserv.exe?map=/ms4w/apps/dbscl/htdocs/'+ 'vientham.map'+'&TRANSPARENT=true&FORMAT=image%2Fpng&ISBASELAYER=false&SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&STYLES=&EXCEPTIONS=application%2Fvnd.ogc.se_inimage&SRS=EPSG%3A4756&';

var webname = 'dbscl';