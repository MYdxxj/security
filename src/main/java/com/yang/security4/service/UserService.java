package com.yang.security4.service;

import com.yang.security4.dao.PermissionDao;
import com.yang.security4.dao.UserDao;
import com.yang.security4.entity.SysPermission;
import com.yang.security4.entity.SysUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserService implements UserDetailsService {

    @Autowired
    private UserDao userDao;
    @Autowired
    PermissionDao permissionDao;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
       SysUser user =  userDao.findByUserName(username);
       if(user!=null){
           List<SysPermission> permissions = permissionDao.findByAdminUserId(user.getId());
           List<GrantedAuthority> grantedAuthorities = new ArrayList<>();
           for (SysPermission permission : permissions) {
               System.out.println(permission.getDescription());
               if(permission !=null &&permission.getName()!=null){
                   GrantedAuthority grantedAuthority = new SimpleGrantedAuthority(permission.getName());
                   grantedAuthorities.add(grantedAuthority);
               }
           }
           return new User(user.getUserName(),user.getPassword(),grantedAuthorities);
       }else{
           throw  new UsernameNotFoundException("admin:"+username+"不存在");
       }
    }
}
