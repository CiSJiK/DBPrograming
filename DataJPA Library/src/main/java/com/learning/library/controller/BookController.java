package com.learning.library.controller;

import com.learning.library.domain.Book;
import com.learning.library.entity.BookEntity;
import com.learning.library.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.LinkedList;
import java.util.List;

@Controller
public class BookController {
    private final BookService bookService;

    @Autowired
    public BookController(BookService bookService) {
        this.bookService = bookService;
    }

    @GetMapping("/books")
    public String list(Model model)
    {
        System.out.println("*** books mapping ***");
        List<Book.Simple> books = bookService.findBooks();
        model.addAttribute("books", books);
        return "books/bookList";
    }

    @GetMapping("/books/new")
    public String createForm()
    {
        return "books/inputBookForm";
    }

    @PostMapping(value = "/books/new")
    public String create(Book.Create form)
    {
        Long bookId = bookService.addBook(form);
        return "redirect:/";
    }

    @GetMapping("/books/search")
    public String searchForm()
    {
        return "books/searchBookForm";
    }

    @PostMapping(value="/books/search")
    public String search(Book.Create form, Model model)
    {
        List<Book.Simple> books = bookService.findCondBooks(form);
        model.addAttribute("books", books);
        return "books/bookList";
    }

    @GetMapping("/books/{bookID}/update")
    public String getBookUpdateForm(@PathVariable Long bookID, Model model)
    {
        BookEntity entity = bookService.getBookById(bookID);
        model.addAttribute("book", entity);
        return "books/updateBookForm";
    }
    @PostMapping(value = "/books/{bookID}")
    public String updateBook(@PathVariable Long bookID, Book.Update updateForm)
    {
        bookService.updateBookService(bookID, updateForm);
        return "redirect:/books/" + bookID;
    }
    @GetMapping("/books/{bookID}")
    public String getBookById(@PathVariable Long bookID, Model model)
    {
        List<BookEntity> bookSimpleListSingle = new LinkedList<>();
        bookSimpleListSingle.add(bookService.getBookById(bookID));
        model.addAttribute("books", bookSimpleListSingle);
        return "books/bookList";
    }

    @GetMapping("/books/{bookId}/delete")
    public String getBookDeleteForm(@PathVariable Long bookId, Model model)
    {
        BookEntity entity = bookService.getBookById(bookId);
        model.addAttribute("book", entity);
        return "books/deleteBookForm";
    }
    @PostMapping(value="/books/{bookId}/delete")
    public String getBookDelete(@PathVariable Long bookId, Model model)
    {
        model.addAttribute("id", bookId);
        bookService.deleteBook(bookId);
        return "redirect:/books";
    }

    @GetMapping("/")
    public String home() {
        return "home";
    }
}
