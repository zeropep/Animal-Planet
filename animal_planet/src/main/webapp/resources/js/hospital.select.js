for (let i = 0; i < 25; i++) {
    let id = `CD${3000000 + (i * 10000)}`;
    document.getElementById(`${id}`).addEventListener("mouseenter", (e) => {
        let text = document.getElementById(`L${e.target.id}`);
        console.log(text.innerHTML);
        text.classList.remove("hidden");

        setTimeout(function () {
            text.classList.add("hidden");
        }, 3000)
    })
}

document.addEventListener("click", (e) => {
    if (e.target.classList.contains("OUTLINE")) {
        e.preventDefault();
        let id = e.target.id;
        // console.log(id.substr(2, 7));
        location.href = `/hospital/list?opn=${id.substr(2, 7)}`;
    }
});

