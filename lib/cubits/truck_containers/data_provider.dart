part of 'cubit.dart';

class TrucksDataProvider {
  Future<TContainer?> getContainerData(
      String truckName, String truckDocId, String containerName) async {
    try {
      String containerCollectionPath = '$truckName/$truckDocId/$containerName';
      QuerySnapshot containerSnapshot = await FirebaseFirestore.instance
          .collection(containerCollectionPath)
          .limit(1)
          .get();

      if (containerSnapshot.docs.isNotEmpty) {
        DocumentSnapshot containerDoc = containerSnapshot.docs.first;
        Map<String, dynamic> containerData =
            containerDoc.data() as Map<String, dynamic>;
        TContainer container = TContainer(
          count: containerData['count'] as int,
          isCheck: containerData['isCheck'] as bool,
          scanFail: containerData['scan_fail'] as int,
          scanSuccesses: containerData['scan_successes'] as int,
        );

        return container;
      } else {
        print('TContainer not found for $truckDocId - $containerName');
        return null;
      }
    } catch (e) {
      print('Error fetching container data: $e');
      return null;
    }
  }

  Future<Truck?> getTruckData(String collectionName) async {
    try {
      DateTime now = DateTime.now();
      DateTime startOfDay = DateTime(now.year, now.month, now.day);
      DateTime endOfDay =
          DateTime(now.year, now.month, now.day, 23, 59, 59, 999);

      Timestamp startTimestamp = Timestamp.fromDate(startOfDay);
      Timestamp endTimestamp = Timestamp.fromDate(endOfDay);
      print(now);

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .where('date', isGreaterThanOrEqualTo: startTimestamp)
          .where('date', isLessThanOrEqualTo: endTimestamp)
          .get();

      if (querySnapshot.docs.isEmpty) {
        print('No truck found for today in $collectionName');
        return null;
      }

      DocumentSnapshot truckSnapshot = querySnapshot.docs.first;

      if (truckSnapshot.exists) {
        String truckDocId = truckSnapshot.id;
        Map<String, dynamic> truckData =
            truckSnapshot.data() as Map<String, dynamic>;

        List<TContainer?> containers = [];

        List<String> containerNames = ['PO1251', 'PO1356', 'PO1386', 'PO1740'];

        for (String containerName in containerNames) {
          TContainer? container =
              await getContainerData(collectionName, truckDocId, containerName);
          containers.add(container);
        }

        if (containers.any((container) => container == null)) {
          print(
              'Error: Some containers not found for truck in $collectionName');
          return null;
        }

        Truck truck = Truck(
          name: collectionName,
          po1251: containers[0]!,
          po1356: containers[1]!,
          po1386: containers[2]!,
          po1740: containers[3]!,
          date: truckData['date'].toDate(),
          totalCount: truckData['total_count'] as int,
          totalFail: truckData['total_fail'] as int,
          totalSuccess: truckData['total_success'] as int,
        );

        return truck;
      } else {
        print('Truck document does not exist in $collectionName');
        return null;
      }
    } catch (e) {
      print('Error fetching truck data: $e');
      return null;
    }
  }

  Future<List<Truck?>> getAllTrucks() async {
    try {
      List<String> names = ['lila1', 'lila2', 'lila3', 'lila4'];
      List<Truck?> trucks = [];
      for (String name in names) {
        Truck? truck = await getTruckData(name);
        trucks.add(truck);
      }
      if (trucks.any((truck) => truck == null)) {
        print('Error: Some trucks not found');
        return [];
      }
      return trucks;
    } catch (e) {
      print("ERROR FETCHING TUCKS DATA");
      return [];
    }
  }

  Future<int> getTotalContainerCounts() async {
    int totalCount = 0;

    try {
      List<Truck?> trucks = await getAllTrucks();

      for (Truck? truck in trucks) {
        if (truck != null) {
          totalCount += truck.po1251.count;
          totalCount += truck.po1356.count;
          totalCount += truck.po1386.count;
          totalCount += truck.po1740.count;
        } else {
          print('Some trucks not found');
        }
      }

      return totalCount;
    } catch (e) {
      print('Error calculating total container counts: $e');
      return 0;
    }
  }
}
