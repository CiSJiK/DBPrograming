package com.learning.library.repository;

import com.learning.library.entity.BookEntity;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.Optional;


public class JpaBookRepository implements BookRepository{
    private final EntityManager em;

    public JpaBookRepository(EntityManager em)
    {
        this.em = em;
    }

    @Override
    @Transactional
    public void save(BookEntity book)
    {
        em.persist(book);
    }

    @Override
    public List<BookEntity> findAll()
    {
        List<BookEntity> result = em.createQuery("select b from book b", BookEntity.class).getResultList();
        return result;
    }

    @Override
    public Optional<BookEntity> findById(Long id)
    {
        BookEntity book = em.find(BookEntity.class, id);
        return Optional.ofNullable(book);
    }

    @Override
    public List<BookEntity> findCond(BookEntity bookEntity)
    {
        String sql = "select b from book b where b.name LIKE concat('%', :inputName, '%') and b.publisher LIKE concat('%', :inputPublisher, '%')";
        TypedQuery<BookEntity> query = em.createQuery(sql, BookEntity.class);
        query.setParameter("inputName", bookEntity.getName());
        query.setParameter("inputPublisher", bookEntity.getPublisher());
        List<BookEntity> result = query.getResultList();
        return result;
    }

    @Override
    @Transactional
    public void delete(BookEntity book)
    {
        em.remove(book);
    }
}
