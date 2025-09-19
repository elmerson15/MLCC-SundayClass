import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mllccsundayclass/service.dart';

final productdataprovider=FutureProvider<bool>((ref) {
  return ref.watch(provider).fetchData();
});