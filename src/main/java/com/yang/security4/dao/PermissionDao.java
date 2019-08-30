package com.yang.security4.dao;

import com.yang.security4.entity.SysPermission;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface PermissionDao extends JpaRepository<SysPermission,Integer> {
    @Query(value = "select p.* from sys_user u " +
            "left join sys_role_user sru on u.id=sru.sys_user_id " +
            "left join sys_role r on sru.sys_role_id=r.id " +
            "left join sys_permission_role spr on spr.role_id=r.id " +
            "left join sys_permission p on p.id =spr.permission_id " +
            "where u.id=?1",nativeQuery = true)
    public List<SysPermission> findByAdminUserId(Integer userId);
}
