package com.bitware.bean;

public class BitResult {
    private Object data;
    private String errorMessage;
    private boolean hasErrors;

    public BitResult() {
    }

    public static BitResult success(Object data) {
        BitResult result = new BitResult();
        result.data = data;
        result.hasErrors = false;
        return result;
    }

    public static BitResult success() {
        BitResult result = new BitResult();
        result.hasErrors = false;
        return result;
    }

    public static BitResult failure(String message) {
        BitResult result = new BitResult();
        result.hasErrors = true;
        result.errorMessage = message;
        return result;
    }

    public Object getData() {
        return this.data;
    }

    public String getErrorMessage() {
        return this.errorMessage;
    }

    public boolean isHasErrors() {
        return this.hasErrors;
    }

    public boolean isSuccess() {
        return !this.hasErrors;
    }
}
