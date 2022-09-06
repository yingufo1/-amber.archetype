package cn.com.amber;

import lombok.extern.slf4j.Slf4j;
import org.junit.After;
import org.junit.Before;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@Slf4j
@RunWith(SpringRunner.class)
@SpringBootTest(classes = Application.class)
public class BaseContainerTest{
    private long begin;

    @Before
    public void before() {
        begin = System.currentTimeMillis();
        log.info("--------test begin--------");
    }

    @After
    public void after() {
        log.info("--------test end, total use: {}ms--------", System.currentTimeMillis() - begin);
    }

    public static void log(String format, Object... arguments) {
        log.info(format, arguments);
    }
}
