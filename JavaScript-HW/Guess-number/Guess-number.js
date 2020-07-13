var start = document.getElementById("start");
var input = document.getElementById('input');
var label = document.getElementById("label");
var buttons = document.getElementsByClassName("btn");
var getRandom;
var min = 0;
var max = 100;

for (var btn of buttons) {
    btn.setAttribute('disabled', 'disabled');
}
input.setAttribute('disabled', 'disabled');

//產生亂數的方法
function _getRandom() {
    getRandom = Math.floor(Math.random() * 10);
    alert("產生數字了");
    start.setAttribute('disabled', 'disabled');
    for (var btn of buttons) {
    btn.removeAttribute('disabled', 'disabled');
    }
    input.removeAttribute('disabled', 'disabled');
}

//輸入數字
function number(values) {
    input.value += values.innerText;
}

function del() {
    input.value = "";
}

//判斷
function sure(){
    let inputnumber = parseInt(input.value);
    if(inputnumber > min && inputnumber < max){
        if(getRandom == inputnumber){
        alert("恭喜過關");
        label.innerText = min + "~" + max;
        min = 0; 
        max = 100;
        start.removeAttribute('disabled', 'disabled');
        for (var btn of buttons) {
            btn.setAttribute('disabled', 'disabled');
        }
    }
        else if(getRandom > inputnumber && inputnumber > min){
        min = inputnumber;
        }
        else if(getRandom < inputnumber && inputnumber < max){
        max = inputnumber;
        }
    }
    else{
        alert("請輸入範圍內的數字")
    }
    label.innerText = min + "~" + max;
    input.value = "";
}