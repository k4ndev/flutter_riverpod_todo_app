import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod_app/models/cat_fact.dart';

final htttpClientProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: 'https://catfact.ninja/'));
});

final catFactProvider = FutureProvider.autoDispose
    .family<List<CatFactModel>, Map<String, dynamic>>((ref, mapParam) async {
  final _dio = ref.watch(htttpClientProvider);
  final _result = await _dio.get('facts', queryParameters: mapParam);
  List<Map<String, dynamic>> _data = List.from(_result.data['data']);
  ref.keepAlive();
  List<CatFactModel> _catmodel =
      _data.map((e) => CatFactModel.fromMap(e)).toList();
  return _catmodel;
});

class FutureProviderExample extends ConsumerWidget {
  const FutureProviderExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _list =
        ref.watch(catFactProvider(const {'limit': 5, 'max_lenght': 50}));

    return Scaffold(
      body: SafeArea(
          child: _list.when(
        data: (list) {
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(list[index].fact),
              );
            },
          );
        },
        error: (err, stack) {
          return const Center(
            child: Text('error'),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      )),
    );
  }
}
