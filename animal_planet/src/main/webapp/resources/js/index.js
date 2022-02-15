let container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
let options = { //지도를 생성할 때 필요한 기본 옵션
	center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
	level: 3 //지도의 레벨(확대, 축소 정도)
};

let map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
let zoomControl = new kakao.maps.ZoomControl();
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

if (navigator.geolocation) {
    
    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
    navigator.geolocation.getCurrentPosition(function(position) {
        
        let lat = position.coords.latitude, // 위도
            lon = position.coords.longitude; // 경도
            console.log(`lat : ${lat}`);
            console.log(`lon : ${lon}`);
        
        let locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
            message = '<div style="padding:5px;">여기에 계신가요?!</div>'; // 인포윈도우에 표시될 내용입니다
        
        // 마커와 인포윈도우를 표시합니다
        displayMarker(locPosition, message);
            
      });
    } else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
    
        var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
            message = 'geolocation을 사용할수 없어요..'
            
        displayMarker(locPosition, message);
}

function displayMarker(locPosition, message) {

    // 마커를 생성합니다
    let marker = new kakao.maps.Marker({  
        map: map, 
        position: locPosition
    }); 
    
    let iwContent = message, // 인포윈도우에 표시할 내용
        iwRemoveable = true;

    // 인포윈도우를 생성합니다
    let infowindow = new kakao.maps.InfoWindow({
        content : iwContent,
        removable : iwRemoveable
    });
    
    // 인포윈도우를 마커위에 표시합니다 
    infowindow.open(map, marker);
    
    // 지도 중심좌표를 접속위치로 변경합니다
    map.setCenter(locPosition);      
}   

let geocoder = new kakao.maps.services.Geocoder();
let tmX = 196801.359624316;
let tmY = 445056.759115545;

let callback = function(result, status) {
    if (status === kakao.maps.services.Status.OK) {
        console.log(result[0].y);
        console.log(result[0].x); //경도
        let markpo = new kakao.maps.LatLng(result[0].y, result[0].x);
        let mark = new kakao.maps.Marker({
            map: map,
            position: markpo
        });
        
    }
};

// WTM 좌표를 WGS84 좌표계의 좌표로 변환한다
geocoder.transCoord(tmX, tmY, callback, {
    input_coord: kakao.maps.services.Coords.TM,
    output_coord: kakao.maps.services.Coords.WGS84
});