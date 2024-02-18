//
//  Policy3ViewController.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 2/10/24.
//

import Foundation
import UIKit

class Policy3ViewController : UIViewController {
    weak var delegate : buttonChecked2?
    
    let scrollView : UIScrollView = UIScrollView()
    let contentView : UIView! = UIView()
    
    private let mainLabel1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let text =
"""
제1조 (목적)
본 약관은 회원(본 약관에 동의한 자를 말합니다. 이하 “회원”이라고 합니다)이 Homeat(홈잇) (이하 “회사”라고 합니다)가 제공하는 위치기반서비스(이하 “서비스”라고 합니다)를 이용함에 있어 회사와 회원의 권리・의무 및 책임사항을 규정함을 목적으로 합니다.

제2조 (약관의 효력 및 변경)
1.  본 약관은 서비스를 신청한 고객 또는 개인위치정보주체가 본 약관에 동의하고 회사가 정한 소정의 절차에 따라 서비스의 이용자로 등록함으로써 효력이 발생합니다.
2.  회사는 본 약관의 내용을 회원이 쉽게 알 수 있도록 서비스 초기 화면에 게시하거나 기타의 방법으로 공지합니다.
3.  회사는 필요하다고 인정되면 본 약관을 변경할 수 있으며, 회사가 약관을 개정할 경우에는 기존약관과 개정약관 및 개정약관의 적용일자와 개정사유를 명시하여 현행약관과 함께 그 적용일자 7일 전부터 적용일 이후 상당한 기간 동안 공지합니다. 다만, 개정 내용이 회원에게 불리한 경우에는 그 적용일자 30일 전부터 적용일 이후 상당한 기간 동안 각각 이를 서비스 홈페이지에 게시하여 고지합니다.
4.  회사가 전항에 따라 회원에게 공지하거나 통지하면서 공지 또는 통지ㆍ고지일로부터 개정약관 시행일 7일 후까지 거부의사를 표시하지 아니하면 승인한 것으로 본다는 뜻을 명확하게 고지하였음에도 불구하고 거부의 의사표시가 없는 경우에는 변경된 약관에 승인한 것으로 봅니다. 회원이 개정약관에 동의하지 않을 경우 회원은 이용계약을 해지할 수 있습니다.

제3조 (약관 외 준칙)
본 약관에 규정되지 않은 사항에 대해서는 위치정보의 보호 및 이용 등에 관한 법률(이하 “위치정보법”이라고 합니다), 전기통신사업법, 정보통신망 이용촉진 및 보호 등에 관한 법률(이하 “정보통신망법”이라고 합니다), 개인정보보호법 등 관련법령 또는 회사가 정한 서비스의 운영정책 및 규칙 등(이하 “세부지침”이라고 합니다)의 규정에 따릅니다.

제4조 (서비스의 가입)
1.  회원은 본 약관에 동의하고 서비스에 가입신청함으로써 서비스의 이용자가 될 수 있습니다.
2.  회사는 아래와 같은 경우 회원의 서비스 가입신청에 대한 승낙을 유보할 수 있습니다.
•   실명이 아니거나 다른 사람의 명의를 사용하는 등 허위로 신청하는 경우
•   회원 등록 사항을 빠뜨리거나 잘못 기재하여 신청하는 경우
•   기타 회사가 정한 이용신청 요건을 충족하지 않았을 경우

제5조 (서비스의 해지)
회원이 서비스 이용을 해지하고자 할 경우 회원은 회사가 정한 절차(서비스 홈페이지 등을 통해 공지합니다)를 통해 서비스 해지를 신청할 수 있으며, 회사는 법령이 정하는 바에 따라 신속히 처리합니다.

제6조 (서비스의 내용)
1.  서비스의 이용은 연중무휴 1일 24시간을 원칙으로 합니다. 단, 회사의 업무 또는 기술상의 이유로 서비스가 일시 중지될 수 있으며, 운영상의 목적으로 회사가 정한 기간에도 서비스는 일시 중지될 수 있습니다. 이때 회사는 사전 또는 사후에 이를 공지합니다.
2.  회사는 단말기의 설정 상태에 따라, 회원이 앱을 구동 내지 사용하는 특정 시점 혹은 회원이 앱 내 특정 서비스를 활성화하거나 동네인증 등의 액션을 하는 시점에, 위치정보사업자로부터 위치정보를 위경도 좌표의 형식으로 직접 전달받거나, 특정 게시물 또는 이용자가 저장하는 콘텐츠에 포함된 위치정보를 수집할 수 있습니다. 회사는 해당 위치정보를 사전에 정의된 특정 구역 단위 혹은 특정 행정동 단위에 속하는지 여부에 대한 값으로 변환할 수 있습니다.
3.  회사가 이러한 위치정보를 토대로 제공하는 서비스의 종류와 내용은 아래와 같습니다. 다만 회사는 경영상, 사업상 이유 등으로 아래 예시한 서비스 중 일부를 중단 내지 변경할 수 있으며, 이에 대해서는 관련 법령 및 본 약관이 정하는 바에 따라 조치하겠습니다.
1) 서비스 명
동네 인증
2) 서비스 목적 및 내용
•   회원의 위치가 특정 구역 내지 행정동 단위에 속하는지 여부를 확인하여 ‘내 동네’ 인증
•   예시 : 인증된 ‘내 동네’를 바탕으로 동네 정보 공유 서비스 제공 등
3) 보유 기간
관련 법령 및 제5항이 정하는 바에 의함

1) 서비스 명
서비스 이용 편의 제공
2) 서비스 목적 및 내용
•   회원의 위치정보를 지도 서비스에 표시하여, 서비스 이용의 편의성 증진
•   예시: 동네가게 거리 및 정보 확인, 기타 지도 연동 서비스 이용 시, 회원의 위치정보에 기반한 서비스 편의 제공 등
•   회원의 위치정보를 활용하여 게시글 검색이나 작성, 등록에 있어 추천 내지 자동완성 등 서비스 이용의 편의성 증진
•   이용자가 게시하는 콘텐츠에 포함된 위치정보를 추출 및 활용하여, 장소 등록이나 후기를 비롯한 각종 게시글 작성시 추천 내지 자동완성 기능을 제공함으로써 서비스 편의 제공 등
3) 보유 기간
관련 법령 및 제5항이 정하는 바에 의함

1) 서비스 명
서비스 내 콘텐츠 제공 내지 추천
2) 서비스 목적 및 내용
•   회원의 위치정보 혹은 이것이 특정 구역 내지 행정동 단위에 속하는지 여부를 기반으로, 앱 내 다양한 콘텐츠 제공 내지 추천에 활용
•   예시 : 커뮤니티 관련 근거리 정보 제공, 커뮤니티 관련 근거리 콘텐츠 추천, 기타 검색결과 내지 광고성 소재 추천에 활용 등
3) 보유 기간
관련 법령 및 제 5항이 정하는 바에 의함

1) 서비스 명
서비스 제공 내용 고도화
2) 서비스 목적 및 내용
회원의 위치정보에 대한 통계적 분석을 통해, 관심 지역, 활동 구역, 추정 경로 등을 정의하고, 이를 토대로 검색, 추천, 콘텐츠 표시 등 각종 응용 서비스 제공 및 고도화
3) 보유 기간
관련 법령 및 제 5항이 정하는 바에 의함
4.  회사는 위치정보의 보호 및 이용 등에 관한 법률 제16조 제2항에 따라 위치정보 수집∙이용∙제공 사실 확인자료를 위치정보시스템에 자동으로 기록, 보존하여, 해당 자료는 6개월 이상 보관합니다.
5.  회사는 개인위치정보의 수집, 이용 또는 제공 목적을 달성하거나, 서비스를 종료하거나, 고객이 회원 탈퇴 등의 방법으로 개인위치정보의 이용에 대한 동의를 철회하는 때에는 당해 개인위치정보를 지체 없이 파기합니다. 다만, 위치정보의 보호 및 이용 등에 관한 법률에 달리 정함이 있거나 다른 법률에 의한 보관이 필요한 경우 해당 기간만큼 보관합니다.

제7조 (서비스 이용요금)
1.  회사가 제공하는 서비스는 기본적으로 무료입니다.
2.  무선서비스 이용 시 발생하는 데이터 통신료는 별도이며, 회원이 가입한 각 이동통신사의 정책에 따릅니다.
3.  MMS 등으로 게시물을 등록할 경우 발생하는 요금은 회원이 가입한 각 이동통신사의 정책에 따릅니다.

제8조 (서비스의 이용제한 및 중지)
1.  회사는 아래 각 호의 경우에는 회원의 서비스 이용을 제한하거나 중지시킬 수 있습니다.
a.  회원이 회사 서비스의 운영을 고의 또는 중과실로 방해하는 경우
b.  서비스용 설비 점검, 보수 또는 공사로 인하여 부득이한 경우
c.  전기통신사업법에 규정된 기간통신사업자가 전기통신 서비스를 중지했을 경우
d.  국가비상사태, 서비스 설비의 장애 또는 서비스 이용의 폭주 등으로 서비스 이용에 지장이 있는 때
e.  기타 중대한 사유로 인하여 회사가 서비스 제공을 지속하는 것이 부적당하다고 인정하는 경우
2.  회사는 전항의 규정에 의하여 서비스의 이용을 제한하거나 중지한 때에는 그 사유 및 제한기간 등을 회원에게 알려야 합니다.

제9조 (서비스내용변경 통지 등)
1.  회사가 서비스 내용을 변경하거나 종료하는 경우 회사는 회원의 등록된 휴대폰 번호 문자 방식으로 서비스 내용의 변경 사항 또는 종료를 통지할 수 있습니다.
2.  전항의 경우 불특정 다수인을 상대로 통지를 함에 있어서는 서비스 홈페이지 등 기타 회사의 공지사항 페이지를 통하여 회원들에게 통지할 수 있습니다. 단, 회원 본인의 거래와 관련하여 중대한 영향을 미치는 사항은 상당한 기간 동안 서비스 홈페이지에 게시하거나 회원에게 전자적 형태(전자우편, SMS 등)로 개별통지 합니다.

제10조 (개인위치정보의 이용 또는 제공)
1.  회사는 개인위치정보를 이용하여 서비스를 제공하고자 하는 경우에는 미리 약관에 명시한 후 개인위치정보주체의 동의를 얻어야 합니다.
2.  회사는 개인위치정보를 회원이 지정하는 제3자에게 제공하는 경우에는 제공받는 자 및 제공목적을 사전에 회원에게 고지하고 동의를 받습니다.
3.  제2항에 따라 개인위치정보를 회원이 지정하는 제3자에게 제공하는 경우에는 개인위치정보를 수집한 해당 통신 단말장치 또는 전자우편주소 등으로 매회 회원에게 제공받는 자, 제공일시 및 제공목적(이하 “정보제공내역”이라 합니다)을 즉시 통보합니다.
4.  단, 아래 각 호에 해당하는 경우에는 회원이 미리 특정하여 지정한 통신단말장치 또는 전자우편주소 등으로 통보합니다.
a.  개인위치정보를 수집한 해당 통신단말장치가 문자, 음성 또는 영상의 수신기능을 갖추지 아니한 경우
b.  회원이 개인위치정보를 수집한 해당 통신단말장치 외의 통신단말장치 또는 전자우편주소 등으로 통보할 것을 미리 요청한 경우
5.  제3항에도 불구하고 회원은 위치정보법 시행령 제24조에 따라 정보제공내역을 30일씩 모아서 통보받는 방법을 선택할 수 있으며, 회원이 회사의 절차에 따라 요청할 경우 전항에 따른 즉시 통보 방법으로 변경할 수 있습니다.
6.  회원은 제1항, 제2항 및 제5항에 따른 동의를 하는 경우 이용∙제공목적, 제공받는 자의 범위 및 위치기반서비스 이용약관의 내용 중 일부와 회원의 개인위치정보에 대한 제3자 제공의 경우 통보방법에 대하여 동의를 유보할 수 있습니다.
7.  회사는 회원의 동의가 있거나 다음 각 호의 어느 하나에 해당하는 경우를 제외하고는 개인위치정보 또는 위치정보 이용∙제공사실 확인자료를 이용약관에 명시 또는 고지한 범위를 넘어 이용하거나 제3자에게 제공할 수 없습니다.
a.  위치기반서비스의 제공에 따른 요금정산을 위하여 위치정보 이용∙제공사실 확인자료가 필요한 경우
b.  통계작성, 학술연구 또는 시장조사를 위하여 특정 개인을 알아볼 수 없는 형태로 가공하여 제공하는 경우

제11조 (개인위치정보주체의 권리)
1.  회원은 회사에 대하여 언제든지 개인위치정보를 이용한 위치기반서비스 제공 및 개인위치정보의 제3자 제공에 대한 동의의 전부 또는 일부를 철회할 수 있습니다. 이 경우 회사는 수집한 개인위치정보 및 위치정보 이용, 제공사실 확인자료를 파기합니다.
2.  회원은 회사에 대하여 언제든지 개인위치정보의 수집, 이용 또는 제공의 일시적인 중지를 요구할 수 있으며, 회사는 이를 거절할 수 없고 이를 위한 기술적 수단을 갖추고 있습니다.
3.  회원은 회사에 대하여 아래 각 호의 자료에 대한 열람 또는 고지를 요구할 수 있고, 당해 자료에 오류가 있는 경우에는 그 정정을 요구할 수 있습니다. 이 경우 회사는 정당한 사유 없이 회원의 요구를 거절할 수 없습니다.
a.  본인에 대한 위치정보 수집, 이용, 제공사실 확인자료
b.  본인의 개인위치정보가 위치정보의 보호 및 이용 등에 관한 법률 또는 다른 법률 규정에 의하여 제3자에게 제공된 이유 및 내용
4.  회원은 제1항 내지 제3항의 권리행사를 위해 회사의 소정의 절차를 통해 요구할 수 있습니다.

제12조 (법정대리인의 권리)
1.  회사는 14세 미만의 회원에 대해서는 개인위치정보를 이용한 위치기반서비스 제공 및 개인위치정보의 제3자 제공에 대한 동의를 당해 회원과 당해 회원의 법정대리인으로부터 동의를 받아야 합니다. 이 경우 법정대리인은 제11조에 의한 회원의 권리를 모두 가집니다.
2.  회사는 14세 미만의 아동의 개인위치정보 또는 위치정보 이용, 제공사실 확인자료를 이용약관에 명시 또는 고지한 범위를 넘어 이용하거나 제3자에게 제공하고자 하는 경우에는 14세 미만의 아동과 그 법정대리인의 동의를 받아야 합니다. 단, 아래의 경우는 제외합니다.
a.  위치정보 및 위치기반서비스 제공에 따른 요금정산을 위하여 위치정보 이용, 제공사실 확인자료가 필요한 경우
b.  통계작성, 학술연구 또는 시장조사를 위하여 특정 개인을 알아볼 수 없는 형태로 가공하여 제공하는 경우

제13조 (8세 이하의 아동 등의 보호의무자의 권리)
1.  전 조에도 불구하고, 아래의 경우에 해당하는 자(이하 “8세 이하 아동 등”)의 보호의무자가 8세 이하의 아동 등의 생명 또는 신체보호를 위하여 개인위치정보의 이용 또는 제공에 동의하는 경우에는 본인의 동의가 있는 것으로 봅니다.
•   8세 이하의 아동
•   피성년후견인
•   장애인복지법 제2조 제2항 제2호의 규정에 따른 정신적 장애를 가진 자로서 장애인 고용촉진 및 직업재활법 제2조 제2호의 규정에 따라 중증장애인에 해당하는 자(장애인복지법 제32조의 규정에 따라 장애인등록을 한 자에 한합니다)
2.  전항의 규정에 따른 8세 이하 아동 등의 보호의무자는 해당 아동을 사실상 보호하는 자로서 다음 각 호에 해당하는 자를 말합니다.
•   8세 이하의 아동의 법정대리인 또는 보호시설에 있는 미성년자의 후견 직무에 관한 법률 제3조의 규정에 따른 후견인
•   피성년후견인의 법정대리인
•   본 조 제1항 제3호의 자의 법정대리인 또는 장애인복지법 제58조 제1항 제1호의 규정에 따른 장애인생활시설(국가 또는 지방자치단체가 설치·운영하는 시설에 한합니다)의 장, 정신보건법 제3조 제4호의 규정에 따른 정신질환자 사회복귀시설(국가 또는 지방자치단체가 설치·운영하는 시설에 한합니다)의 장, 동법 동조 제5호의 규정에 따른 정신요양시설의 장
3.  8세 이하의 아동 등의 생명 또는 신체의 보호를 위하여 개인위치정보의 이용 또는 제공에 동의를 하고자 하는 보호의무자는 서면동의서에 보호의무자임을 증명하는 서면을 첨부하여 회사에 제출하여야 합니다.
4.  보호의무자는 8세 이하의 아동 등의 개인위치정보 이용 또는 제공에 동의하는 경우 개인위치정보주체 권리의 전부를 행사할 수 있습니다.

제14조 (양도금지)
회원의 서비스 받을 권리는 이를 양도 내지 증여하거나 담보제공 등의 목적으로 처분할 수 없습니다.

제15조 (손해배상)
1.  회사가 위치정보법 제15조 내지 제26조의 규정을 위반한 행위로 회원에게 손해가 발생한 경우 회원은 회사에 대하여 손해배상 청구를 할 수 있습니다. 이 경우 회사는 고의, 과실이 없음을 입증하지 못하는 경우 책임을 면할 수 없습니다.
2.  회사가 위치정보법 제15조 내지 제26조의 규정을 위반한 행위로 회원에게 손해가 발생한 경우 회원은 회사에 대하여 손해배상 청구를 할 수 있습니다. 이 경우 회사는 고의, 과실이 없음을 입증하지 못하는 경우 책임을 면할 수 없습니다.

제16조 (면책)
1.  회사는 다음 각 호의 경우로 서비스를 제공할 수 없는 경우 이로 인하여 회원에게 발생한 손해에 대해서는 책임을 부담하지 않습니다.
a.  천재지변 또는 이에 준하는 불가항력의 상태가 있는 경우
b.  서비스 제공을 위하여 회사와 서비스 제휴계약을 체결한 제3자의 고의적인 서비스 방해가 있는 경우
c.  회원의 귀책사유로 서비스 이용에 장애가 있는 경우4) 제1호 내지 제3호를 제외한 기타 회사의 고의ㆍ과실이 없는 사유로 인한 경우
2.  회사는 서비스 및 서비스에 게재된 정보, 자료, 사실의 신뢰도, 정확성 등에 대해서는 보증을 하지 않으며 이로 인해 발생한 회원의 손해에 대하여는 책임을 부담하지 아니합니다.

제17조 (분쟁의 조정 및 기타)
1.  서비스 이용과 관련하여 회사와 회원 간에 분쟁이 발생하면, 회사는 분쟁의 해결을 위해 회원과 성실히 협의합니다.
2.  전항의 협의에서 분쟁이 해결되지 않은 경우 회사와 회원은 위치정보법 제28조에 의한 방송통신위원회에 재정을 신청하거나, 개인정보보호법 제43조에 의한 방송통신위원회 또는 개인정보분쟁조정위원회에 재정 또는 분쟁조정을 신청할 수 있습니다.
3.  전항으로도 분쟁이 해결되지 않으면 회사와 회원 양 당사자는 민사소송법상의 관할법원에 소를 제기할 수 있습니다.

부칙
제1조 (시행일) 본 약관은 2024년 2월 20일부터 시행합니다.

"""
        
