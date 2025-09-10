enum DeliveryStep {
  arrivedAtPatient,
  startDeliveryToLab,
  arrivedAtLab,
  completed
}

extension DeliveryStepExtension on DeliveryStep {
  String get label {
    switch (this) {
      case DeliveryStep.arrivedAtPatient:
        return 'Arrived at Patient';
      case DeliveryStep.startDeliveryToLab:
        return 'Starting Delivery to Lab';
      case DeliveryStep.arrivedAtLab:
        return 'Arrived at Lab';
      case DeliveryStep.completed:
        return 'Delivery Completed';
    }
  }
}
