package com.mmm.clout.notificationservice.notification.presentation.test;

import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

@Slf4j
@Getter
@Service
public class KafkaProducer {

    @Value(value = "${message.topic.name}")
    private String topic;

    private final KafkaTemplate<Long, TestValue> kafkaTemplate;

    @Autowired
    public KafkaProducer(KafkaTemplate kafkaTemplate) {
        this.kafkaTemplate = kafkaTemplate;
    }



    public void send(Long key, TestValue value) {
        log.info(String.format("Produce message : %s", value.getValue()));
        kafkaTemplate.send(topic, key, value);
    }
}