        let attributedString = NSMutableAttributedString(string: text)
        
        label.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        
        let ranges: [NSRange] = [
            (text as NSString).range(of: "제1조 (목적)"),
            (text as NSString).range(of: "제2조 (약관의 효력 및 변경)"),
            (text as NSString).range(of: "제3조 (약관 외 준칙)"),
            (text as NSString).range(of: "제4조 (서비스의 가입)"),
            (text as NSString).range(of: "제5조 (서비스의 해지)"),
            (text as NSString).range(of: "제6조 (서비스의 내용)"),
            (text as NSString).range(of: "제7조 (서비스 이용요금)"),
            (text as NSString).range(of: "제8조 (서비스의 이용제한 및 중지)"),
            (text as NSString).range(of: "제9조 (서비스내용변경 통지 등)"),
            (text as NSString).range(of: "제10조 (개인위치정보의 이용 또는 제공)"),
            (text as NSString).range(of: "제11조 (개인위치정보주체의 권리)"),
            (text as NSString).range(of: "제12조 (법정대리인의 권리)"),
            (text as NSString).range(of: "제13조 (8세 이하의 아동 등의 보호의무자의 권리)"),
            (text as NSString).range(of: "제14조 (양도금지)"),
            (text as NSString).range(of: "제15조 (손해배상)"),
            (text as NSString).range(of: "제16조 (면책)"),
            (text as NSString).range(of: "제17조 (분쟁의 조정 및 기타)"),
            (text as NSString).range(of: "부칙"),
            
        ]

