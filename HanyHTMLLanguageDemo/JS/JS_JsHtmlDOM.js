/**
 * Created by hanyfeng on 16/9/5.
 */



//改变html输出流
function jsdom_test(){
    document.write(Date());
    document.write("<p>This is a paragraph</p>"+"<br>");
    document.write("Hello " +
        "World!"+"<br>");//折行
}

//通过id/签名等查找html元素
function jsdom_test1(){

    var x1 = document.getElementById('demo');
    var x2 = document.getElementsByTagName('p');

    var x3 = document.getElementById('div');
    var list = x3.getElementsByTagName('p');
    alert(list[1].innerHTML);
    alert(list[1].childNodes[0].nodeValue);
    alert(list[1].firstChild.nodeValue);
}


//改变文本内容
function jsdom_test2(){
    document.getElementById('').innerHTML = 'text~';

    var yyy = 0;
    document.getElementById('').innerHTML = yyy+"xxx";
}

//改变属性
function jsdom_test3(){

    document.body.style.backgroundColor='lavender'
    document.getElementById('').style.visibility = true;
    document.getElementById('').style.color = 'blue'
    document.getElementById('').src = '1111.jpg';
    document.getElementById('').setAttribute('name','value')
    document.getElementById('').removeAttribute('name')
    document.getElementById('').getAttribute('style')//text-align: left;color: #0000FF
    document.getElementById('').attributes.getNamedItem('style').nodeValue//text-align: left;color: #0000FF
    //nodeName nodeType 详见Root_JSShow.html

}

//节点
function jsdom_test4(){

    //firstChild 属性可用于访问元素的文本
    document.getElementById("h1").firstChild;

    //访问全部文档
    document.documentElement
    document.body

    document.getElementById("intro").childNodes[0].nodeValue;

    document.getElementById("").appendChild("");
    document.getElementById("").removeChild("");
    document.getElementById("").replaceChild("");
    document.getElementById("").parentNode;//父节点

}


//自定义标签
function jsdom_test5(){
    document.createElement(["myhero"])
}