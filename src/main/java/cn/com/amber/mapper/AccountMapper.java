package cn.com.amber.mapper;

import cn.com.amber.entity.Account;

public interface AccountMapper {
    public Account selectByAccountNo(String accountNo);
}