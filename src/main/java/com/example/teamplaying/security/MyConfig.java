package com.example.teamplaying.security;

import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

import java.util.List;

public class MyConfig {

        @Bean
        public SecurityFilterChain securityFilterChain(HttpSecurity http)
                throws Exception {
            http.formLogin()
                    .loginPage("/login")
                    .defaultSuccessUrl("/main", true)
                    .usernameParameter("id")
                    .passwordParameter("pw");

            http.csrf().disable();

            http.authorizeHttpRequests().requestMatchers("/abc").authenticated();
            http.authorizeHttpRequests().anyRequest().permitAll();

            return http.build();
        }

    @Bean
    public UserDetailsService userDetailService() {
        PasswordEncoder encoder = passwordEncoder();

        String pw1 = encoder.encode("pw1");
        String pw2 = encoder.encode("pw2");

        System.out.println("pw1: " + pw1);
        System.out.println("pw2: " + pw2);

        UserDetails user1 = User.builder()
                .username("user1")
                .password(pw1)
                .authorities(List.of())
                .build();
        UserDetails user2 = User.builder()
                .username("user2")
                .password(pw2)
                .authorities(List.of())
                .build();

        return new InMemoryUserDetailsManager(user1, user2);
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
