import 'package:flutter/material.dart';

class AuthService {
  // Mock login function
  Future<bool> loginWithPhone(String phoneNumber) async {
    await Future.delayed(const Duration(seconds: 2)); // simulate API delay
    if (phoneNumber == "9876543210") {
      return true; // mock success
    }
    return false; // mock failure
  }

  // Mock signup
  Future<bool> signUp(String phoneNumber) async {
    await Future.delayed(const Duration(seconds: 2));
    return true; // always success for now
  }

  // Mock logout
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}