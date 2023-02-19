import 'domain/part_type.dart';

const skinColors = [
  0xFFFFDBB4,
  0xFFEDB98A,
  0xFFD08B5B,
  0xFFAE5D29,
  0xFF694D3D,
  0xFFFFD11B,
];

const bodyColors = [
  0xFFE78276,
  0xFFFFCF77,
  0xFFFDEA6B,
  0xFF78E185,
  0xFF9DDADB,
  0xFF9FD8E5,
  0xFF8FA7DF,
  0xFFE279C7,
  0xFFE86BBB,
  0xFFEC7495,
];

const hairColors = [
  0xFF2C1B18,
  0xFFE8E1E1,
  0xFFECDCBF,
  0xFFD6B370,
  0xFFF59797,
  0xFFB58143,
  0xFFA55728,
  0xFF724133,
  0xFF4A312C,
  0xFFC93305,
];

List<int> listColors(PartType forType) => {
      PartType.body: bodyColors,
      PartType.head: hairColors,
      PartType.face: skinColors,
      PartType.facialHair: hairColors,
      PartType.accessories: bodyColors,
      PartType.background: bodyColors,
    }[forType]!;
