package com.mmm.clout.advertisementservice.common.exception;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import feign.Response;
import feign.codec.ErrorDecoder;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ResponseStatusException;

import java.io.IOException;
import java.io.InputStream;

@Component
public class FeignErrorDecoder implements ErrorDecoder {
    @Override
    public Exception decode(String methodKey, Response response) {
        switch (response.status()) {
            case 400:
                try (InputStream inputStream = response.body().asInputStream()) {

                    // Jackson ObjectMapper를 사용하여 JSON 파싱
                    ObjectMapper objectMapper = new ObjectMapper();
                    JsonNode jsonNode = objectMapper.readTree(inputStream);

                    // "code" 필드의 값을 추출
                    String errorCode = jsonNode.get("code").asText();
                    if (errorCode.equals("LACK_OF_POINT")) {
                        return new PointLackException();
                    }

                    return new ResponseStatusException(HttpStatus.valueOf(response.status()));
                } catch (IOException e) {
                    // IOException 처리
                    e.printStackTrace();
                }
                break;
            case 404:
                break;
            default:
                return new Exception(response.reason());
        }
        return null;
    }
}
