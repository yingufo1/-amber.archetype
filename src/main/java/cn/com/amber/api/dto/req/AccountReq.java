package cn.com.amber.api.dto.req;import cn.com.amber.infrastructure.api.BaseReq;import lombok.Getter;import lombok.NoArgsConstructor;import lombok.Setter;import java.math.BigDecimal;/** * 账户请求 * * @author yangying * @version 1.0 * @since 2022/9/14 **/@Setter@Getter@NoArgsConstructorpublic class AccountReq extends BaseReq {    private String name;    private String accountNo;    private BigDecimal balance;    private String balanceDirection;    public AccountReq(String requestId){        super(requestId);    }}