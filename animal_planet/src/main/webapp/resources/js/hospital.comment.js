async function regComment(data) {
    try {
        const url = "/hcomment/post";
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
        hno: hnoVal,
        nickName: document.getElementById("cmtWriter").innerText,
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
            getCommentList(data.hno);
        });
    }
});

async function spreadCommentFromServer(hno, page) {
    try {
        const resp = await fetch(`/hcomment/${hno}/${page}`);
        const pageHandler = await resp.json();
        return await pageHandler;
    } catch (error) {
        console.log(error);
    }
}

function displayedAt(modAt) {
    let date = new Date(modAt);
    const milliSeconds = new Date() - date
    const seconds = milliSeconds / 1000
    if (seconds < 60) return `방금 전`
    const minutes = seconds / 60
    if (minutes < 60) return `${Math.floor(minutes)}분 전`
    const hours = minutes / 60
    if (hours < 24) return `${Math.floor(hours)}시간 전`
    const days = hours / 24
    if (days < 7) return `${Math.floor(days)}일 전`
    const weeks = days / 7
    if (weeks < 5) return `${Math.floor(weeks)}주 전`
    const months = days / 30
    if (months < 12) return `${Math.floor(months)}개월 전`
    const years = days / 365
    return `${Math.floor(years)}년 전`
  }

function printPagination(prev, startPage, pgvo, endPage, next) {
    let pgn = document.getElementById("cmtPaging");
    pgn.innerHTML = "";
    let ul = `<ul>`;
    if (prev) {
        ul += `<li class="page-item"><a href="${startPage - 1}" class="btn btn-pastel-default shadow page"><i class="mi-arrow-left"></i></a></li>`;
    }

    for (let i = startPage; i <= endPage; i++) {
        ul += `<li class="page-item ${pgvo.pageNo == i ? 'active' : ''}" aria-current="page">`;
        ul += `<a href="${i}" class="btn btn-pastel-default shadow page">${i}</a></li>`;
    }

    if (next) {
        ul += `<li class="page-item"><a href="${endPage - 1}" class="btn btn-pastel-default shadow page"><i class="mi-arrow-right"></i></a></li>`;
    }
    ul += `</ul>`;
    pgn.innerHTML = ul;
}

function getCommentList(hno, page=1) {
    spreadCommentFromServer(hno, page).then(result => {
        // console.log(result);
        if (result != null) {
            document.getElementById("cmtCount").innerText = result.totalCount;
        }
        const ul = document.getElementById("cmtArea");
        if (result.cmtList.length) {
            ul.innerHTML = "";
            for (const cvo of result.cmtList) {
                let li = `<div class="list-group-item list-group-item-action flex-column align-items-start">`;
                li += `<div class="d-flex w-100 justify-content-between">`;
                li += `<h5 class="mb-5">${cvo.nickName}</h5>`;
                li += `<small class="text-muted">${displayedAt(cvo.modAt)}</small></div>`;
                li += `<div data-cno="${cvo.cno}" class="d-flex w-100 justify-content-between">`;
                li += `<span class="mb-0">${cvo.content}</span><div>`;
                if(document.getElementById('cmtWriter').innerText == cvo.nickName){
                    li += `<button type="button" class="btn btn-sm btn-pastel-yellow py-0 mod">e</button>`;
                    li += `<button type="button" class="btn btn-sm btn-pastel-red py-0 del">x</button>`;
                }
                li += `</div></div></div>`;
             
                ul.innerHTML += li;
            };
            printPagination(result.prev, result.startPage,
                             result.pgvo, result.endPage, result.next);
        } else {
            ul.innerHTML = `<div class="list-group-item list-group-item-action flex-column align-items-start">
                            <div class="d-flex w-100 justify-content-between">
                            <h5 class="mb-5">No Comment</h5></div></div>`;
        } 
    });
};

async function eraseComment(cno) {
    try {
        const url = `/hcomment/${cno}`;
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
        const url = `/hcomment/${data.cno}`;
        const config = {
            method: "put", 
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
        let div = e.target.closest("div");
        let cno = div.parentNode.dataset.cno;
        eraseComment(cno).then(result => {
            if (parseInt(result)) {
                alert("댓글 삭제 성공")
                document.getElementById("cmtText").value = "";
                getCommentList(hnoVal);
            }
        });
    } else if (e.target.classList.contains("mod")) {
        let div = e.target.closest("div");
        let mod = document.getElementById("cmtModBtn");

        let cno = div.parentNode.dataset.cno;
        let content = div.parentNode.firstChild.innerText;

        document.getElementById("cmtText").value = content;
        document.getElementById("cmtText").focus();
        document.getElementById("cmtPostBtn").classList.add("hidden");
        mod.classList.remove("hidden");
        mod.setAttribute("data-cno", cno);
    } else if (e.target.id == "cmtModBtn") {
        let data = {
            cno: document.getElementById("cmtModBtn").dataset.cno,
            content: document.getElementById("cmtText").value,
        };

        editComment(data).then(result => {
            if (parseInt(result)) {
                alert("댓글 수정 성공")
                document.getElementById("cmtText").value = "";
                getCommentList(hnoVal);
            };
        })

        document.getElementById("cmtPostBtn").classList.remove("hidden");
        document.getElementById("cmtModBtn").classList.add("hidden");
    } else if (e.target.classList.contains("page")) {
        e.preventDefault();
        getCommentList(hnoVal, e.target.getAttribute("href"));
    }
});