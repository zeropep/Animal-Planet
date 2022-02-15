document.addEventListener("click", (e) => {
    if(e.target.id == "modBtn"){
        e.preventDefault();
        let modBtn = document.querySelector("#modBtn");
        modBtn.innerText = "Submit";
        
           
        modBtn.setAttribute("type", "submit");
        document.getElementById("pwd").readOnly = false;
        document.getElementById("name").readOnly = false;
        document.getElementById("nickName").readOnly = false;
        document.getElementById("phoneNumber").readOnly = false;
        document.getElementById("address").readOnly = false;
        document.getElementById("addressDetail").readOnly = false;
        document.getElementById('files').readOnly;
       document.getElementById("filesInfo").readOnly;
       document.getElementById("filesSize").readOnly;
       



        modBtn.id = "sbmBtn";
    }
});

document.getElementById('trigger').addEventListener('click', () => {
    document.getElementById('files').click();
});
const regExp = new RegExp("\.(exe|sh|bat|js|msi|dll)$"); // 실행파일 막기
const regExpImg = new RegExp("\.(jpg|jpeg|png|gif)$"); // 이미지 파일만
const maxSize = 1024 * 1024;
function fileSizeValidation(fileName, fileSize) {
    if(!regExpImg.test(fileName)){
        return 0;
    }else if(regExp.test(fileName)){
       return 0;
   }else if(fileSize > maxSize){
       return 0;
   }else{
       return 1;
   }
}

document.addEventListener('change', (e) => {
    if (e.target.id == 'files') {
        document.getElementById('modBtn').disabled = false;
        // input file element에 저장된 file 정보를 가져오는 property 리턴은 객체형
        const fileObjects = document.getElementById('files').files;
        console.log(fileObjects);
        
        let div = document.getElementById('fileZone');
        div.innerHTML = "";
        let ul = '<ul class="list-group list-group-flush">';
        let isOk = 1;
        for (let file of fileObjects) {
            let validResult = fileSizeValidation(file.name, file.size);
            isOk *= validResult;
            ul += `<li class="list-group-item d-flex justify-content-between align-items-start">`;
            ul += `<div class="ms-2 me-auto">`;
            ul += `${validResult ? '<div class="fw-bold">업로드가능':'<div class="fw-bold text-danger">업로드불가'}</div>`;
            ul += `${file.name}</div>`;
            ul += `<span class="badge bg-${validResult ? 'success':'danger'} rounded-pill">${file.size} Bytes</span></li>`;
        }
        ul += '</ul>';
        div.innerHTML = ul;
        console.log("isOk :",isOk);
        if(isOk == 0){
            document.getElementById('modBtn').disabled = true;
        }
    }
});