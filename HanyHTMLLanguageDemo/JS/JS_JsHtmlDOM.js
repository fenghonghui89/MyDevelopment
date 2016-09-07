/**
 * Created by hanyfeng on 16/9/5.
 */



//改变html输出流
//document.write(Date());
//document.write("<p>This is a paragraph</p>"+"<br>");
//document.write("Hello " +
//    "World!"+"<br>");//折行


//通过id/签名等查找html元素
var xxx = document.getElementById('demo');
var xxx = document.getElementsByTagName('p');

//改变内容
document.getElementById('').innerHTML = 'text~';
var yyy = 0;
document.getElementById('').innerHTML = yyy+"xxx";

//改变属性
document.getElementById('').src = '1111.jpg';
document.getElementById('').setAttribute('name','value')
document.getElementById('').removeAttribute('name')

//改变css
document.getElementById('').style.visibility = true;
document.getElementById('').style.color = 'blue'


//添加节点 删除节点
document.getElementById("").appendChild("");
document.getElementById("").removeChild("");
document.getElementById("").parentNode;//父节点


//自定义标签
document.createElement(["myhero"])