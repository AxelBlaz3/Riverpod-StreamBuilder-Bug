import 'package:isar/isar.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_streambuilder_bug/models/account_entity.dart';
import 'package:riverpod_streambuilder_bug/models/account.dart';

Isar? _isar;
Future<Isar> getIsar() async {
  if (_isar == null) {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open([
      AccountEntitySchema,
    ], directory: join(dir.path));
  }

  return _isar!;
}

Future<Stream<List<Account>>> accountStreamFuture() async {
  final isar = await getIsar();
  final accountsCollection = isar.accountEntitys;
  return accountsCollection
      .filter()
      .accountIdIsNotEmpty()
      .watch(fireImmediately: true)
      .toAccountStreamList();
}

Future<void> addNewFakeAccount() async {
  final isar = await getIsar();
  final accountsCollection = isar.accountEntitys;

  await isar.writeTxn(() async {
    final accountName = 'Account #${DateTime.now().toUtc().microsecond}';
    final accountId = '${DateTime.now().toUtc().microsecond}';
    await accountsCollection
        .put(AccountEntity(accountId: accountId, name: accountName));
  });
}

Future<void> saveFakeAccounts() async {
  final isar = await getIsar();
  final accountsCollection = isar.accountEntitys;

  await isar.writeTxn(() async {
    await accountsCollection.putAll(fakeAccounts);
  });
}

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
