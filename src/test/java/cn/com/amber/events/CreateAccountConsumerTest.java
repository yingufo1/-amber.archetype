package cn.com.amber.events;import org.junit.Test;/** * AbstractConsumerTest * * @author yangying * @version 1.0 * @since 2022/9/18 **/public class CreateAccountConsumerTest {    @Test    public void test(){        AbstractConsumer consumer = new CreateAccountConsumer();        consumer.setConsumerGroup("amber-archtype");        consumer.setTopic("amber-archtype-event");        consumer.setNameSrvAddress("82.157.252.130:9876");        consumer.init();        try {            Thread.sleep(10000);        } catch (InterruptedException e) {            throw new RuntimeException(e);        }        consumer.shutdown();    }}