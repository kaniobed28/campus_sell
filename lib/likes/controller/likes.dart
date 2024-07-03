import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// "the Idea behind the like system is that if create a post of item, it should come with a column that has a field of list that contains uids as list and they are the likes"
// the calculation of the likes and checking if I have like or not should check if my uid is in the list and should be done promatically to avoid querying the database multiple times.
class LikeItem extends GetxController {
  RxList likesList = [].obs;
  RxInt likesLength = 0.obs;
  RxBool liked = false.obs;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  void containsUID(dynamic itemId, dynamic uid) async {
    DocumentSnapshot data =
        await firebaseFirestore.collection("items").doc(itemId).get();
    // DocumentReference   dataRef = await firebaseFirestore.collection("items").doc(itemId);
    List listdata = data["likes"];
    if (listdata.contains(uid)) {
      liked.value = true;
      likesList.value = listdata;
      likesLength.value = listdata.length;
    } else {
      liked.value = false;
      likesList.value = listdata;
      likesLength.value = listdata.length;
    }
  }

  void addAndRemoveLike(dynamic itemId, dynamic uid) async {
    DocumentSnapshot data =
        await firebaseFirestore.collection("items").doc(itemId).get();
    DocumentReference dataRef =
         firebaseFirestore.collection("items").doc(itemId);
    if (liked.value) {
      List listdata = data["likes"];
      likesList.value = listdata;
      likesList.remove(uid);
      liked.value = false;
      dataRef.update({"likes": likesList});
      likesLength.value = listdata.length;
    } else {
      List listdata = data["likes"];
      likesList.value = listdata;
      likesList.add(uid);
      liked.value = true;
      dataRef.update({"likes": likesList});
      likesLength.value = listdata.length;
    }
  }

  likesS(List likes, dynamic uid, dynamic itemId) async {
    // data

    if (likes.length != null) {
      if (likes.contains(uid)) {
        liked.value = true;
      } else {
        liked.value = false;
      }
      likesLength.value = likes.length;
      return likes.length;
    } else {
      likesLength.value = 0;
      return 0;
    }
  }
}
