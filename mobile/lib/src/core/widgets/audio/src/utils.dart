double valueFromPercentageInRange({
  required final double min,
  required final double max,
  required final double percentage,
}) {
  return percentage * (max - min) + min;
}

double percentageFromValueInRange({
  required final double min,
  required final double max,
  required final double value,
}) {
  return (value - min) / (max - min);
}
