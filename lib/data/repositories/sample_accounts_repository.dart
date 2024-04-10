import 'package:riverpod_streambuilder_bug/database/entities/account_entity.dart';
import 'package:riverpod_streambuilder_bug/domain/datasources/accounts_local_data_source.dart';
import 'package:riverpod_streambuilder_bug/domain/models/account.dart';
import 'package:riverpod_streambuilder_bug/domain/repositories/accounts_repository.dart';

class SampleAccountsRepository implements AccountsRepository {
  final AccountsLocalDataSource accountsLocalDataSource;

  const SampleAccountsRepository({required this.accountsLocalDataSource});

  @override
  Future<Stream<List<Account>>> syncAccounts() async {
    return accountsLocalDataSource.getAllAccountsStream().toAccountStreamList();
  }

  @override
  Future<void> saveFakeAccounts() async {
    await accountsLocalDataSource.saveFakeAccounts();
  }
}
