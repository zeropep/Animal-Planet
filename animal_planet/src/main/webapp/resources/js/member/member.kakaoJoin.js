let rest = "4e5eb59040c6799cc2937663ddcad8ec";

const kakao = document.getElementById("kakao");
kakao.addEventListener("click", (e) => {
    e.preventDefault();
    location.href = `https://kauth.kakao.com/oauth/authorize?client_id=${rest}&redirect_uri=http://localhost:8088/member/kakaologin&response_type=code`
    // kakao.setAttribute("href", `https://kauth.kakao.com/oauth/authorize?client_id=${rest}&redirect_uri=http://localhost:8088/member/kakaologin&response_type=code`);
    // kakao.click();
});
