async function dupleCheck(email) {
    try {
        const url = "/member/dupleCheck";
        const config = {
            method: "post",
            headers: {
                "Content-Type": "application/json; charset=utf-8",
            },
            body: JSON.stringify({email: email})
        }
        const resp = await fetch(url, config);
        return await resp.text();
    } catch (error) {
        console.log(error);
    }
}

document.getElementById("duple").addEventListener("click", (e) =>{
    e.preventDefault();
    let emailInput = document.getElementById("email");
    let email = emailInput.value;
    if (email == '') {
        alert("가입할 이메일을 반드시 입력하세요.")
        emailInput.focus();
        return;
    } else {
        dupleCheck(email).then(result => {
            if (parseInt(result)) {
                alert("이미 사용중인 이메일 주소입니다.");
                emailInput.value = "";
                emailInput.focus();
            } else {
                alert("사용가능한 이메일입니다.");
                document.getElementById("nickName").focus();
            }
        })
    }
})