        for range in ranges {
            attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 12, weight: .bold), range: range)
        }
        

        label.attributedText = attributedString
        label.backgroundColor = UIColor(named: "gray2")
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let mainLabel : UILabel = {
        let label = UILabel()
        label.text = "위치기반 정보 수집 동의"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.backgroundColor = UIColor(named: "gray2")
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var closeButton : UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "closeIcon")
        config.background.backgroundColor = UIColor(named: "gray2")
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let buttonAction = UIAction{ _ in
            self.dismiss(animated: true, completion: nil)
        }
        
        let button = UIButton(configuration: config, primaryAction: buttonAction )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var continueButton : UIButton = {
         var config = UIButton.Configuration.plain()
         var attributedTitle = AttributedString("동의하고 가입하기")
         attributedTitle.font = .systemFont(ofSize: 18, weight: .medium)
         config.attributedTitle = attributedTitle
         config.cornerStyle = .small
         config.background.backgroundColor = UIColor(named: "green")
         config.baseForegroundColor = .black
         
         let buttonAction = UIAction{ _ in
             
             self.delegate?.buttonChecked2()
             self.dismiss(animated: true, completion: nil)
         }
         
         let button = UIButton(configuration: config, primaryAction: buttonAction )
         
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let _ = continueButton
        self.view.backgroundColor = UIColor(named: "gray2")
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
        
        contentView.addSubview(mainLabel1)
        contentView.addSubview(continueButton)
        contentView.addSubview(mainLabel)
        contentView.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
        ])
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            mainLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            closeButton.topAnchor.constraint(equalTo: mainLabel.topAnchor),
//            closeButton.leadingAnchor.constraint(equalTo: mainLabel.trailingAnchor, constant: 64),
            closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            
            mainLabel1.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 38),
            mainLabel1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mainLabel1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            mainLabel1.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100),
            
            continueButton.topAnchor.constraint(equalTo: mainLabel1.bottomAnchor, constant: 50),
            continueButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            continueButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 57),
            
        ])
    }
    

    
    
}


protocol buttonChecked2 : AnyObject{
    func buttonChecked2()
}
