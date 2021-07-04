import 'package:equatable/equatable.dart';
import 'package:flippy/flippy.dart';

class FlippyControllerState extends Equatable {
  final int current;
  final int vector;
  final int next;
  final int target;
  final FlippyStatus status;

  const FlippyControllerState({
    required this.current,
    required this.vector,
    required this.next,
    required this.target,
    required this.status,
  });

  @override
  List<Object> get props => [current, vector, next, target, status];

  @override
  bool get stringify => true;
}
