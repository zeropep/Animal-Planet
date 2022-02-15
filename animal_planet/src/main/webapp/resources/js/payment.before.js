const customer = document.getElementById("customerInfo");
const receiver = document.getElementById("receiverInfo");
const payment = document.getElementById("paymentInfo");
const payBtn = document.getElementById("payBtn");

let cartList = null;

async function saveCart(email) {
    try {
        const resp = await fetch(`/payment/${email}`);
        const list = await resp.json();
        return await list;
    } catch (error) {
        console.log(error);
    }
}

function getCart(email, direct) {
    saveCart(email).then(result => {
        // console.log(result);
        // if (result != null) {
        //     location.href = "/member/login";
        // }
        if (result) {
            if (direct == "yes") {
                cartList = [result[result.length - 1]];
            } else {
                cartList = result;
            }
            console.log(cartList);
        } else {
        } 
    });
};

getCart(email, direct);

async function insertOrder(orderList) {
    try {
        const url = "/payment/insert";
        const config = {
            method: "post",
            headers: {
                "Content-Type": "application/json; charset=utf-8",
            },
            body: JSON.stringify(orderList),
        }
        const resp = await fetch(url, config);
        return await resp.text();
    } catch (error) {
        console.log(error);
    }
}

payBtn.addEventListener("click", () => {
    let orderList = [];
    for (let cart of cartList) {
        let data = {
            cartno: cart.cartno,
            buyer: cart.owner,
            price: cart.price,
            pname: cart.pname,
            npno: cart.npno,
            payment: "Y",
            method: "cart",
            request: document.getElementById("request").value,
            payWith: document.getElementById("option").value,
            amount: cart.cartStock,
        }
        console.log(data.payWith);
        orderList.push(data);
    }
    insertOrder(orderList).then(result => {
        if (parseInt(result)) {
            location.href = `/payment/after`;
        }
    })
})