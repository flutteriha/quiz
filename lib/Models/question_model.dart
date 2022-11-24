class Question {
  String question;
  String answer1;
  String answer2;
  String imageAddress;
  int trueAnswer;

  Question(
    this.question,
    this.answer1,
    this.answer2,
    this.trueAnswer,
    this.imageAddress,
  );

  bool isRight(int num) {
    if (num == 0 || num == 1) {
      if (trueAnswer == 0) {
        if (num == 0) {
          return true;
        } else {
          return false;
        }
      } else {
        if (num == 1) {
          return true;
        } else {
          return false;
        }
      }
    } else {
      return false;
    }
  }
}

// 0=true and 1=false

List<Question> questionList = [
  Question('آخرین مدافعی که موفق به بردن توپ طلا شد چه کسی بود ؟', 'کاناوراو',
      'مارادونا', 0, 'assets/images/01.png'),
  Question('قدیمی ترین آثار سفالی جهان در کجا پیدا شده است ؟', 'ایران', 'چین',
      1, 'assets/images/02.png'),
  Question('منظور از پارچه پیچازی چیست ؟', 'محکم', 'شطرنجی', 1,
      'assets/images/03.png'),
  Question('نخستین پادشاه در شاهنامه چه نام دارد ؟', 'رستم', 'کیومرث', 1,
      'assets/images/04.png'),
  Question(
      'در موسیقی چند نت وجود دارد ؟', 'هفت', 'هشت', 0, 'assets/images/05.png'),
  Question('کدام کشور به صورت پادشاهی مشروطه اداره می شود ؟', 'آلمان', 'مالزی',
      1, 'assets/images/06.png'),
  Question('کدام کشور بیشترین تعداد اسکار بهترین فیلم خارجی زبان را داراست؟',
      'ایتالیا', 'فرانسه', 0, 'assets/images/07.png'),
  Question('بالاترین سرانه مصرف تخم مرغ متعلق به مردم کدام کشور است ؟', 'ژاپن',
      'چین', 0, 'assets/images/08.png'),
  Question('قدیمی ترین لباس تاریخ در کدام کشور پیدا شده است ؟', 'مصر', 'ایران',
      0, 'assets/images/09.png'),
  Question('کدام کشور کمترین میزان جنگل در جهان را داراست ؟', 'عراق', 'قطر', 1,
      'assets/images/10.png'),
];
