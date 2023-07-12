package com.learning.library.repository;

import com.learning.library.entity.BookEntity;

import java.util.List;
import java.util.Optional;

public interface BookRepository {
    void save(BookEntity bookEntity);

    List<BookEntity> findCond(BookEntity bookEntity);

    List<BookEntity> findAll();

    Optional<BookEntity> findById(Long bookId);

    void delete(BookEntity bookEntity);
}
