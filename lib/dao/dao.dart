import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDao {
  static SupabaseClient init = Supabase.instance.client;

  SupabaseDao._internal();

  static final SupabaseDao _instance = SupabaseDao._internal();

  factory SupabaseDao() => _instance;
}