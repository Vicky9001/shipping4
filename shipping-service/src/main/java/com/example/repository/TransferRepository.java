package com.example.repository;

import com.example.entity.Order.Order;
import com.example.entity.Order.Transfer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TransferRepository extends JpaRepository<Transfer, Long> {

    List<Transfer> findByOrder(Order order);
}
