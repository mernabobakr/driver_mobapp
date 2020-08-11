package com.kidzona.driverservice.error;

public class TokenAuthenticationException extends RuntimeException {

    public TokenAuthenticationException(String message) {
        super(message);
    }
}
