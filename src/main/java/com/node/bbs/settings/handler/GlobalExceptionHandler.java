package com.node.bbs.settings.handler;

import com.node.bbs.exception.ext.LoginException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/*
*  @ControllerAdvice:控制器增强(给控制器类增加功能--异常处理功能)
*               位置:在类的上面
*   特点:必须让框架知道这个注解所在的包名，需要在springMVC配置文件声明组件扫描器
*   指定@ControllerAdvice所在的包名
*
* */
@ControllerAdvice
public class GlobalExceptionHandler {

    // 定义方法，处理发生的异常
    /*
        处理异常的方法和控制器方法的定义一样，可以有多个参数，可以有ModelAndView，
        String，void，对象类型的返回值

        形参：Exception，表示Controller中抛出的异常对象
        通过形参可以获取发生的异常信息

        @ExceptionHandler(异常的class)：表示异常的类型，当发生此类型异常的时候，
        由当前方法处理
     */
    @ExceptionHandler(value = LoginException.class)
    @ResponseBody
    public Map<String,Object> doLoginException(Exception exception){

        // 处理LoginException的异常
        /*
            异常发生处理逻辑：
            1、需要把异常记录下来，记录到数据库，日志文件等
            2、发送通知，把异常的信息通过邮件，短信，微信发送给相关人员
            3、给用户友好的提示
         */
        Map<String,Object> map = new HashMap<>();
        map.put("success",false);
        map.put("msg",exception.getMessage());

        return map;

    }
}
