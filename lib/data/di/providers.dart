import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_streambuilder_bug/data/datasources/sample_accounts_local_data_source.dart';
import 'package:riverpod_streambuilder_bug/data/repositories/sample_accounts_repository.dart';
import 'package:riverpod_streambuilder_bug/database/di/providers.dart';
import 'package:riverpod_streambuilder_bug/domain/datasources/accounts_local_data_source.dart';
import 'package:riverpod_streambuilder_bug/domain/repositories/accounts_repository.dart';

part 'providers.g.dart';

@riverpod
Future<AccountsRepository> accountsRepository(AccountsRepositoryRef ref) async {
  final accountsLocalDataSource =
      await ref.watch(accountsLocalDataSourceProvider.future);
  return SampleAccountsRepository(
      accountsLocalDataSource: accountsLocalDataSource);
}

@riverpod
Future<AccountsLocalDataSource> accountsLocalDataSource(
    AccountsLocalDataSourceRef ref) async {
  final isar = await ref.watch(isarProvider.future);
  final accountsCollection = await ref.watch(accountCollectionProvider.future);
  return SampleAccountsLocalDataSource(
    accountsCollection: accountsCollection,
    isar: isar,
  );
}
