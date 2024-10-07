// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:online_shop/presentation/cart/bloc/OrderLoaded.dart';

// class OrderCubit extends Cubit<OrderState> {
//   OrderCubit() : super(OrderInitial());

//   // Fungsi untuk memperbarui metode pembayaran
//   void updatePaymentMethod(String paymentMethod) {
//     // Perbarui state dengan metode pembayaran yang baru
//     final currentOrder = (state as OrderLoaded).order;
//     emit(OrderLoaded(
//         order: currentOrder.copyWith(paymentMethod: paymentMethod)));
//   }
// }

// Status untuk OrderCubit
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/presentation/cart/bloc/OrderLoaded.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoaded extends OrderState {
  final Order order; // Pastikan Anda memiliki kelas Order yang didefinisikan

  OrderLoaded({required this.order});
}

// Cubit untuk Order
class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  // Fungsi untuk memperbarui metode pembayaran
  void updatePaymentMethod(String paymentMethod) {
    // Periksa apakah state saat ini adalah OrderLoaded
    if (state is OrderLoaded) {
      final currentOrder = (state as OrderLoaded).order;
      // Emit status baru dengan metode pembayaran yang diperbarui
      emit(OrderLoaded(
          order: currentOrder.copyWith(paymentMethod: paymentMethod)));
    } else {
      // Jika state adalah OrderInitial, Anda mungkin ingin melakukan sesuatu,
      // misalnya membuat order baru atau memberikan error
      emit(OrderLoaded(
          order: Order(
              paymentMethod: paymentMethod))); // Contoh: membuat order baru
    }
  }
}
