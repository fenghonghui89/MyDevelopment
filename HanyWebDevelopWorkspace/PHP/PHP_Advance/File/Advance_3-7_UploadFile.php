

<!--3-7 上传文件-->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>php - 上传文件</title>
</head>
<body>

<?php
/**

全局数组 $_FILES
第一个参数是表单的 input name，第二个下标可以是 "name", "type", "size", "tmp_name" 或 "error"

    $_FILES["file"]["name"] - 被上传文件的名称
    $_FILES["file"]["type"] - 被上传文件的类型
    $_FILES["file"]["size"] - 被上传文件的大小，以字节计
    $_FILES["file"]["tmp_name"] - 存储在服务器的文件的临时副本的名称
    $_FILES["file"]["error"] - 由文件上传导致的错误代码

对于 IE，识别 jpg 文件的类型必须是 pjpeg，对于 FireFox，必须是 jpeg。

*/
if (
    (
        ($_FILES["file"]["type"] == "image/gif")
        || ($_FILES["file"]["type"] == "image/jpeg")
        || ($_FILES["file"]["type"] == "image/pjpeg")
    )
    && ($_FILES["file"]["size"] < 20000)
)
{
    if ($_FILES["file"]["error"] > 0)
    {
        echo "Return Code: " . $_FILES["file"]["error"] . "<br />";
    }
    else
    {
        //输出文件信息
        echo "Upload: " . $_FILES["file"]["name"] . "<br />";
        echo "Type: " . $_FILES["file"]["type"] . "<br />";
        echo "Size: " . ($_FILES["file"]["size"] / 1024) . " Kb<br />";
        echo "Temp file: " . $_FILES["file"]["tmp_name"] . "<br />";

        /*
        检测是否已存在此文件，如果不存在，则把文件从临时文件夹拷贝到指定的文件夹
        在服务器的 PHP 临时文件夹创建了一个被上传文件的临时副本。这个临时的复制文件会在脚本结束时消失。要保存被上传的文件，我们需要把它拷贝到另外的位置
        */
        if (file_exists("UploadFiles/" . $_FILES["file"]["name"]))
        {
            echo $_FILES["file"]["name"] . " already exists. ";
        }
        else
        {
            move_uploaded_file($_FILES["file"]["tmp_name"],
                "UploadFiles/" . $_FILES["file"]["name"]);

            echo "Stored in: " . "UploadFiles/" . $_FILES["file"]["name"];
        }
    }
}
else
{
    echo "Invalid file";
}

?>

<form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>" method="post" enctype="multipart/form-data">
    <label for="file">Filename:</label>
    <input type="file" name="file" id="file" />
    <br />
    <input type="submit" name="submit" value="Submit" />
</form>


</body>
</html>

