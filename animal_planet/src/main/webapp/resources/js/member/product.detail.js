document.addEventListener("click", (e) => {
    if(e.target.id == "modBtn"){
        e.preventDefault();
        let modBtn = document.querySelector("#modBtn");
        modBtn.innerText = "Submit";
        modBtn.setAttribute("type", "submit");
        document.getElementById("pname").readOnly = false;
        document.getElementById("desc").readOnly = false;
        document.getElementById("price").readOnly = false;
        document.getElementById("category").disabled = false;
        document.getElementById("madeBy").disabled = false;
        modBtn.id = "sbmBtn";
    }
    if(e.target.id == 'delBtn') {
        e.preventDefault();
        document.querySelector("#delForm").submit();
    }
});