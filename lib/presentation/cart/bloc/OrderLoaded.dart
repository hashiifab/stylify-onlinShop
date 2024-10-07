class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoaded extends OrderState {
  final Order order;

  OrderLoaded({required this.order});
}

class Order {
  final String paymentMethod;

  Order({required this.paymentMethod});

  Order copyWith({String? paymentMethod}) {
    return Order(
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}
