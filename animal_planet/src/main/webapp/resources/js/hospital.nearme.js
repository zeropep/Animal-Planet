let container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
let options = { //지도를 생성할 때 필요한 기본 옵션
center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
level: 6 //지도의 레벨(확대, 축소 정도)
};

let map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

let zoomControl = new kakao.maps.ZoomControl();
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

list.forEach(hvo => {
    let geocoder = new kakao.maps.services.Geocoder();
    let tmX = hvo.lon;
    let tmY = hvo.lat;

    let callback = function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
            // console.log(result[0].x);
            // console.log(result[0].y); 
            let markpo = new kakao.maps.LatLng(result[0].y, result[0].x);
            // console.log(markpo);
            let marker = new kakao.maps.Marker({
                map: map,
                position: markpo,
                title: hvo.bplcnm,
            });
            let infowindow = new kakao.maps.InfoWindow({
                content: `<div style="padding:5px;">${hvo.name}</div> <br>
                            <a href="/hospital/detail?hno=${hvo.hno}">자세히보기</a>`,
                removable: true
            });
            kakao.maps.event.addListener(marker, "click", clickListener(map, marker, infowindow));
        }
    };

    // WTM 좌표를 WGS84 좌표계의 좌표로 변환한다
    if (hvo.lon != null && hvo.lon != "") {
        geocoder.transCoord(tmX, tmY, callback, {
            input_coord: kakao.maps.services.Coords.TM,
            output_coord: kakao.maps.services.Coords.WGS84
        });
    }
});

if (navigator.geolocation) {
    
    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
    navigator.geolocation.getCurrentPosition(function(position) {
        
        let lat = position.coords.latitude, // 위도
            lon = position.coords.longitude; // 경도
            console.log(`lat : ${lat}`);
            console.log(`lon : ${lon}`);
        
        let locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
            message = '<div style="padding:5px;">내 위치</div>'; // 인포윈도우에 표시될 내용입니다
        
        // 마커와 인포윈도우를 표시합니다
        displayMarker(locPosition, message);
            
      });
    } else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
    
        let locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
            message = 'geolocation을 사용할수 없어요..'
            
        displayMarker(locPosition, message);
}
function clickListener(map, marker, infowindow) {
    return function() {
        infowindow.open(map, marker);
    };
};

function displayMarker(locPosition, message) {

    let imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
    let imageSize = new kakao.maps.Size(24, 35);

    let markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

    // 마커를 생성합니다
    let marker = new kakao.maps.Marker({  
        map: map, 
        position: locPosition,
        image:markerImage
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