// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:motorbike_crash_detection/modules/notification/bloc/bloc_event/notification_bloc_event.dart';
// import 'package:motorbike_crash_detection/modules/notification/bloc/notification_bloc.dart';

// import '../../../data/term/app_term.dart';
// import '../bloc/notification_stream_bloc.dart';
// import '../widget/notification_item_widget.dart';

// class NotificationBlocPage extends StatefulWidget {
//   const NotificationBlocPage({super.key});

//   @override
//   State<NotificationBlocPage> createState() => _NotificationBlocPageState();
// }

// class _NotificationBlocPageState extends State<NotificationBlocPage> {
//   final _notificationBloc = NotificationBloc();
//   final _notficationBlocStreamController = NotificationBlocStream();

//   @override
//   void initState() {
//     super.initState();
//     _notificationBloc.add(
//       NotificationBlocEvent(
//           notificationBlocEvent: NotificationEventEnum.getAllNoti),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<NotificationBloc, NotificationBlocState>(
//       bloc: _notificationBloc,
//       builder: ((context, state) {
//         final notifications = state.notifications;
//         final listNotiId = state.listNotiId;
//         final notificationsError = state.error;
//         if (notifications != null) {
//           return Scaffold(
//               appBar: AppBar(
//                 centerTitle: true,
//                 title: const Text(AppPageName.notification),
//                 actions: [
//                   IconButton(
//                       onPressed: () async {
//                         debugPrint('See All Notices');
//                         await readAllNoti(listNotiId!);
//                         await getAllNoti();
//                       },
//                       icon: const Icon(Icons.done_all))
//                 ],
//               ),
//               body: RefreshIndicator(
//                 onRefresh: () async {
//                   _notificationBloc.add(
//                     NotificationBlocEvent(
//                         notificationBlocEvent:
//                             NotificationEventEnum.getAllNoti),
//                   );
//                 },
//                 child: ListView.builder(
//                   itemBuilder: ((context, index) {
//                     return NotificationItem(
//                       notificationModel: notifications[index],
//                     );
//                   }),
//                   itemCount: notifications.length,
//                 ),
//               ));
//         }

//         if (notificationsError != null) {
//           return Center(
//             child: Text(
//               notificationsError.toString(),
//             ),
//           );
//         }
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       }),
//     );
//   }

//   Future<void> readAllNoti(List<String> listNotiId) async {
//     _notificationBloc.add(
//       NotificationBlocEvent(
//         notificationBlocEvent: NotificationEventEnum.seeAllNoti,
//         listNotiId: listNotiId,
//       ),
//     );
//   }

//   Future<void> getAllNoti() async {
//     _notificationBloc.add(
//       NotificationBlocEvent(
//           notificationBlocEvent: NotificationEventEnum.getAllNoti),
//     );
//   }
// }
