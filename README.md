# amber.archetype
amber项目的微服务骨架

基于spring-boot和spring cloud部分组件(Feigen/robin/hryrixy)等构成的微服务应用框架。

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


