let regExp = /[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/gi;
function file() {
    let content = document.getElementById("content").value;
    return content.match(regExp);
}

let images = [];
let uuids = [];

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
            console.log(JSON.stringify(data));
            // images += JSON.stringify(data);
            let imageFile = {
                uuid: data.uuid,
                saveDir: data.saveDir,
                fileName: data.fileName,
                fileType: data.fileType,
                npno: 0,
                fileSize: data.fileSize,
            }
            // images.push(JSON.stringify(imageFile));
            images.push(imageFile);
            uuids.push(imageFile.uuid);
            $(el).summernote('editor.insertImage', 
                            `/upload/${data.saveDir.replace('\\', '/')}/${data.uuid}_${data.fileName}`);
            // document.getElementById("images").value = images;
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

document.getElementById("regBtn").addEventListener("click", (e) => {
    e.preventDefault();
    let realFiles = file();
    let imageArr = [];
    for (let i = 0; i < realFiles.length; i++) {
        for (let j = 0; j < uuids.length; j++) {
            if (realFiles[i] == uuids[j]) {
                imageArr.push(images[j]);
            }
        }
    }
    document.getElementById("images").value = JSON.stringify(imageArr);
    document.getElementById("form").submit()
})

