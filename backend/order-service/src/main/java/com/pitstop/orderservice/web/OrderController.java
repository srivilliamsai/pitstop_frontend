package com.pitstop.orderservice.web;

import com.pitstop.orderservice.domain.Order;
import com.pitstop.orderservice.repo.OrderRepo;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/orders")
public class OrderController {

    private final OrderRepo orderRepo;

    public OrderController(OrderRepo orderRepo) {
        this.orderRepo = orderRepo;
    }

    @GetMapping
    public List<Order> getAllOrders() {
        return orderRepo.findAll();
    }

    @GetMapping("/{id}")
    public Order getOrderById(@PathVariable UUID id) {
        return orderRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Order not found with id " + id));
    }

    @PostMapping
    public Order createOrder(@RequestBody Order order) {
        return orderRepo.save(order);
    }

    @PutMapping("/{id}")
    public Order updateOrder(@PathVariable UUID id, @RequestBody Order updatedOrder) {
        Order order = orderRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Order not found with id " + id));
        order.setType(updatedOrder.getType());
        order.setStatus(updatedOrder.getStatus());
        order.setAmount(updatedOrder.getAmount());
        order.setCustomerId(updatedOrder.getCustomerId());
        return orderRepo.save(order);
    }

    @DeleteMapping("/{id}")
    public void deleteOrder(@PathVariable UUID id) {
        orderRepo.deleteById(id);
    }
}