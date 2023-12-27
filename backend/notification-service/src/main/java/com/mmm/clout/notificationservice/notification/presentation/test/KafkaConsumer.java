package com.mmm.clout.notificationservice.notification.presentation.test;

import java.io.IOException;
import lombok.extern.slf4j.Slf4j;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class KafkaConsumer {

    @KafkaListener(topics = "${message.topic.name}", groupId = "${spring.kafka.consumer.group-id}")
    public void consume(String message) throws IOException {
        log.info(String.format("Consumed message : %s", message));
    }


    @KafkaListener(topics = "{message.topic.name}", groupId = "${spring.kafka.consumer.group-id}")
    public void consumeTest(
        ConsumerRecord<String, TestValue> record)
        throws IOException {
        log.info("================================================");
        log.info("Kafka Consume Topic <<test>>");
        log.info("key : {}", record.key());
        log.info("value : {}", record.value().getValue());
        log.info("================================================");
    }
}