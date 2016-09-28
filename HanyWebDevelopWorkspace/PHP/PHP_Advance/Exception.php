
<!-- 3-13 exception -->

<?php




#设置顶层异常处理器 使用此函数来捕获所有未被捕获的异常
function myTopException($exception)
{
    echo "<b>Exception:</b> " , $exception->getMessage();
}

set_exception_handler('myTopException');

//throw new Exception('Uncaught Exception occurred');







#自定义的 Exception 类 / 多个异常 / 重新抛出异常

class customException extends Exception
{
    public function errorMessage()
    {
        //error message
        $errorMsg = 'Error on line '.$this->getLine().' in '.$this->getFile()
            .': <b>'.$this->getMessage().'</b> is not a valid E-Mail address';
        return $errorMsg;
    }
}


function checkEmail($email){

    if(filter_var($email, FILTER_VALIDATE_EMAIL) === FALSE)
    {
        //throw exception if email is not valid
        throw new Exception("fail email");
    }

    //check for "example" in mail address
    if(strpos($email,"example") !== FALSE)
    {
        throw new Exception($email);
    }
}

$email = "someone@example.com";

try
{
    try
    {
        checkEmail($email);
    }
    catch(Exception $e)
    {
        //re-throw exception
        $value = $e->getMessage();
        if($value == "fail email"){
            throw new Exception("来一个顶端报错~");
        }else {
            throw new customException($email);
        }
    }
}

catch (customException $e)
{
    //display custom message
    echo $e->errorMessage();
}
