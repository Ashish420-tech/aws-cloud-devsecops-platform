package com.devsecops;

/**
 * Hello world!
 *
 */
public class App 
{
    public static void main( String[] args )
    {
        System.out.println( "Hello World!" );
        String password = "123456"; // 🔴 Hardcoded secret (Sonar will detect)
        System.out.println(password);
    }
}
