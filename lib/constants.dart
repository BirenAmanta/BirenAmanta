import 'package:flutter/material.dart';

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);

const defaultPadding = 16.0;

const Deco = InputDecoration(
  hintText: 'Enter your email',
  prefixIcon: Icon(Icons.ac_unit),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderSide: BorderSide(
      color: bgColor,
    ),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
