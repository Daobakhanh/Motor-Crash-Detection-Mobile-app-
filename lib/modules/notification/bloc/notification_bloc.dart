// import 'package:motorbike_crash_detection/modules/notification/model/notification_model.dart';
// import 'package:motorbike_crash_detection/modules/notification/repo/notification_repo.dart';
// import 'package:motorbike_crash_detection/modules/providers/bloc_provider.dart';
// import 'package:bloc/bloc.dart' hide BlocBase;

// import 'package:motorbike_crash_detection/utils/debug_print_message.dart';

// import 'bloc_event/notification_bloc_event.dart';

// class NotificationBloc
//     extends Bloc<NotificationBlocEvent, NotificationBlocState>
//     implements BlocBase {
//   //String: event
//   //PersonalInforState: state

//   NotificationBloc() : super(NotificationBlocState()) {
//     on<NotificationBlocEvent>(
//       ((event, emit) async {
//         switch (event.getNotiBlocEvent) {
//           case NotificationEventEnum.getAllNoti:
//             try {
//               final notificationsRes =
//                   await NotificationRepo.getAllNotifications();
//               if (notificationsRes != null) {
//                 List<String> listNotiId = [];

//                 for (var element in notificationsRes) {
//                   listNotiId.add(element.id!);
//                 }

//                 emit(
//                   NotificationBlocState(
//                       notifications: notificationsRes, listNotiId: listNotiId),
//                 );
//               } else {
//                 DebugPrint.dataLog(
//                   currentFile: 'notification_bloc',
//                   title: 'event getAllNoti false, res null',
//                   data: null,
//                 );
//               }
//             } catch (e) {
//               emit(NotificationBlocState(error: e));
//               DebugPrint.dataLog(
//                 currentFile: 'notification_bloc',
//                 title: 'event getAllNoti false',
//                 data: e,
//               );
//             }
//             break;
//           case NotificationEventEnum.seeAllNoti:
//             try {
//               final notificationsRes =
//                   await NotificationRepo.readAllNotifications(
//                 listNotiId: event.getListNotiId!,
//               );
//               if (notificationsRes) {
//                 DebugPrint.dataLog(
//                   currentFile: 'notification_bloc',
//                   title: 'event seeAllNoti successful',
//                   data: null,
//                 );
//               }
//             } catch (e) {
//               emit(NotificationBlocState(error: e));
//               DebugPrint.dataLog(
//                 currentFile: 'notification_bloc',
//                 title: 'event getAllNoti false',
//                 data: e,
//               );
//             }
//             break;
//           case NotificationEventEnum.seeNotiWithId:
//             break;
//         }
//       }),
//     );
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//   }
// }

// class NotificationBlocState {
//   final List<NotificationModel>? notifications;
//   final List<String>? listNotiId;
//   final Object? error;
//   NotificationBlocState({
//     this.listNotiId,
//     this.notifications,
//     this.error,
//   });
// }
