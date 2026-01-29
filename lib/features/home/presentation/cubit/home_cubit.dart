import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  final String aboutTrainingText = """
تدريب Flutter ده مش كورس تعليمي تقليدي،
 ده برنامج عملي معمول علشان يجهز المتدرب يشتغل فعليًا على مشاريع حقيقية داخل الشركة.
خلال فترة التدريب، المتدرب هيكون جزء من فريق العمل،
 وهيتعامل مع كود حقيقي، متطلبات حقيقية، ومشاكل بتتحل يوميًا في مشاريع قائمة بالفعل
 مش مجرد تطبيقات تجريبية أو أمثلة للتعلم.
التدريب بيعتمد على إن المتدرب:
يفهم طريقة الشغل داخل الشركة
يلتزم بمعايير كتابة كود احترافي
يتعامل مع Git وإدارة الإصدارات
يشتغل ضمن فريق ويستقبل Feedback بشكل مستمر
الهدف الأساسي من التدريب هو تحويل المتدرب من مستوى متعلم
 إلى مطور Flutter قادر يدخل أي مشروع ويشتغل عليه بثقة.
""";

  final List<String> trainingFeatures = [
    "المشاركة في تطوير تطبيقات موبايل حقيقية",
    "تنفيذ Features مطلوبة في مشاريع قائمة",
    "التعامل مع APIs و Backends فعلية",
    '"إصلاح Bugs وتحسين الأداء"',
    "الالتزام بـ Clean Code و Architecture واضحة",
  ];
}
