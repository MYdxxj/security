package com.yang.security4.entity;

import lombok.Data;

import javax.persistence.*;
import java.util.List;

@Data
@Entity
@Table(name = "sys_role",schema = "public")
public class SysRole {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name = "name")
    private String name;
    @ManyToMany(mappedBy = "roleList")
    private List<SysUser> userList;

    @ManyToMany
    @JoinTable(name = "sys_permission_role",joinColumns = {@JoinColumn(name = "role_id"),},inverseJoinColumns = {@JoinColumn(name = "permission_id")})
    private List<SysPermission>menuList;

    public List<SysPermission> getMenuList() {
        return menuList;
    }

    public void setMenuList(List<SysPermission> menuList) {
        this.menuList = menuList;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<SysUser> getUserList() {
        return userList;
    }

    public void setUserList(List<SysUser> userList) {
        this.userList = userList;
    }
}
