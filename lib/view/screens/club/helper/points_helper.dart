class PointsHelper {
  static Map<String, dynamic> getPointsProgress(int currentPoints) {
    if (currentPoints < 100) {
      return {
        'current': currentPoints,
        'target': 100,
        'progress': currentPoints / 100,
      };
    } else if (currentPoints < 500) {
      return {
        'current': currentPoints,
        'target': 500,
        'progress': currentPoints / 500,
      };
    } else if (currentPoints < 1000) {
      return {
        'current': currentPoints,
        'target': 1000,
        'progress': currentPoints / 1000,
      };
    } else if (currentPoints < 5000) {
      return {
        'current': currentPoints,
        'target': 5000,
        'progress': currentPoints / 5000,
      };
    } else if (currentPoints < 10000) {
      return {
        'current': currentPoints,
        'target': 10000,
        'progress': currentPoints / 10000,
      };
    } else if (currentPoints < 50000) {
      return {
        'current': currentPoints,
        'target': 50000,
        'progress': currentPoints / 50000,
      };
    } else if (currentPoints < 100000) {
      return {
        'current': currentPoints,
        'target': 100000,
        'progress': currentPoints / 100000,
      };
    } else if (currentPoints < 500000) {
      return {
        'current': currentPoints,
        'target': 500000,
        'progress': currentPoints / 500000,
      };
    } else {
      return {
        'current': currentPoints,
        'target': 1000000,
        'progress': currentPoints / 1000000,
      };
    }
  }
}