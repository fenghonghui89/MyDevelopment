/**
 * Created by hanyfeng on 16/9/5.
 */



//改变html输出流
//document.write(Date());
//document.write("<p>This is a paragraph</p>"+"<br>");
//document.write("Hello " +
//    "World!"+"<br>");//折行


//通过id/签名等查找html元素
var x = document.getElementById('demo');
var x = document.getElementsByTagName('p');

//改变内容
document.getElementById('demo').innerHTML = 'text~';

//改变属性
document.getElementById('image').src = '1111.jpg';

//改变css
document.getElementById('div1').style.visibility = true;
document.getElementById('div1').style.color = 'blue'


//添加节点 删除节点
document.getElementById("").appendChild("");
document.getElementById("").removeChild("");
document.getElementById("").parentNode;
