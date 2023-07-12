package com.learning.library.service;

import com.learning.library.domain.Book;
import com.learning.library.entity.BookEntity;
import com.learning.library.repository.DataJpaBookRepository;
import com.learning.library.repository.MybatisBookRepository;

import java.util.ArrayList;
import java.util.List;

public class BookService {
    /*private final MybatisBookRepository bookRepository;

    public BookService(MybatisBookRepository bookRepository){
        this.bookRepository = bookRepository;
    }*/
    private final DataJpaBookRepository bookRepository;

    public BookService(DataJpaBookRepository bookRepository)
    {
        this.bookRepository = bookRepository;
    }

    public List<Book.Simple> findBooks(){
        List<Book.Simple> list = new ArrayList<>();
        for(BookEntity bookEntity : bookRepository.findAll()){
            Book.Simple book = new Book.Simple();
            book.setId(bookEntity.getId());
            book.setName(bookEntity.getName());
            book.setPublisher(bookEntity.getPublisher());
            book.setPrice(bookEntity.getPrice());
            list.add(book);
        }
        return list;
    }
    public Long addBook(Book.Create bookForm)
    {
        BookEntity entity = new BookEntity();
        entity.setName(bookForm.getName());
        entity.setPublisher(bookForm.getPublisher());
        entity.setPrice(bookForm.getPrice());
        bookRepository.save(entity);
        return entity.getId();
    }

    public List<Book.Simple> findCondBooks(Book.Create bookForm)
    {
        BookEntity entity = new BookEntity();
        entity.setName(bookForm.getName());
        entity.setPublisher(bookForm.getPublisher());
        entity.setPrice(bookForm.getPrice());

        List<Book.Simple> list = new ArrayList<>();
        //for(BookEntity e : bookRepository.findCond(entity))
        for(BookEntity e : bookRepository.findCond(entity.getName(), entity.getPublisher()))
        {
            Book.Simple book = new Book.Simple();
            book.setId(e.getId());
            book.setPrice(e.getPrice());
            book.setPublisher(e.getPublisher());
            book.setName(e.getName());
            list.add(book);
        }
        return list;
    }

    public BookEntity getBookById(Long bookId)
    {
        return bookRepository.findById(bookId).orElseThrow(IllegalArgumentException::new);
    }

    public void updateBookService(Long bookId, Book.Update updateForm)
    {
        System.out.println("ID: " + bookId);
        BookEntity entity = bookRepository.findById(bookId).orElseThrow(IllegalArgumentException::new);

        entity.setName(updateForm.getName());
        entity.setPrice(updateForm.getPrice());
        entity.setPublisher(updateForm.getPublisher());
        System.out.println("Updating...");
        //bookRepository.update(entity);
        bookRepository.save(entity);
        System.out.println("*** books Updated ***");
    }

    public void deleteBook(Long bookId)
    {
        BookEntity entity = bookRepository.findById(bookId).orElseThrow(IllegalArgumentException::new);
        bookRepository.delete(entity);
    }
}
