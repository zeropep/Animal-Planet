const customer = document.getElementById("customerInfo");
const receiver = document.getElementById("receiverInfo");
const payment = document.getElementById("paymentInfo");
const payBtn = document.getElementById("payBtn");
const agreement = document.getElementById("agreement");
const payWith = document.getElementById("option");

let cartList = null;
let paymentCheck = false;
let agreementCheck = false;

payWith.addEventListener("change", () => {
    payWith.value == "Choose..." ? paymentCheck = false : paymentCheck = true;
    paymentCheck && agreementCheck ? payBtn.disabled = false : payBtn.disabled = true;
})

agreement.addEventListener("change", () => {
    agreement.checked ? agreementCheck = true : agreementCheck = false;
    paymentCheck && agreementCheck ? payBtn.disabled = false : payBtn.disabled = true;
})

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

payBtn.addEventListener("click", (e) => {
    e.preventDefault();
    let orderList = [];
    for (let cart of cartList) {
        let data = {
            cartno: cart.cartno,
            buyer: cart.owner,
            price: cart.price,
            totalPrice: cart.cartStock * cart.price,
            pname: cart.pname,
            npno: cart.npno,
            payment: "Y",
            method: "cart",
            request: document.getElementById("request").value,
            payWith: payWith.value,
            amount: cart.cartStock,
        }
        orderList.push(data);
    }
    insertOrder(orderList).then(result => {
        console.log(result);
        if (parseInt(result)) {
            location.href = `/payment/after`;
        }
    })
})