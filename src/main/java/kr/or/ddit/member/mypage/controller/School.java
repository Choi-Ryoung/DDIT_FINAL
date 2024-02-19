package kr.or.ddit.member.mypage.controller;

import java.io.Serializable;

public class School implements Serializable {
 
    private Integer seq;
    private String region;
    private String name;
    private String address;
 
    public School() {
    }
 
    public School(Integer seq, String name, String region, String address) {
        super();
        this.seq = seq;
        this.name = name;
        this.region = region;
        this.address = address;
    }
 
 
    public Integer getSeq() {
        return seq;
    }
 
    public void setSeq(Integer seq) {
        this.seq = seq;
    }
 
    public String getRegion() {
        return region;
    }
 
    public void setRegion(String region) {
        this.region = region;
    }
 
    public String getName() {
        return name;
    }
 
    public void setName(String name) {
        this.name = name;
    }
 
    public String getAddress() {
        return address;
    }
 
    public void setAddress(String address) {
        this.address = address;
    }        
 
}