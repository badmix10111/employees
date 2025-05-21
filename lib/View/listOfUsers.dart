// // lib/View/listOfUsers.dart

// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:go_router/go_router.dart';
// import 'package:restart_app/restart_app.dart';

// import 'package:employees/Model/listOfUsersModel.dart';
// import 'package:employees/Repository/usersRepo.dart';

// class ListOfUsersPage extends StatefulWidget {
//   const ListOfUsersPage({Key? key}) : super(key: key);

//   @override
//   State<ListOfUsersPage> createState() => _ListOfUsersPageState();
// }

// class _ListOfUsersPageState extends State<ListOfUsersPage> {
//   Future<ListOfUsers>? _usersFuture;
//   bool _loading = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadUsers();
//   }

//   Future<void> _loadUsers() async {
//     setState(() => _loading = true);

//     try {
//       final repo = GetIt.I.get<UsersRepo>();
//       final list = await repo.getUsers();
//       setState(() {
//         _usersFuture = Future.value(list);
//       });
//     } catch (e) {
//       setState(() => _usersFuture = Future.error(e));
//     } finally {
//       setState(() => _loading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         title: const Text('Users'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: _loading ? null : _loadUsers,
//           ),
//         ],
//       ),
//       body: _loading && _usersFuture == null
//           ? const Center(child: CircularProgressIndicator())
//           : FutureBuilder<ListOfUsers>(
//               future: _usersFuture,
//               builder: (ctx, snap) {
//                 if (snap.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (snap.hasError) {
//                   return _buildErrorUI(snap.error.toString());
//                 }

//                 final users = snap.data?.data ?? [];
//                 if (users.isEmpty) {
//                   return const Center(child: Text('No data available.'));
//                 }

//                 return ListView.builder(
//                   itemCount: users.length,
//                   itemBuilder: (_, i) {
//                     final user = users[i];
//                     final ageStr = user.employeeAge?.toString() ?? '';
//                     final salaryStr = user.employeeSalary?.toString() ?? '';

//                     return Card(
//                       elevation: 4,
//                       margin: const EdgeInsets.symmetric(
//                           horizontal: 8, vertical: 6),
//                       child: ListTile(
//                         onTap: () => context.push('/detail/${user.id}'),
//                         title: Text(
//                           'Name: ${user.employeeName ?? 'N/A'}',
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             if (ageStr.isNotEmpty) Text('Age: $ageStr'),
//                             if (salaryStr.isNotEmpty)
//                               Text('Salary: $salaryStr'),
//                           ],
//                         ),
//                         trailing: IconButton(
//                           icon: const Icon(Icons.remove_red_eye),
//                           onPressed: () => context.push('/detail/${user.id}'),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//     );
//   }

//   Widget _buildErrorUI(String errorMsg) {
//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             'Error: $errorMsg',
//             textAlign: TextAlign.center,
//             style: const TextStyle(color: Colors.red),
//           ),
//           const SizedBox(height: 8),
//           ElevatedButton(
//             onPressed: _loadUsers,
//             child: const Text('Retry'),
//           ),
//           const SizedBox(height: 4),
//           ElevatedButton(
//             onPressed: Restart.restartApp,
//             child: const Text('Restart App'),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:restart_app/restart_app.dart';

import 'package:employees/Model/listOfUsersModel.dart';
import 'package:employees/Repository/usersRepo.dart';

class ListOfUsersPage extends StatefulWidget {
  const ListOfUsersPage({Key? key}) : super(key: key);

  @override
  State<ListOfUsersPage> createState() => _ListOfUsersPageState();
}

class _ListOfUsersPageState extends State<ListOfUsersPage> {
  Future<ListOfUsers>? _usersFuture;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    setState(() => _loading = true);

    try {
      final repo = GetIt.I.get<UsersRepo>();
      final list = await repo.getUsers();
      setState(() {
        _usersFuture = Future.value(list);
      });
    } catch (e) {
      setState(() => _usersFuture = Future.error(e));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Users'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loading ? null : _loadUsers,
          ),
        ],
      ),
      body: _loading && _usersFuture == null
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<ListOfUsers>(
              future: _usersFuture,
              builder: (ctx, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snap.hasError) {
                  return _buildErrorUI(snap.error.toString());
                }

                final users = snap.data?.data ?? [];
                if (users.isEmpty) {
                  return const Center(child: Text('No data available.'));
                }

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (_, i) {
                    final user = users[i];
                    final ageStr = user.employeeAge?.toString() ?? '';
                    final salaryStr = user.employeeSalary?.toString() ?? '';

                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      child: ListTile(
                        onTap: () => context.push('/detail/${user.id}'),
                        title: Text(
                          'Name: ${user.employeeName ?? 'N/A'}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (ageStr.isNotEmpty) Text('Age: $ageStr'),
                            if (salaryStr.isNotEmpty)
                              Text('Salary: $salaryStr'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_red_eye),
                          onPressed: () => context.push('/detail/${user.id}'),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }

  Widget _buildErrorUI(String errorMsg) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Error: $errorMsg',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _loadUsers,
            child: const Text('Retry'),
          ),
          const SizedBox(height: 4),
          ElevatedButton(
            onPressed: Restart.restartApp,
            child: const Text('Restart App'),
          ),
        ],
      ),
    );
  }
}
