import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_streambuilder_bug/domain/models/account.dart';
import 'package:riverpod_streambuilder_bug/features/accounts/accounts_view_model.dart';

class AccountsPage extends ConsumerWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsUiStateAsync = ref.watch(accountsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Accounts'),),
        body: accountsUiStateAsync.when(
      data: (uiState) => AccountsStream(accountsStream: uiState.accountsStream),
      error: (error, stackTrace) => Text('$error, $stackTrace'),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    ));
  }
}

class AccountsStream extends ConsumerWidget {
  final Stream<List<Account>> accountsStream;

  const AccountsStream({
    super.key,
    required this.accountsStream,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: accountsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final accounts = snapshot.data!;
          return ListView.builder(
              itemCount: accounts.length,
              itemBuilder: (context, index) {
                final account = accounts[index];
                return AccountItem(account: account);
              });
        }

        if (snapshot.hasError) {
          return const Text('Error');
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class AccountItem extends StatelessWidget {
  final Account account;
  const AccountItem({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(account.name),
      ),
    );
  }
}
