// 계약서
import 'package:clout/providers/contract_controller.dart';
import 'package:clout/screens/contract_list/utilities/save_file_mobile.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class ContractMaker {
  final contractController = Get.find<ContractController>();

  Future<void> generateContract(int input) async {
    // PDF 글꼴 설정
    final ByteData data =
        await rootBundle.load('assets/fonts/NotoSansKR-Regular.ttf');
    final Uint8List fontData = data.buffer.asUint8List();
    final PdfFont titleFont = PdfTrueTypeFont(fontData, 20);
    final PdfFont labelFont =
        PdfTrueTypeFont(fontData, 15, style: PdfFontStyle.bold);
    final PdfFont tableLabelFont =
        PdfTrueTypeFont(fontData, 12, style: PdfFontStyle.bold);
    final PdfFont contentFont = PdfTrueTypeFont(fontData, 10);

    // pdf 서류 생성
    final PdfDocument document = PdfDocument();

    // 페이지 생성
    final PdfPage page_1 = document.pages.add();
    final PdfPage page_2 = document.pages.add();
    final PdfPage page_3 = document.pages.add();

    // 페이지 사이즈 정보 얻어오기(다 똑같아서 하나만)
    final Size pageSize = page_1.getClientSize();

    // 파란색 테두리 그리기
    page_1.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(142, 170, 219)));
    page_2.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(142, 170, 219)));
    page_3.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(142, 170, 219)));

    // 계약 내역 표 정보 가져오기
    final PdfGrid grid = getGrid(tableLabelFont, contentFont);

    // 1번 페이지 작성
    final PdfLayoutResult result = draw(page_1, pageSize, grid, titleFont,
        labelFont, tableLabelFont, contentFont);

    // 계약 내역 표 그리기
    drawGrid(page_1, grid, result);

    // 계약 일반 조건 작성(페이지1, 2, 3)
    drawContractContent_1(
        page_1, pageSize, labelFont, tableLabelFont, contentFont);
    drawContractContent_2(
        page_2, pageSize, labelFont, tableLabelFont, contentFont);
    drawContractContent_3(
        page_3, pageSize, labelFont, tableLabelFont, contentFont);

    // 마지막 계약당사자들 정보 적는 footer 작성
    drawFooter(page_3, pageSize, labelFont, tableLabelFont, contentFont);

    // 서류 저장하고
    final List<int> bytes = document.saveSync();
    // 서류 방출
    document.dispose();

    if (input == 1) {
      // 계약서 보여주기
      await saveAndLaunchFile(bytes, '광고계약서.pdf');
    } else {
      // 계약서 저장하기
      await saveFile(bytes, '광고계약서.pdf');
    }
  }

  //Draws the header////////////////////////////////////////////////////////////////////
  PdfLayoutResult draw(PdfPage page, Size pageSize, PdfGrid grid, titleFont,
      labelFont, tableLabelFont, contentFont) {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(91, 126, 215)),
        bounds: Rect.fromLTWH(0, 0, pageSize.width - 115, 70));
    //Draw string
    page.graphics.drawString('광고계약서', titleFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(25, 0, pageSize.width - 115, 70),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(400, 0, pageSize.width - 400, 70),
        brush: PdfSolidBrush(PdfColor(65, 104, 205)));

    page.graphics.drawString('계약 ID', labelFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(400, 3, pageSize.width - 400, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));

    page.graphics.drawString(
        '<${contractController.contractInfo!.contractId}>', tableLabelFont,
        brush: PdfBrushes.white,
        bounds: Rect.fromLTWH(400, 23, pageSize.width - 400, 33),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.bottom));

    page.graphics.drawString('[계약 내역]', labelFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(30, 140, pageSize.width - 45, 30),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    const String start =
        '''주식회사 [업체명](이하 “광고주”)과 주식회사 [인플루언서](이하 “수임인”)은 아래 내용과 계약조건에 의하여 계약을 체결하고 신의성실의 원칙에 따라 계약상의 의무를 이행할 것을 확약한다.''';

    return PdfTextElement(text: start, font: contentFont).draw(
        page: page, bounds: Rect.fromLTWH(30, 100, pageSize.width - 45, 50))!;
  }

  ///////////////////////////////////////////////////////////////////////////////////////

  //Draws the grid
  drawGrid(PdfPage page, PdfGrid grid, PdfLayoutResult result) {
    Rect? totalPriceCellBounds;
    Rect? quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };
    //Draw the PDF grid and get the result.
    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 50, 0, 0))!;
  }

  drawContractContent_1(
      page, pageSize, labelFont, tableLabelFont, contentFont) {
    page.graphics.drawString('[계약 일반 조건]', labelFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(30, 550, pageSize.width - 45, 30),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    String rule_1_title = '제 1 조 계약의 목적';
    String rule_1_content =
        '본 계약은 “광고주”가 의뢰한 용역을 제공함에 있어 필요한 제반 사항 및 “광고주”와 “수임인”의 권리와 의무를 규정하는데 그 목적이 있다.';
    page.graphics.drawString(rule_1_title, tableLabelFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(30, 580, pageSize.width - 45, 30),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString(rule_1_content, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(50, 610, pageSize.width - 70, 30),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    String rule_2_title = '제 2 조 계약의 변경';
    String rule_2_content =
        '본 계약의 내용을 변경하고자 할 때에는 “광고주”와 “수임인” 쌍방의 서면 합의에 의해 변경할 수 있다.';
    page.graphics.drawString(rule_2_title, tableLabelFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(30, 650, pageSize.width - 45, 30),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString(rule_2_content, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(50, 670, pageSize.width - 70, 30),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    String rule_3_title = '제 3 조 지식재산권 등';
    String rule_3_content =
        '1. 본 계약에 따라 창출되는 일체의 유무형의 정보와 저작물(용역의 결과물에 한정되지 않으며, 용역 수행과정에서 발생한 기획안, 초안 및 최종 영상, 유무형의 디자인 저작물 등을 포함. 이하 “저작물 등”이라 함)에 대한 지식재산권,';
    page.graphics.drawString(rule_3_title, tableLabelFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(30, 700, pageSize.width - 45, 30),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString(rule_3_content, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(50, 725, pageSize.width - 70, 30),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
  }

  drawContractContent_2(
      page, pageSize, labelFont, tableLabelFont, contentFont) {
    String rule_3_content_1 =
        '소유권 및 기타 일체의 권리는 “수임인”에게 있다. 기존 계약의 만료 후 상호 협의없는 “저작물 등”의 추가 활용은 불가하며, 이의 활용을 위해서는 추가 라이선스 계약이 필히 수반되어야 한다.';
    page.graphics.drawString(rule_3_content_1, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(50, 10, pageSize.width - 70, 40),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    String rule_3_content_2 =
        '2. “광고주” 또는 “수임인” 및 그 관계회사는 회사의 업무나 성과를 홍보하기 위하여 본 계약을 레퍼런스로 사용하거나, 본 계약의 목적에 위반되지 않는 범위 내에서 용역의 결과물을 이용하거나 해당 결과물을 활용하여 2차 저작물을 작성할 수 있다.';
    page.graphics.drawString(rule_3_content_2, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(50, 20, pageSize.width - 70, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    String rule_4_title = '제 4 조 용역의 범위 및 라이선스';
    page.graphics.drawString(rule_4_title, tableLabelFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(30, 70, pageSize.width - 45, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    String rule_4_content_1 =
        '1. “수임인”은 “광고주”와 상호 협의에 따라 용역 수행에 필요한 기획안을 제작 및 공유하며, “광고주”가 요청하는 특정 가이드라인이 있을 시 “수임인”은 이를 참고하여 용역을 수행한다. 단, 기획안의 수정은 상호 협의된 사항에 따라 “수임인”이 “광고주”에게 기획안을 작성 및 전달한 시점으로부터 최대 2회까지 가능하다.';
    page.graphics.drawString(rule_4_content_1, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(50, 105, pageSize.width - 70, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    String rule_4_content_2 =
        '2. "수임인”이 수행하는 용역의 특성을 고려하여 “광고주”는 전항의 확정된 기획안 또는 가이드라인을 준수하여 완성된 “저작물 등”을 제공받은 후에는 재촬영 혹은 추가촬영을 요청할 수 없으며, 1회를 초과하는 수정 및 편집 등을 요구할 수 없다. 다만, “광고주”는 녹화 및 출력파일 불량, 세부적인 길이조정, 오타 수정과 같은 부분적인 하자에 대하여는 “수임인”과 협의하여 수정할 수 있다.';
    page.graphics.drawString(rule_4_content_2, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(50, 160, pageSize.width - 70, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    String rule_4_content_3 =
        '3. “광고주”가 완성된 최종 “저작물 등”을 수령한 이후 영업일 기준 3일 이내에 “수임인”에게 이에 대한 승인 여부를 통지하지 않는 경우 전달된 최종 “저작물 등”이 승인된 것으로 간주한다(추가 수정 혹은 편집의 사유가 없음).';
    page.graphics.drawString(rule_4_content_3, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(50, 215, pageSize.width - 70, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    String rule_4_content_4 =
        '4. “광고주”가 운영 혹은 위탁하는 온라인/오프라인 매체에 상기 “저작물 등”을 소재로 활용한 유가 광고를 집행하기 위해서는(이하 “광고 활용 라이선스”라 함) 사전에 “수임인”과의 협의를 통해 라이선스를 계약 및 발급받아야 한다. “광고 활용 라이선스”의 추가 계약은 30일 단위로 진행되며, 이의 활용 범위는 3개 매체로 한정한다. 단, 상기 적시된 【계약 내역】과 내용 및 기간이 상충할 경우 【계약 내역】의 사항을 위 조에 우선한다.';
    page.graphics.drawString(rule_4_content_4, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(50, 275, pageSize.width - 70, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    String rule_4_content_5 =
        '5. “광고주”가 운영하는 홈페이지 혹은 온드미디어 계정 등의 채널에 상기 “저작물 등”을 게시하기 위해서는(이하 “공식 채널 활용 라이선스”라 함) 사전에 “수임인”과의 협의를 통해 라이선스를 계약 및 발급받아야 한다. “공식 채널 활용 라이선스”의 추가 계약은 180일 단위로 진행되며, 이의 활용 범위는 “저작물 등”이 게재된 플랫폼을 포함한 5개 매체로 한정한다(커머스 사이트에서의 활용은 불가하다). 단, 상기 적시된 【계약 내역】과 내용 및 기간이 상충할 경우 【계약 내역】의 사항을 위 조에 우선한다.';
    page.graphics.drawString(rule_4_content_5, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(50, 350, pageSize.width - 70, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    String rule_4_content_6 =
        '6.	“광고주”의 요청이 있을 시 “수임인”은 완료된 용역에 대한 자체 결과보고서를 “광고주”에게 제공한다.';
    page.graphics.drawString(rule_4_content_6, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(50, 395, pageSize.width - 70, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    String rule_5_title = '제 5 조 권리와 의무의 양도금지';
    page.graphics.drawString(rule_5_title, tableLabelFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(30, 430, pageSize.width - 45, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    String rule_5_content =
        '“수임인”은 법률이나 법원의 명령 또는 “광고주”의 사전 서면 동의없이 본 계약상 권리 및 의무의 전부 또는 일부를 제3자에게 양도하거나 담보로 제공하는 등 일체의 처분행위를 할 수 없다.';
    page.graphics.drawString(rule_5_content, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(50, 455, pageSize.width - 70, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    String rule_6_title = '제 6 조 비밀 유지 의무';
    page.graphics.drawString(rule_6_title, tableLabelFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(30, 495, pageSize.width - 45, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    String rule_6_content_1 =
        '1. “광고주”와 “수임인”은 본 계약의 이행과 관련하여 알게 된 업무상 및 영업상의 모든 정보에 대한 비밀을 본 계약기간은 물론 계약 종료 후에도 “광고주”의 서면 동의없이 제3자에게 유출하거나 본 계약 이행 이외의 목적으로 사용할 수 없다.';
    page.graphics.drawString(rule_6_content_1, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(50, 530, pageSize.width - 70, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    String rule_6_content_2 =
        '2. “광고주”와 “수임인”은 본 계약의 목적이 달성되거나 본 계약의 효력 종료 후 지체없이 본 계약과 관련하여 취득한 상대방 당사자의 일체의 정보와 자료를 반환 또는 폐기하여야 한다.';
    page.graphics.drawString(rule_6_content_2, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(50, 570, pageSize.width - 70, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    String rule_6_content_3 =
        '3. “광고주”와 “수임인”은 본 조의 규정을 위반해 “광고주”나, “수임인”, 제3자에게 손해가 발생한 경우, 이에 대한 손해를 배상하여야 한다.';
    page.graphics.drawString(rule_6_content_3, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(50, 605, pageSize.width - 70, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    String rule_7_title = '제 7 조 계약의 해제 또는 해지';
    page.graphics.drawString(rule_7_title, tableLabelFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(30, 645, pageSize.width - 45, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    String rule_7_content_1 =
        '1. “광고주” 또는 “수임인”은 상대방에게 다음 각 호의 사유가 발생한 경우, 서면으로 15일의 기간을 정하여 상대방에게 그 이행을 최고하고 그 기간 내에 이행되지 아니한 때에는 본 계약을 해제 또는 해지할 수 있다.\n가. “광고주” 또는 “수임인”이 본 계약상 의무를 위반한 경우';
    page.graphics.drawString(rule_7_content_1, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(50, 680, pageSize.width - 70, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
  }

  drawContractContent_3(
      page, pageSize, labelFont, tableLabelFont, contentFont) {
    String rule_7_content_1 =
        '나. 정당한 사유없이 본 계약사항의 이행을 지연하여 상대방의 업무에 지장을 초래하거나 납기 내에 납품(또는 검수)이 곤란하다고 인정되는 경우\n다. “광고주”가 정당한 사유없이 “수임인”에게 업무 수행에 대한 용역대가를 지불하지 않은 경우';
    page.graphics.drawString(rule_7_content_1, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(50, 0, pageSize.width - 70, 60),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    String rule_7_content_2 =
        '2. “광고주”와 “수임인”은 다음 각 호의 사유가 발생하거나 발생할 우려가 있는 경우 상대방에 대한 서면통지로써 본 계약의 전부 또는 일부를 해제 또는 해지할 수 있다.\n가.	 금융기관으로부터 거래정지처분을 받고 계약을 수행할 능력이 없다고 인정되는 경우\n나.	 감독 관청으로부터 영업취소, 정지 등의 처분을 받은 경우\n다.	 제3자에 의한 강제집행(가처분 및 가압류 포함), 파산선고 등 경영상 중대한 사유가 발생하여 본 계약상의 의무를 이행하기 어렵다고 인정되는 경우';
    page.graphics.drawString(rule_7_content_2, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(50, 50, pageSize.width - 70, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    String rule_8_title = '제 8 조 손해배상';
    page.graphics.drawString(rule_8_title, tableLabelFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(30, 120, pageSize.width - 45, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    String rule_8_content_1 =
        '1. “광고주”와 “수임인”은 본 계약을 위반하거나 고의 또는 과실로 상대방이나 제3자에게 손해를 입힌 경우, 귀책 당사자는 발생한 일체의 손해를 배상하여야 한다. 단 손해배상금은 본 계약 금액을 초과하지 않는다.';
    page.graphics.drawString(rule_8_content_1, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(50, 150, pageSize.width - 70, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    String rule_8_content_2 =
        '2. “광고주”와 “수임인”은 쌍방 모두의 귀책 또는 천재지변 등 기타 합리적인 지배범위 밖의 사유로 인하여 상대방 및 제3자에게 발생시킨 손해에 대하여 책임을 지지 아니하며, 상호 협의하여 해결한다.';
    page.graphics.drawString(rule_8_content_2, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(50, 185, pageSize.width - 70, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    String rule_8_content_3 =
        '3. “수임인”은 크리에이터의 광범위한 문제(사회적 물의, 악플 등을 의미하며 이에 한정하지 아니함)에 대해 위약금 없이 계약 취소 될 수 있다.';
    page.graphics.drawString(rule_8_content_3, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(50, 220, pageSize.width - 70, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    String rule_9_title = '제 9 조 해석 및 분쟁 해결';
    page.graphics.drawString(rule_9_title, tableLabelFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(30, 265, pageSize.width - 45, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    String rule_9_content =
        '본 계약서에 대한 쌍방의 견해가 상이한 것이 있을 경우에는 관련 법령 및 일반 상관례를 따르도록 하며, 이로 인한 분쟁의 발생시 서울중앙지방법원을 관할법원으로 한다.';
    page.graphics.drawString(rule_9_content, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(50, 295, pageSize.width - 70, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
  }

  //Draw the invoice footer data.
  void drawFooter(
      PdfPage page, Size pageSize, labelFont, tableLabelFont, contentFont) {
    final PdfPen linePen =
        PdfPen(PdfColor(142, 170, 219), dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - 350),
        Offset(pageSize.width, pageSize.height - 350));

    page.graphics.drawString(
        'ㅡ  ${DateFormat('yyyy.MM.dd').format(DateTime.now())}  ㅡ', contentFont,
        format: PdfStringFormat(alignment: PdfTextAlignment.center),
        bounds: Rect.fromLTWH(0, pageSize.height - 320, pageSize.width, 0));

// 광고주 정보 적는 란
    String advertiserTitle_1 = '[ 광 고 주 ]';
    page.graphics.drawString(advertiserTitle_1, tableLabelFont,
        brush: PdfBrushes.black,
        bounds:
            Rect.fromLTWH(70, pageSize.height - 310, pageSize.width - 200, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    String advertiserTitle_2 = '회  사  명 :\n등록번호 :\n주\t\t소 : \n대  표  자 :';
    page.graphics.drawString(advertiserTitle_2, contentFont,
        brush: PdfBrushes.black,
        bounds:
            Rect.fromLTWH(70, pageSize.height - 270, pageSize.width - 200, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    String advertiserSignature = '(광고주 서명)';
    page.graphics.drawString(advertiserSignature, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(
            400, pageSize.height - 250, pageSize.width - 200, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    String advertiserContent_2 =
        '${contractController.contractInfo!.advertiserInfo!.companyName}\n${contractController.contractInfo!.advertiserInfo!.regNum}\n${contractController.contractInfo!.advertiserInfo!.advertiserAddress}\n${contractController.contractInfo!.advertiserInfo!.representativeName}';
    page.graphics.drawString(advertiserContent_2, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(
            120, pageSize.height - 270, pageSize.width - 200, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    // 여기에 서명 그려야 함////////////////////////////////
    String advertiserSignaturePicture = '(광고주 서명)';
    page.graphics.drawString(advertiserSignaturePicture, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(
            400, pageSize.height - 250, pageSize.width - 200, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

// 수임인 정보 적는 란
    String clouterTitle_1 = '[ 수 임 인 ]';
    page.graphics.drawString(clouterTitle_1, tableLabelFont,
        brush: PdfBrushes.black,
        bounds:
            Rect.fromLTWH(70, pageSize.height - 210, pageSize.width - 200, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    String clouterTitle_2 = '이\t\t\t\t름 :\n주민등록번호 :\n주\t\t\t\t소 : \n';
    page.graphics.drawString(clouterTitle_2, contentFont,
        brush: PdfBrushes.black,
        bounds:
            Rect.fromLTWH(70, pageSize.height - 175, pageSize.width - 200, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    String clouterSignature = '(수임인 서명)';
    page.graphics.drawString(clouterSignature, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(
            400, pageSize.height - 165, pageSize.width - 200, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    String clouterContent_2 =
        '${contractController.contractInfo!.clouterInfo!.clouterName}\n${contractController.contractInfo!.clouterInfo!.residentRegistrationNumber}\n${contractController.contractInfo!.clouterInfo!.clouterAddress}\n';
    page.graphics.drawString(clouterContent_2, contentFont,
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(
            140, pageSize.height - 175, pageSize.width - 200, 100),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    // 여기에 서명 그려야 함////////////////////////////////
    if (contractController.signature != null) {
      page.graphics.drawImage(PdfBitmap(contractController.signature),
          Rect.fromLTWH(380, pageSize.height - 155, pageSize.width - 420, 80));
    }
  }

  //Create PDF grid and return
  PdfGrid getGrid(tableLabelFont, contentFont) {
    //Create a PDF grid
    final PdfGrid grid = PdfGrid();
    //Secify the columns count to the grid.
    grid.columns.add(count: 2);
    //Create the header row of the grid.

    //Add rows
    addColumn('계약건명', contractController.contractInfo!.name!, grid);
    addColumn('브랜드',
        contractController.contractInfo!.advertiserInfo!.companyName!, grid);
    addColumn('계약 금액',
        '${contractController.contractInfo!.price!.toString()}포인트', grid);
    addColumn(
        '계약 기간',
        '계약 체결일로부터 ${contractController.contractInfo!.contractExpiration}개월까지',
        grid);
    addColumn('게시 마감일',
        '계약 체결일로부터 ${contractController.contractInfo!.postDeadline}일 이내', grid);
    addColumn('용역 수행 내역', contractController.contractInfo!.contents!, grid);

    grid.applyBuiltInStyle(PdfGridBuiltInStyle.gridTable3Accent1);

    grid.columns[1].width = 400;

    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        cell.style = PdfGridCellStyle(font: contentFont);
        if (j == 0) {
          cell.stringFormat.alignment = PdfTextAlignment.center;
          cell.style = PdfGridCellStyle(font: tableLabelFont);
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
      }
    }
    return grid;
  }

  void addColumn(String title, String content, PdfGrid grid) {
    final PdfGridRow row = grid.rows.add();
    row.cells[0].value = title;
    row.cells[1].value = content;
  }
}
