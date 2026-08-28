package com.pitstop.common.security;
import io.jsonwebtoken.*;
import java.util.*;

public class JwtUtil {
  private final String secret; private final long expiryMs;
  public JwtUtil(String secret, long expiryMinutes){ 
	  this.secret=secret; 
	  this.expiryMs=expiryMinutes*60_000L; }
  public String generate(String subject, Map<String,Object> claims){
    if(claims==null) claims=new HashMap<>();
    return Jwts.builder().setClaims(claims).setSubject(subject)
      .setIssuedAt(new Date())
      .setExpiration(new Date(System.currentTimeMillis()+expiryMs))
      .signWith(SignatureAlgorithm.HS256, secret).compact();
  }
  public Claims parse(String token){ 
	  return Jwts.parser().setSigningKey(secret).parseClaimsJws(token).getBody(); }
}
