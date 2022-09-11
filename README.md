# amber.archetype
amber项目的微服务骨架.基于spring-boot和spring cloud部分组件(Feigen/robin/hryrixy)等构成的微服务应用框架。</br>
需要修改的基础配置信息，需要修改application.yml文件。在配置中注释中添加todo的是需要修改的，包括：
- spring.application.name ,应用名

此外，在应用启动时最好添加如下启动参数
- -DappName=xxx ,logback需要的应用名
- -Denv=dev/fat/uat/pro，apollo需要的环境名

# 已集成组件
已集成的组件，大部分情况下不需要修改配置，特殊情况在各部分有具体描述
## shardshpere-jdbc
支持分库表，druid数据库连接池。
- 如果使用amber_00库，不需要修改配置
- 如果使用新库，需要修改配置
- 如果新增表，需要新增分库和分表策略，主键序列生成策略
## Eureka
支持服务注册和发现
## Feign
支持http客户端，根据应用自己依赖的服务进行配置
## apollo
支持apollo配置中心，使用默认的应用名命名规则(与spring.application.name)相同的话，不需要修改

# 代码分层
基于六边形架构、分层架构、微服务架构等理念，将应用代码按照如下目录结构组织
## 适配层
controller：请求的入口，发布基于http的接口API</br>
endpoint：端口，包括回调、消息消费者、生产者等入口和出口</br>
## 领域层
entity：业务实体，一般与数据库表对映。其目录下的对象基本上是贫血模型的POJO，也可以加入一些简单的实体行为
service：业务实体的复杂的行为可以用service封装。entity+service可以看做是一个实体的充血模型的完整实现。
biz:复杂业务逻辑的实现，可能需要多个业务实体共同完成的业务逻辑在这里实现
mapper：mybatis的dao接口或实现




