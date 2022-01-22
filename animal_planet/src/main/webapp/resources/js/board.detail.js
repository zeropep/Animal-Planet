document.addEventListener("click", (e) => {
    if (e.target.id == "delBtn") {
        e.preventDefault();
        document.getElementById("delForm").submit();
    };
});