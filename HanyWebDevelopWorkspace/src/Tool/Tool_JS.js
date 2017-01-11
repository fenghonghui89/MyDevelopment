
var obj_tool = {};

obj_tool.getXmlHttpObject = function(){

    var xmlHttp = null
    try
    {
        // code for IE7+, Firefox, Chrome, Opera, Safari
        // 或者用 if (window.XMLHttpRequest) 检查是否支持 XMLHttpRequest对象
        xmlHttp = new XMLHttpRequest()
    }
    catch (e)
    {
        try
        {
            // IE6
            xmlHttp = new ActiveXObject('Msxml2.XMLHTTP')
        }
        catch (e)
        {
            // IE6 IE5
            xmlHttp = new ActiveXObject('Microsoft.XMLHTTP')
        }
    }

    return xmlHttp
}
