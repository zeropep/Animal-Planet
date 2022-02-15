let oldUuidArr = []; // 기존 content에 있던 이미지들의 uuid 배열
let images = []; // 이미지가 업로드될때마다 저장되는 이미지파일
let uuids = []; // 이미지가 업로드될때마다 저장되는 uuid
let newUuidArr = []; // 글을 수정하기 직전 content에 있는 uuid 배열
let imageArr = []; // 업로드되고 지워지지않은, 즉 새로 db에 들어갈 이미지파일들
let removeArr = []; // 더이상 사용되지 않아 db에서 지워야할 이미지들

let regExp = /[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/gi;
function file() {
    let content = document.getElementById("content").value;
    return content.match(regExp);
}
oldUuidArr = file();
// console.log(`원래 있던 파일목록 : ${oldUuidArr}`);


function uploadSummernoteImageFile(file, el) {
    data = new FormData();
    data.append("file", file);
    $.ajax({
        data : data,
        type : "POST",
        url : "/nproduct/image",
        contentType : false,
        async: true,
        enctype : 'multipart/form-data',
        processData : false,
        dataType: "JSON",
        success : function(data) {
            // console.log(JSON.stringify(data));
            let imageFile = {
                uuid: data.uuid,
                saveDir: data.saveDir,
                fileName: data.fileName,
                fileType: data.fileType,
                npno: 0,
                fileSize: data.fileSize,
            }
            images.push(imageFile);
            uuids.push(data.uuid);
            // console.log(`업로드된 파일 : ${uuids}`);
            $(el).summernote('editor.insertImage', 
                            `/upload/${data.saveDir.replaceAll('\\', '/')}/${data.uuid}_${data.fileName}`);
        }
    });
}

$('.summernote').summernote({
    // 에디터 높이
    height: 400,
    // 에디터 한글 설정
    lang: "ko-KR",
    toolbar: [
          // 글꼴 설정
          ['fontname'],
          // 글자 크기 설정
          ['fontsize'],
          // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
          ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
          // 글자색
          ['color', ['forecolor','color']],
          // 표만들기
          ['table', ['table']],
          // 글머리 기호, 번호매기기, 문단정렬
          ['para', ['ul', 'ol', 'paragraph']],
          // 줄간격
          ['height', ['height']],
          // 그림첨부, 링크만들기
          ['insert',['picture','link']],
          // 코드보기, 확대해서보기, 도움말
          ['view', ['codeview','fullscreen', 'help']]
        ],
        // 추가한 글꼴
      fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
       // 추가한 폰트사이즈
      fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
      callbacks : { 
        // 파일 업로드(다중업로드를 위해 반복문 사용)
        onImageUpload : function(files, editor, welEditable) {
            for (let i = files.length - 1; i >= 0; i--) {
                uploadSummernoteImageFile(files[i], this);
                }
            }
        }
  });

async function eraseImageFromServer(uuid) {
    try {
        const url = '/nproduct/file/'+uuid;
        const config = {
            method: 'delete'
        };
        const resp = await fetch(url, config);
        return await resp.text();
    } catch (error) {
        console.log(error);
    }
}

document.getElementById("modBtn").addEventListener("click", (e) => {
    e.preventDefault();
    newUuidArr = file();
    // console.log(`업로드 하기전 사용하는 파일들 : ${newUuidArr}`);
    // 새로 db에 넣을것들 거르기
    // 업로드한 파일들 중 마지막에 남아있는 파일들
    for (let i = 0; i < newUuidArr.length; i++) {
        let index = uuids.indexOf(newUuidArr[i]);
        if (index > -1) {
            imageArr.push(images[index]);
        }
    }
    // console.log(`db에 넣을 파일들 : ${imageArr}`);
    // 지울 파일 거르기
    // 원래있던 파일 중 마지막에 없는 파일
    for (let i = 0; i < oldUuidArr.length; i++) {
        let index = newUuidArr.indexOf(oldUuidArr[i]);
        if (index < 0) {
            removeArr.push(oldUuidArr[i]);
        }
    }
    // console.log(`db에서 지울 파일들 : ${removeArr}`);
    removeArr.forEach(uuid => {
        eraseImageFromServer(uuid);
    });
    document.getElementById("images").value = JSON.stringify(imageArr);
    document.getElementById("form").submit();
})