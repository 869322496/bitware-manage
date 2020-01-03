package com.bitware.utils;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author qingzeyu
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class LoginStatus {
    private String message;
    private Integer status;
}
