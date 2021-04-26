# pf-shell
Linux 下链接远程服务器的工具

# 使用

*注意:需要提前安装ssh*

```
./pfs.sh 

```

# password 文件

```
1:127.0.0.1:username:password:desc
2:127.0.0.1:username:~/.ssh/username.pem:desc

```

描述:
```
1               -- 序号
127.0.0.1       -- IP
username        -- 用户名
password        -- 密码
username.pem    -- 密钥文件
desc            -- 服务器名称

```

## 运行如图所示

![](img/pf.png)