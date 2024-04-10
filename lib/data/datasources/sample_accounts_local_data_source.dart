import 'package:isar/isar.dart';
import 'package:riverpod_streambuilder_bug/database/entities/account_entity.dart';
import 'package:riverpod_streambuilder_bug/domain/datasources/accounts_local_data_source.dart';

class SampleAccountsLocalDataSource implements AccountsLocalDataSource {
  final IsarCollection<AccountEntity> accountsCollection;
  final Isar isar;

  const SampleAccountsLocalDataSource({
    required this.accountsCollection,
    required this.isar,
  });

  @override
  Stream<List<AccountEntity>> getAllAccountsStream() =>
      accountsCollection.filter().nameIsNotEmpty().watch(fireImmediately: true);

  @override
  Future<void> saveFakeAccounts() async {
    final fakeAccounts = <AccountEntity>[
      AccountEntity(
        name: 'Account 1',
        accountId: 'abc',
      ),
      AccountEntity(
        name: 'Account 2',
        accountId: 'dgs',
      ),
      AccountEntity(
        name: 'Account 3',
        accountId: 'fiuc',
      ),
      AccountEntity(
        name: 'Account 4',
        accountId: 'abctr',
      ),
      AccountEntity(
        name: 'Account 5',
        accountId: 'ksks',
      ),
      AccountEntity(
        name: 'Account 6',
        accountId: 'suia',
      ),
      AccountEntity(
        name: 'Account 7',
        accountId: 'vuao',
      ),
    ];

    await isar.writeTxn(() async {
      await accountsCollection.filter().accountIdIsNotEmpty().deleteAll();
      await accountsCollection.putAll(fakeAccounts);
    });
  }
}
