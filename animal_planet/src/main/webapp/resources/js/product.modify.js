async function removeFile(uuid) {
    try {
        const url = "/product/file/"+uuid;
        const config = {
            method: "delete",
        };
        const resp = await fetch(url, config);
        return await resp.text();
    } catch (error) {
        console.log(error);
    }
}

document.addEventListener("click", (e) => {
    if (e.target.classList.contains("file-x")) {
        removeFile(e.target.dataset.uuid).then(result => {
            if (parseInt(result) > 0) {
                alert("파일 삭제 성공");
                e.target.closest("li").remove();
            } else {
                alert("파일 삭제 실패");
            }
        })
    }
})