package com.testtask.springtodoapp.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.testtask.springtodoapp.models.TodoItem;

@Repository
public interface TodoRepository extends JpaRepository<TodoItem, Long> {
}
