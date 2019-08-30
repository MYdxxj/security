package com.yang.security4.dao;

import com.yang.security4.entity.SysUser;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface UserDao extends JpaRepository<SysUser,Integer> {
    @Query(value = "select * from sys_user where sys_user.user_name=?1",nativeQuery = true)
    SysUser findByUserName(String username);
}
