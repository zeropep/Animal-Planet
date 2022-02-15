async function postCommentToServer(cmtData) {
    try {
        const url = '/bcomment/post';
        const config = {
            method : 'post',
            headers : {
                'Content-Type':'application/json; charset=utf-8'
            },
            body : JSON.stringify(cmtData)
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}
document.getElementById("cmtPostBtn").addEventListener('click',()=>{
    const cmtText = document.getElementById('cmtText');
    if (cmtText.value == null || cmtText.value =='') {
        alert('댓글 내용을 입력해주세요!');
        cmtText.focus();
        return false;
    } else {
        let cmtData ={
            bno : bnoVal,
            nickName : document.getElementById('cmtNickName').innerText,
            content : cmtText.value
        };
        postCommentToServer(cmtData).then(result => {
            if (parseInt(result)) {
                alert("댓글 등록 성공~");
            }
            getCommentList(cmtData.bno);
        });
    }
});

async function spreadCommentFromServer(bno, page){
    console.log(bno);
    try {
        const resp = await fetch('/bcomment/'+bno+'/'+page);
        const pageHandler = await resp.json();
        return await pageHandler;
    } catch (error) {
        console.log(error);
    }
}
function printPagination(prev, startPage, pgvo, endPage, next) {
    let pgn = document.getElementById('cmtPaging');
    pgn.innerHTML = '';
    let ul = '<ul class="pagination justify-content-center">';
    if(prev){
        ul += `<li class="page-item"><a class="page-link" href="${startPage-1}">Prev</a></li>`;
    }

    for (let i = startPage; i <= endPage; i++) {
        ul += `<li class="page-item ${pgvo.pageNo == i ? 'active':''}" aria-current="page">`;
        ul += `<a class="page-link" href="${i}">${i}</a></li>`;
    }

    if(next){
        ul += `<li class="page-item"><a class="page-link" href="${endPage+1}">Next</a></li>`;
    }
    ul += '</ul>';
    pgn.innerHTML = ul;    
}
function getCommentList(bno, page=1) {
    spreadCommentFromServer(bno, page).then(result => {
        console.log(result);
        const ul = document.getElementById('cmtListArea');
        if(result.cmtListB.length){            
            ul.innerHTML = "";
            
            for (let cvo of result.cmtListB) {
                let li = `<li data-cno="${cvo.cno}" class="list-group-item d-flex justify-content-between align-items-start">`;
                li += `<div class="ms-2 me-auto"><div class="fw-bold">${cvo.nickName}</div>`;
                li += `${cvo.content}</div>`;
                li += `<span class="badge bg-dark rounded-pill">${cvo.regAt}</span>`;
                if(document.getElementById('cmtNickName').innerText == cvo.nickName){
                    li += `<button type="button" class="btn btn-sm btn-outline-warning py-0 mod" data-bs-toggle="modal" data-bs-target="#myModal">e</button>`;
                    li += `<button type="button" class="btn btn-sm btn-pastel-red py-0 del">x</button>`;
                 }
                li += `</li>`;
                ul.innerHTML += li;
            }
            printPagination(result.prev, result.startPage, result.pgvo, result.endPage, result.next);
            
        }else{
            let li = `<li class="list-group-item">Comment List Empty</li>`;
            ul.innerHTML = li;
        }
    });
}

async function eraseCommentAtServer(cno) {
    try {
        const url = '/bcomment/'+cno;
        const config = {
            method: 'delete'
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}
async function editCommentToServer(cmtDataMod) {
    try {
        const url = '/bcomment/'+cmtDataMod.cno;
        const config = {
            method: 'put', // patch도 있음
            headers: {
                'Content-Type':'application/json; charset=utf-8'
            },
            body: JSON.stringify(cmtDataMod)
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}

document.addEventListener('click', (e) => {
    if (e.target.classList.contains('del')) {
        let li = e.target.closest('li');
        let cnoVal = li.dataset.cno;
        eraseCommentAtServer(cnoVal).then(result => {
            if (parseInt(result)) {
                alert('댓글 삭제 성공~');
            }
            getCommentList(bnoVal);
        });
    }else if(e.target.classList.contains('mod')){
        let li = e.target.closest('li');        
        let cmtText = li.querySelector('.fw-bold').nextSibling;
        document.getElementById('cmtTextMod').value = cmtText.nodeValue;
        document.getElementById('cmtModBtn').setAttribute('data-cno', li.dataset.cno);
    }else if(e.target.id == 'cmtModBtn'){
        let cmtDataMod = {
            cno: e.target.dataset.cno,
            content: document.getElementById('cmtTextMod').value
        };
        editCommentToServer(cmtDataMod).then(result => {
            if (parseInt(result)) {
                document.querySelector('.btn-close').click();
            }
            getCommentList(bnoVal);
        });        
    }else if(e.target.classList.contains('page-link')){
        e.preventDefault();        
        getCommentList(bnoVal, e.target.getAttribute('href'));
    }
});