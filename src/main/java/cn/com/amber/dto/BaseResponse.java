package cn.com.amber.dto;import lombok.Getter;import lombok.Setter;import java.io.Serializable;/** * 基础响应 * * @author yangying * @version 1.0 * @since 2022/9/14 **/@Getter@Setterpublic class BaseResponse<R> implements Serializable {    protected String code;    protected String resp;    protected String reqId;    protected R r;    public BaseResponse(String code,String resp,String reqId) {        this.code = code;        this.reqId = reqId;        this.resp = resp;    }}