async function spreadCart(email) {
    try {
        const resp = await fetch(`/cart/${email}`);
        const cartHandler = await resp.json();
        return await cartHandler;
    } catch (error) {
        console.log(error);
    }
}

function getCartList(email) {
    spreadCart(email).then(result => {
        console.log(result);
        let totalPrice = 0;
        const tbody = document.getElementById("cartArea");
        const totalResult = document.getElementById("totalResult");
        if (result.length) {
            tbody.innerHTML = ``;
            for (let cavo of result) {
                totalPrice += (cavo.cartStock * cavo.price);
                let td = `<tr data-cartno="${cavo.cartno}"><td scope="row"><img src="${cavo.image }"/></td>`;
                td += `<td><h4>${cavo.pname }</h4></td>`;
                td += `<td><input type="number" style="width:100px;" class="form-control d-inline-block" 
                            min="1" value="${cavo.cartStock }">&nbsp;&nbsp;<button type="button"
                            class="btn btn-sm btn-secondary modStock">수정</button>&nbsp;&nbsp;
                            <button type="button" class="btn btn-sm btn-danger delStock">삭제</button></td>`;
                td += `<td>${(cavo.price) * (cavo.cartStock) }</td><td>무료</td></tr>`;
                tbody.innerHTML += td;
            };
            tbody.innerHTML += `<tr><td colspan="5" ><h5 class="text-right">
            상품가격 ${totalPrice}원 + 배송비 <strong>무료</strong> = ${totalPrice}원</h5></td></tr>`;

            totalResult.innerText = `총 상품가격 ${totalPrice} 원 - 총 할인 0 원 + 총 배송비 0 원 = 총 주문금액 ${totalPrice} 원`
        } else {
            tbody.innerHTML = `<tr><td colspan="5" class="text-center"><h6>
                                장바구니가 비어있습니다.</h6></td></tr>`;
            totalResult.innerText = `총 상품가격 0 원 - 총 할인 0 원 + 총 배송비 0 원 = 총 주문금액 0 원`
        } 
    });
};

async function editCartno(data) {
    try {
        const url = `/cart/${data.cartno}`;
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

async function eraseComment(cartno) {
    try {
        const url = `/cart/${cartno}`;
        const config = {
            method: "delete",
        };
        const resp = await fetch(url, config);
        return await resp.text();
    } catch (error) {
        console.log(error);
    }
}

document.addEventListener("click", (e) => {
    if (e.target.classList.contains("modStock")) {
        let tr = e.target.closest("tr");
        let data = {
            cartno: tr.dataset.cartno,
            cartStock: tr.childNodes.item(2).firstChild.value,
        };
        editCartno(data).then(result => {
            if (parseInt(result)) {
                getCartList(email);
            }
        });
    } else if (e.target.classList.contains("delStock")) {
        let tr = e.target.closest("tr");
        let cartno = tr.dataset.cartno;
        eraseComment(cartno).then(result => {
            if (parseInt(result)) {
                getCartList(email);
            }
        });
    }
});

