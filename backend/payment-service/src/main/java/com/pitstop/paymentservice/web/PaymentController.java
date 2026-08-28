package com.pitstop.paymentservice.web;
import com.pitstop.paymentservice.domain.Payment; 
import com.pitstop.paymentservice.repo.PaymentRepo;
import org.springframework.http.ResponseEntity; 
import org.springframework.web.bind.annotation.*; 
import java.math.BigDecimal; import java.time.Instant; 
import java.util.*;

@RestController @RequestMapping("/payments")
public class PaymentController {
  private final PaymentRepo repo; public PaymentController(PaymentRepo r){repo=r;
  }
  
  @PostMapping
  public ResponseEntity<?> initiate(@RequestBody Map<String,Object> b){
    Payment p=new Payment();
    p.setOrderId(UUID.fromString((String)b.get("orderId")));
    p.setMethod(Payment.Method.valueOf(((String)b.get("method")).toUpperCase()));
    p.setAmount(new BigDecimal(String.valueOf(b.get("amount"))));
    return ResponseEntity.ok(repo.save(p));
  }
  
  @PostMapping("/{id}/mark-paid")
  public ResponseEntity<?> markPaid(@PathVariable UUID id, @RequestBody Map<String,String> b){
    return repo.findById(id).map(p->{ p.setStatus(Payment.Status.PAID); 
    p.setProviderTxnId(b.get("providerTxnId")); 
    p.setPaidAt(Instant.now()); 
    return ResponseEntity.ok(repo.save(p));
    })
      .orElse(ResponseEntity.notFound().build());
  }
}
