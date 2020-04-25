package com.yaqari.yaqari;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
//TODO Attention au CrossOrigin il faudra autoriser seulement l'application front
@RestController
@CrossOrigin
public class helloWorld {

    private String hello = "Coucou";

    @GetMapping("/hello")
    String getHello() {
        return hello;
    }

}
