package cn.com.amber.mapper;

import cn.com.amber.entity.Account;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AccountMapper {
    public Account selectByAccountNo(String accountNo);

    public int insert(Account account);
}