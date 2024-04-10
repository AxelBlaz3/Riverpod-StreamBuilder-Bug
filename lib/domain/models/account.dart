import 'package:flutter/material.dart';

@immutable
class Account {
  final String id;
  final String name;

  const Account({
    required this.id,
    required this.name,
  });
}
