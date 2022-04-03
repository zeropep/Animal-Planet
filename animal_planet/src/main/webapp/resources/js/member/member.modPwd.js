const infoMsg = document.getElementById("same");
const email = document.getElementById("email").value;
const pwdCheckBtn = document.getElementById("pwdCheck");
const modBtn = document.getElementById("modBtn");
let modPwdCondition = 0;
let pwd = "";
let checkPwd =  "";

function isSame() {
    pwd =  document.getElementById('pwd').value;
    checkPwd =  document.getElementById('checkPwd').value;
    if (pwd.length < 4 || pwd.length > 12) {
        console.log(pwd.length);
        window.alert('비밀번호는 4글자 이상, 12글자 이하만 이용 가능합니다.');
        pwd=checkPwd='';
        infoMsg.innerHTML='';
    }
    if(pwd!='' && checkPwd!='') {
        if(pwd==checkPwd) {
            infoMsg.innerHTML='비밀번호가 일치합니다.';
            infoMsg.style.color='blue';
            modPwdCondition = 2;
        }
        else {
            infoMsg.innerHTML='비밀번호를 다시 확인해주세요.';
            infoMsg.style.color='red';
            modPwdCondition = 1;
        }
    }
    if (modPwdCondition == 2) {
        modBtn.disabled = false;
    } else {
        modBtn.disabled = true;
    }
}


async function pwdCheck(oldPwd) {
    try {
        const url = "/member/pwdCheck";
        const config = {
            method: "POST",
            headers: {
                'Content-Type':'application/json; charset=utf-8'
            },
            body: JSON.stringify(oldPwd)
        };
        const resp = await fetch(url, config);
        return await resp.text();
    } catch (error) {
        console.log(error);
    }
}

pwdCheckBtn.addEventListener("click", (e) => {
    e.preventDefault();
    const pwdCheckData = {
        pwd: document.getElementById('oldPwd').value,
        email: email,
    }
    pwdCheck(pwdCheckData).then(result => {
        if (parseInt(result)) {
            console.log(result);
            alert("비밀번호가 확인되었습니다.");
            modPwdCondition = 1;
            pwdCheckBtn.disabled = true;
        } else {
            alert("비밀번호가 일치하지 않습니다.");
        }
    })
})

