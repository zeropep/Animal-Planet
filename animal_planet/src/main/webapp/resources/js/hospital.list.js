document.getElementById("mapView").addEventListener("click", () => {
    document.getElementById("mapContainer").classList.remove('hidden');
    let container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
    let options = { //지도를 생성할 때 필요한 기본 옵션
	center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
	level: 7 //지도의 레벨(확대, 축소 정도)
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
                map.panTo(markpo)

                kakao.maps.event.addListener(marker, "click", clickListener(map, marker, infowindow));
            }
        };

        // WTM 좌표를 WGS84 좌표계의 좌표로 변환한다
        geocoder.transCoord(tmX, tmY, callback, {
            input_coord: kakao.maps.services.Coords.TM,
            output_coord: kakao.maps.services.Coords.WGS84
        });
    });

    function clickListener(map, marker, infowindow) {
        return function() {
            infowindow.open(map, marker);
        }
    }
});