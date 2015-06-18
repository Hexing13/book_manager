package com.hx.book;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by hexing on 15-6-13.
 */
public class cha {
    public static void main(String[] args) {
        BookConn conn = new BookConn();
        Date d = new Date();
        Date d1 = new Date(d.getTime() + 30 * 24 * 60 * 60 * 1000L);
        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
        limit t = new limit();
        int n = t.daysBetween(d1,d);
        System.out.println(n);
        conn.Excu("insert into borrow values('1','1',7376,'黑天鹅','"+f.format(d1)+"')");
    }
}
