import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_streambuilder_bug/database/entities/account_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
Future<Isar> isar(IsarRef ref) async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([
    AccountEntitySchema,
  ], directory: join(dir.path));

  ref.onDispose(() async {
    await isar.close();
  });

  return isar;
}

@riverpod
Future<IsarCollection<AccountEntity>> accountCollection(
    AccountCollectionRef ref) async {
  final isar = await ref.watch(isarProvider.future);

  return isar.accountEntitys;
}
