import 'package:flutter_riverpod/flutter_riverpod.dart';

final dateProvider = StateProvider<String>((ref) {
  return 'بەروار/مانگ/ساڵ';
});
final timeProvider = StateProvider<String>((ref) {
  return 'سەعات : خولەک';
});
