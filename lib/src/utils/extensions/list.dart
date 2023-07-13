import '../platform.dart';

extension TekListEx<T> on List<T> {
  void flutterSort(int Function(T, T) compareCallback) {
    if (TekPlatform.isWeb) {
      _quickSort(0, length - 1, compareCallback);
    } else {
      sort(compareCallback);
    }
  }

  void _quickSort(int low, int high, int Function(T, T) compareCallback) {
    if (low < high) {
      int pivotIndex = _partition(this, low, high, compareCallback);
      _quickSort(low, pivotIndex - 1, compareCallback);
      _quickSort(pivotIndex + 1, high, compareCallback);
    }
  }

  int _partition(List<T> list, int low, int high, int Function(T, T) compareCallback) {
    T pivot = list[high];
    int i = low - 1;

    for (int j = low; j < high; j++) {
      if (compareCallback(list[j], pivot) <= 0) {
        i++;
        T temp = list[i];
        list[i] = list[j];
        list[j] = temp;
      }
    }

    T temp = list[i + 1];
    list[i + 1] = list[high];
    list[high] = temp;

    return i + 1;
  }
}
