package com.pitstop.paymentservice.domain;
import javax.persistence.*; 
import java.math.BigDecimal; 
import java.time.Instant; 
import java.util.UUID;

@Entity @Table(name="payments")
public class Payment {
	
  @Id @Column(columnDefinition="BINARY(16)") 
  private UUID id=UUID.randomUUID();
  
  @Column(columnDefinition="BINARY(16)") 
  private UUID orderId;
  @Enumerated(EnumType.STRING) 
  private Method method; @Enumerated(EnumType.STRING) 
  private Status status=Status.PENDING;
  private BigDecimal amount=BigDecimal.ZERO; 
  private String providerTxnId; 
  private Instant createdAt=Instant.now(); 
  private Instant paidAt;
  
  public enum Method{ 
	  UPI, CARD, WALLET, COD, BNPL 
	  }
  public enum Status{ 
	  PENDING, PAID, FAILED, REFUNDED, BNPL_ACTIVE 
	  }
  public UUID getId(){
	  return id; 
	  } 
  public UUID getOrderId(){ 
	  return orderId; 
	  } 
  public void setOrderId(UUID v){
	  orderId=v; 
	  }
  public Method getMethod() { 
	  return method; 
	  } 
  public void setMethod(Method v){ 
	  method=v; 
	  }
  public Status getStatus(){ 
	  return status; 
	  } 
  public void setStatus(Status v){ 
	  status=v; 
	  }
  public BigDecimal getAmount(){ 
	  return amount;
	  } public void setAmount(BigDecimal v){ 
		  amount=v;
		  }
  public String getProviderTxnId(){
	  return providerTxnId; 
	  } 
  public void setProviderTxnId(String v){
	  providerTxnId=v;
	  }
  public Instant getCreatedAt(){
	  return createdAt;
	  }
  public Instant getPaidAt(){
	  return paidAt;
	  } 
  public void setPaidAt(Instant v){
		  paidAt=v;
	  }
}
