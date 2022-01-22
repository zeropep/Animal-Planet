async function regComment(data) {
    try {
        const url = "/pcomment/post";
        const config = {
            method: "post",
            headers: {
                "Content-Type": "application/json; charset=utf-8",
            },
            body: JSON.stringify(data),
        };
        const resp = await fetch(url, config);
        return await resp.text();
    } catch (error) {
        console.log(error);
    }
}

document.getElementById("cmtPostBtn").addEventListener("click", (e) => {
    e.preventDefault();
    let data = {
        pno: pnoVal,
        writer: document.getElementById("cmtWriter").innerText,
        content: document.getElementById("cmtText").value,
    };
    if (data.content == null || data.content == "") {
        alert("댓글을 입력해주세요.");
        document.getElementById("cmtText").focus();
        return false;
    } else {
        regComment(data).then(result => {
            if (parseInt(result)) {
                alert("댓글 등록 성공");
            }
            document.getElementById("cmtText").value = "";
            getCommentList(data.pno);
        });
    }
});

async function spreadCommentFromServer(pno, page) {
    try {
        const resp = await fetch(`/pcomment/${pno}/${page}`);
        const pageHandler = await resp.json();
        return await pageHandler;
    } catch (error) {
        console.log(error);
    }
}

function printPagination(prev, startPage, pgvo, endPage, next) {
    let pgn = document.getElementById("cmtPaging");
    pgn.innerHTML = '';
    let ul = `<ul class="pagination justify-content-center">`;
    if (prev) {
        ul += `<li class="page-item"><a href="${startPage - 1}" class="page-link">Prev</a></li>`;
    }

    for (let i = startPage; i <= endPage; i++) {
        ul += `<li class="page-item ${pgvo.pageNo == i ? 'active' : ''}" aria-current="page">`;
        ul += `<a href="${i}" class="page-link">${i}</a></li>`;
    }

    if (next) {
        ul += `<li class="page-item"><a href="${endPage - 1}" class="page-link" >Next</a></li>`;
    }
    ul += `</ul>`;
    pgn.innerHTML = ul;
}

function getCommentList(pno, page=1) {
    spreadCommentFromServer(pno, page).then(result => {
        document.getElementById("cmtCount").innerText = result.totalCount;
        if (result.cmtList.length) {
            if (result != null) {
                const ul = document.getElementById("cmtArea");
            }
            ul.innerHTML = "";
            for (const cvo of result.cmtList) {
                let li = `<li data-cno="${cvo.cno}" class="list-group-item d-flex justify-content-between align-items-start">`;
			    li += `<div class="ms-2 me-auto"><div class="fw-bold">${cvo.writer}</div>`;
				li += `${cvo.content}</div>`;
				li += `<span class="badge bg-dark rounded-pill">${cvo.modAt}</span>`;
                li += `<button type="button" class="btn btn-sm btn-outline-warning py-0 mod"
                        data-bs-toggle="modal" data-bs-target="#myModal">e</button>`;
                li += `<button type="button" class="btn btn-sm btn-outline-danger py-0 del">x</button>`;
                li += `</li>`;
                ul.innerHTML += li;
            };
            printPagination(result.prev, result.startPage,
                result.pgvo, result.endPage, result.next);
        } else {
            ul.innerHTML = `<li class="list-group-item">No Comment</li>`;
        } 
    });
};

async function eraseComment(cno) {
    try {
        const url = `/pcomment/${cno}`;
        const config = {
            method: "delete",
        };
        const resp = await fetch(url, config);
        return await resp.text();
    } catch (error) {
        console.log(error);
    }
}

async function editComment(data) {
    try {
        const url = `/pcomment/${data.cno}`;
        const config = {
            method: "put", // 수정할 때는 put 또는 patch
            headers: {
                "Content-Type":"application/json; charset=utf-8"
            },
            body: JSON.stringify(data),
        }
        const resp = await fetch(url, config);
        return await resp.text();
    } catch (error) {
        console.log(error);
    }
}

document.addEventListener("click", (e) => {
    if (e.target.classList.contains("del")) {
        let li = e.target.closest("li");
        let cnoVal = li.dataset.cno;
        eraseComment(cnoVal).then(result => {
            if (parseInt(result)) {
                alert("댓글 삭제 성공")
                getCommentList(bnoVal);
            }
        });
    } else if (e.target.classList.contains("mod")) {
        let li = e.target.closest("li");
        let head = document.querySelector(".modal-header h4");
        let body = document.querySelector(".modal-body");

        let cno = li.dataset.cno;
        let content = li.querySelector(".fw-bold").nextSibling;

        document.getElementById("cmtTextMod").value = content.nodeValue;
        document.getElementById("cmtModBtn").setAttribute("data-cno", cno);
    } else if (e.target.id == "cmtModBtn") {
        let data = {
            cno: document.getElementById("cmtModBtn").dataset.cno,
            content: document.getElementById("cmtTextMod").value,
        };

        editComment(data).then(result => {
            if (parseInt(result)) {
                document.querySelector(".btn-close").click();
                getCommentList(bnoVal);
            };
        })
    } else if (e.target.classList.contains("page-link")) {
        e.preventDefault();
        console.log(e.target.getAttribute("href"));
        getCommentList(pnoVal, e.target.getAttribute("href"));
    }
});