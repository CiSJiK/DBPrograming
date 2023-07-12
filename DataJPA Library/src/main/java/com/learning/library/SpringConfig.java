package com.learning.library;

import com.learning.library.domain.Book;
import com.learning.library.repository.DataJpaBookRepository;
import com.learning.library.repository.MybatisBookRepository;
import com.learning.library.service.BookService;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableTransactionManagement
@MapperScan("com.learning.library.repository")
public class SpringConfig {
    /*private final MybatisBookRepository mybatisBookRepository;

    public SpringConfig(MybatisBookRepository mybatisBookRepository){
        this.mybatisBookRepository = mybatisBookRepository;
    }*/
    private final DataJpaBookRepository dataJpaBookRepository;

    public SpringConfig(DataJpaBookRepository dataJpaBookRepository)
    {
        this.dataJpaBookRepository = dataJpaBookRepository;
    }

    @Bean
    public BookService bookService(){
        //return new BookService(mybatisBookRepository);
        return new BookService(dataJpaBookRepository);
    }
}
