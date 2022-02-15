async function emailDupleCheckFromServer(emailVal){
    try {
        const url = "/member/dupleCheck";
        const config = {
            method: 'post',
            headers: {
                'Content-Type': 'application/json; charset=utf-8'
            },
            body: JSON.stringify({email: emailVal})
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}

document.getElementById("dupleCheck").addEventListener('click', (e) => {
    e.preventDefault();
    let emailInput = document.getElementById("email");
    let emailVal = emailInput.value;
    if (emailVal == '') {
        alert('가입할 이메일을 반드시 입력하세요!');
        emailInput.focus();
        return;
    } else {
        emailDupleCheckFromServer(emailVal).then(result => {
            console.log(result);
            console.log(typeof result);
            if (parseInt(result)) {
                alert("이미 사용중인 이메일 주소입니다!");
                emailInput.value = "";
                emailInput.focus();
            } else {
                alert("사용 가능한 이메일 주소입니다~");
                document.getElementById("nickName").focus();
            }
        });
    }
});