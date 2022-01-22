document.getElementById("trigger").addEventListener("click", () => {
    document.getElementById("files").click();
});
const regExp = new RegExp("\.(exe|sh|bat|js|msi|dll)$");
const regExpImg = new RegExp("\.(jpg|jpeg|png|gif)$");
// 이미지파일만을 가져오기 위함.
// 표시된 확장자를 가진 파일을 제외하는 정규식
const maxSize = 1024 * 1024;
function fileSizeValidation(file) {
    if (!regExpImg.test(file.name)) {
        return 0;
    } else if (regExp.test(file.name)) {
        return 0;
    } else if (file.size > maxSize) {
        return 0;
    } else {
        return 1;
    }
}

document.getElementById("files").addEventListener("change", (e) => {
    document.getElementById("regBtn").disabled = false;
    // input file element에 저장된 file 정보를 가져오는 property
    const fileObject = document.getElementById("files").files;
    let div = document.getElementById("fileZone");
    div.innerHTML = "";
    let ul = `<ul class="list-group list-group-flush">`;
    let isOk = 1;
    for (const file of fileObject) {
        let validResult = fileSizeValidation(file);
        isOk *= validResult;
        ul += `<li class="list-group-item d-flex justify-content-between align-items-start">`;
        ul += `<div class="ms-2 me-auto">`;
        ul += `${validResult ? '<div class="fw-bold"> ok' : '<div class="fw-bold text-danger"> no'}</div>`;
        ul += `${file.name}</div>`;
        ul += `<span class="badge bg-${validResult ? `success` : 'danger'} rounded-pill">${Math.round(file.size / 1024)} KB</span></li>`;
    }
    ul += `</ul>`;
    div.innerHTML = ul;
    if (isOk == 0) {
        document.getElementById("regBtn").disabled = true;
    } 
})