package cn.com.amber.infrastructure.aop;import cn.com.amber.commons.untils.StringUtil;import cn.com.amber.infrastructure.api.BaseReq;import cn.com.amber.infrastructure.api.Response;import cn.com.amber.infrastructure.api.enums.ResponseCode;import cn.com.amber.infrastructure.exception.BusinessException;import lombok.extern.slf4j.Slf4j;import org.aspectj.lang.ProceedingJoinPoint;import org.springframework.util.StopWatch;/** * 标准的API接口请求日志处理器，标准API需要满足：1.请求参数是可反序列化为{@link BaseReq}子类对象；2.响应参数是{@link Response}对象 * * @author yangying * @version 1.0 * @since 2022/9/25 **/@Slf4jpublic class StandardApiLogHandler extends ApiLogHandler{    @Override    public Object proceed(ProceedingJoinPoint proceedingJoinPoint) throws Throwable {        Object[] args = proceedingJoinPoint.getArgs();        if (args.length != 1 || !BaseReq.class.isAssignableFrom(args[0].getClass())) {            return Response.FAIL_WITH_MESSAGE(ResponseCode.ILLEGAL_ARGUMENT, "参数个数错误或非标准格式，请检查");        }        String reqId = ((BaseReq) args[0]).getReqId();        if (StringUtil.isBlankString(reqId)) {            return Response.FAIL(ResponseCode.ILLEGAL_ARGUMENT, "reqId");        }        StopWatch stopWatch = new StopWatch();        logConvertToJsonInfo(args[0],"收到请求,{}","收到请求,转换请求报文失败");        stopWatch.start();        Response response = proceed(proceedingJoinPoint,reqId);        stopWatch.stop();        logConvertToJsonInfo(response,"处理完成,耗时：{}ms,返回结果:{}","处理完成,耗时：{}，转换响应报文失败",                stopWatch.getTotalTimeMillis());        return response;    }    private Response proceed(ProceedingJoinPoint proceedingJoinPoint,String reqId){        Response response = null;        try {            Object resp = proceedingJoinPoint.proceed();            if(resp instanceof Response){                response = (Response) resp;            }else{                throw new RuntimeException("错误的响应返回对象，请检查方法签名");            }        } catch (BusinessException be) {            log.info("业务处理失败,{}", be.getMessage());            response = Response.FAIL_WITH_MESSAGE(be.getResponseCode(),be.getMessage());        } catch (Throwable e) {            log.error("系统异常,{}",e.getMessage(),e);            response = Response.SYSTEM_ERROR();        }        response.setReqId(reqId);        return response;    }}