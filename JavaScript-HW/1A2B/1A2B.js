var input = document.getElementById('guess_input');
var restart = document.getElementById("restart");
var answer = document.getElementById("answer");
var display = document.getElementById("display");
var buttons = document.getElementsByClassName("btns");
var start = document.getElementById('start');
start.addEventListener('click', _randomnumber);

var arr2 = new Array();
var _random = new Array();
var _number = "";
var inputvalue = '';

//進入畫面喔鎖住按鈕
for (var btn of buttons) {
    btn.setAttribute('disabled', 'disabled');
}
input.setAttribute('disabled', 'disabled');

//產生亂數
function _randomnumber() {
    for (var btn of buttons) {
        btn.removeAttribute('disabled', 'disabled');
        start.setAttribute('disabled', 'disabled');
    }
    input.removeAttribute('disabled', 'disabled');
    for (var i = 0; i < 4; i++) {
        _random[i] = Math.floor(Math.random() * 10);
        for (var j = 0; j < i; j++) {
            while (_random[j] == _random[i]) {
                j = 0;
                _random[i] = Math.floor(Math.random() * 10);
            }
        }
        _number = _number + _random[j];
    }
}

//重新開始
function Restart() {
    //揭曉答案並且重新開始
    alert("重新開始吧~~~~~~" + "答案是 : " + _number);
    //這個是清除答案
    _number = "";
    //這個是清除歷史紀錄
    ul.innerHTML = '';
    //這個是清除輸入
    input.value = '';
    //把每個按鈕抓到並鎖住
    for (var btn of buttons) {
        btn.setAttribute('disabled', 'disabled');
        start.removeAttribute('disabled', 'disabled');
    }
    input.setAttribute('disabled', 'disabled');
}

//看答案
function Answer() {
    alert("答案是 : " + _number);
}

//判斷
function Judgment() {
    //抓到值後 再用for迴圈一個一個由字串轉成數值指派給input
    arr2 = document.getElementById('guess_input').value;
    if (arr2 != '' && arr2.length == 4) {
        for (var i = 0; i < 4; i++) {
            input[i] = parseInt(arr2[i]);
        }
        //比對答案
        JudgmentAB();
        //顯示
        displaynum();
    }
    else {
        alert('不要重複或少於4個數字');
    }
}

//一開始就初始化為0
var countofA = 0, countofB = 0;
function JudgmentAB() {
    //每輸入完一次就初始化為0
    countofA = 0;
    countofB = 0;
    //亂數中包含特定元素指派給intersect
    let intersect = _random.filter(e => arr2.includes(e));
    //總長度給total
    let total = intersect.length;
    //一個一個做比較 比較是否與A相同
    for (var i = 0; i < 4; i++) {
        if (_random[i] == input[i]) {
            countofA++;
        }
    }
    //B = 總數量-對的位置與數字A
    countofB = total - countofA;
}

//顯示
var ul = document.createElement('ul');
function displaynum() {
    input.value = '';
    //span1 把猜完後的幾A幾B出來 span2 把打的數字顯示出來
    var span1 = document.createElement('span');
    // span1.classList.add('bg-danger', 'text-white');
    span1.innerHTML = `${countofA}A${countofB}B`;
    var span2 = document.createElement('span');
    span2.innerHTML = ` ${arr2}`;

    var li = document.createElement('li');
    li.appendChild(span1);
    li.appendChild(span2);
    ul.appendChild(li);
    display.appendChild(ul);
    // span1.classList.add('backcolor');

    if (countofA == 4) {
        var success = setTimeout("alert('答對了')", 200);
        start.removeAttribute('disabled', 'disabled');
        input.value = '';
        ul.innerHTML = '';
        _number = "";
        for (var btn of buttons) {
            btn.setAttribute('disabled', 'disabled');
        }
        input.setAttribute('disabled', 'disabled');
    }
    else {
        span1.classList.add('text-warning');
        span2.classList.add('text-white');
    }
}
