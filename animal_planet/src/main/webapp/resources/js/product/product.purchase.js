let buyQty = document.getElementById("buyQty");
let price = document.getElementById("price").value;
buyQty.addEventListener("change", () => {
    document.getElementById("total").innerText = 
        `총 가격 : ${1 * buyQty.value * price} 원`;
})

function getSrc() {
    let src = document.querySelector(".image-block-bg").getAttribute("data-image-src");
    return src.replace("_", "_th_");
}

async function postCart(data) {
    try {
        const url = '/cart/post';
        const config = {
            method : 'post',
            headers : {
                'Content-Type':'application/json; charset=utf-8'
            },
            body : JSON.stringify(data)
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}

document.getElementById("cart").addEventListener("click", () => {
    let data = {
        owner: `aaa@aaa.com`,
        npno: npnoVal,
        pname: document.getElementById("prodName").value,
        cartStock: buyQty.value,
        price: price,
        image: getSrc(),
    }
    postCart(data).then(result => {
        if (parseInt(result)) {
            alert("장바구니에 담았습니다.")
        }
    })
})

document.getElementById("buy").addEventListener("click", () => {
    let data = {
        owner: `aaa@aaa.com`,
        npno: npnoVal,
        pname: document.getElementById("prodName").value,
        cartStock: buyQty.value,
        price: price,
        image: getSrc(),
    }
    postCart(data).then(result => {
        if (parseInt(result)) {
            location.href = `/payment/before?email=${data.owner }&direct=yes`;
        }
    })
})