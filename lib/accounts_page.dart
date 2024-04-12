import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_streambuilder_bug/models/account.dart';
import 'package:riverpod_streambuilder_bug/providers.dart';

class AccountsPage extends ConsumerStatefulWidget {
  const AccountsPage({super.key});

  @override
  ConsumerState<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends ConsumerState<AccountsPage> {
  @override
  void initState() {
    super.initState();

    log('Accounts initState()');
  }

  @override
  void dispose() {
    log('Accounts dispose()');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Accounts'),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await addNewFakeAccount();
            },
            label: const Text('Add dummy account')),
        body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child:
                AccountsListFuture(accountsListFuture: accountStreamFuture())));
  }
}

class AccountsListFuture extends StatelessWidget {
  final Future<Stream<List<Account>>> accountsListFuture;
  const AccountsListFuture({super.key, required this.accountsListFuture});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: accountsListFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('AccountsListFuture Error');
        }

        if (snapshot.hasData && snapshot.data != null) {
          return AccountsStream(accountsStream: snapshot.data!);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
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
        builder: (context, snapshot) => AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: AccountsStreamBody(
                snapshot: snapshot,
              ),
            ));
  }
}

class AccountsStreamBody extends StatelessWidget {
  final AsyncSnapshot<List<Account>> snapshot;
  const AccountsStreamBody({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    log('${snapshot.connectionState}');
    if (snapshot.hasError) {
      return const Text('Error');
    }

    if (snapshot.hasData && snapshot.data != null) {
      final accounts = snapshot.data!;
      return ListView.builder(
          padding: const EdgeInsets.only(
              left: 16.0, right: 16, top: 24, bottom: 96.0),
          itemCount: accounts.length,
          itemBuilder: (context, index) {
            final account = accounts[index];
            return AccountItem(
              account: account,
            );
          });
    }

    return const Center(
      child: CircularProgressIndicator(),
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
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Text(
          account.name,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
