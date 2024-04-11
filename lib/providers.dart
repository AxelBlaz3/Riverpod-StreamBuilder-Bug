import 'package:isar/isar.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_streambuilder_bug/models/account_entity.dart';
import 'package:riverpod_streambuilder_bug/models/account.dart';

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

@riverpod
Future<Stream<List<Account>>> accountsStream(AccountsStreamRef ref) async {
  final accountsCollection = await ref.watch(accountCollectionProvider.future);
  return accountsCollection
      .filter()
      .accountIdIsNotEmpty()
      .watch(fireImmediately: true)
      .toAccountStreamList();
}

@riverpod
class AccountsList extends _$AccountsList {
  @override
  Future<Stream<List<Account>>> build() async {
    final accountsStream = await ref.watch(accountsStreamProvider.future);

    return accountsStream;
  }

  Future<void> saveFakeAccounts() async {
    final accountsCollection = await ref.read(accountCollectionProvider.future);
    final isar = await ref.read(isarProvider.future);

    await isar.writeTxn(() async {
      await accountsCollection.putAll(fakeAccounts);
    });
  }
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
