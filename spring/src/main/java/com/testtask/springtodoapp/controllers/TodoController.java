package com.testtask.springtodoapp.controllers;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.testtask.springtodoapp.models.TodoItem;

import com.testtask.springtodoapp.repository.TodoRepository;;

@RestController
@RequestMapping("/api/todos")
public class TodoController {

    @Autowired
    private TodoRepository todoRepository;

    @GetMapping
    public List<TodoItem> getAll() {
        return todoRepository.findAll().reversed();
    }

    @PostMapping
    public TodoItem create(@RequestBody TodoItem todoItem) {
        return todoRepository.save(todoItem);
    }

    @PutMapping("/{id}")
    public ResponseEntity<TodoItem> update(@PathVariable("id") Long id, @RequestBody TodoItem todoItemChanges) {
        Optional<TodoItem> todoItem = todoRepository.findById(id);
        if (todoItem.isPresent()) {
            TodoItem updatedTodo = todoItem.get();
            updatedTodo.setTitle(todoItemChanges.getTitle());
            updatedTodo.setDescription(todoItemChanges.getDescription());
            updatedTodo.setCompleted(todoItemChanges.isCompleted());
            return ResponseEntity.ok(todoRepository.save(updatedTodo));
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable("id") Long id) {
        Optional<TodoItem> todoItem = todoRepository.findById(id);
        if (todoItem.isPresent()) {
            todoRepository.delete(todoItem.get());
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
