import 'package:isar/isar.dart';
import 'package:riverpod_streambuilder_bug/domain/models/account.dart';

part 'account_entity.g.dart';

@collection
class AccountEntity {
  final Id id;
  final String accountId;
  final String name;

  AccountEntity({
    this.id = Isar.autoIncrement,
    required this.accountId,
    required this.name,
  });

  Account toAccount() => Account(
        id: accountId,
        name: name,
      );
}

extension AccountEntityListExt on List<AccountEntity> {
  List<Account> toAccountList() =>
      map((accountEntity) => accountEntity.toAccount()).toList();
}

extension AccountEntityStreamListExt on Stream<List<AccountEntity>> {
  Stream<List<Account>> toAccountStreamList() =>
      map((accountEntity) => accountEntity.toAccountList());
}
