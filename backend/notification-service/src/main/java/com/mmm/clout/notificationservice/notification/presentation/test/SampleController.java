package com.mmm.clout.notificationservice.notification.presentation.test;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@CrossOrigin("*")
@RestController
@RequiredArgsConstructor
@RequestMapping(value = "/kafka/test")
public class SampleController {

    private final KafkaProducer producer;

    @GetMapping("/send")
    public String readAlarms(@RequestParam Long key, @RequestParam String message) {
        TestValue value = TestValue.builder().value(message).build();
        this.producer.send(key, value);
        return String.format("topic : %s // key : %d // value : %s", this.producer.getTopic(), key, message);
    }
}