package com.example.shridharmali.appointment;

/**
 * Created by shridharmali on 2/7/17.
 */

public class Patient {
    private String name;
    // private Integer mobile;

    public Patient() {

    }

    public Patient(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
