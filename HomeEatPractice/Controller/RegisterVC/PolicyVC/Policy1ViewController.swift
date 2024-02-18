//
//  Policy1ViewController.swift
//  HomeEatPractice
//
//  Created by 강삼고 on 2/10/24.
//

import Foundation
import UIKit

class Policy1ViewController : UIViewController {
    
    weak var delegate : buttonChecked?
    
    let scrollView : UIScrollView = UIScrollView()
    let contentView : UIView! = UIView()
    
    private let mainLabel1 : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let text =
"""
안녕하세요?

Homeat (이하 “홈잇”이라고 합니다) 서비스를 이용해 주셔서 감사합니다. 챌린지형 식비관리 서비스를 제공하는 홈잇이 아래 준비한 약관을 읽어주시면 감사드리겠습니다.

계정 관련

홈잇은 모바일 서비스 특성상 별다른 이메일 확인 없이 비밀번호 입력으로 계정을 생성하실 수 있습니다. 다만, 실제 이메일 사용자임을 확인하기 위해서 가입 당시 인증 절차를 거치게 됩니다. 또한, 다른 모바일 기기에서 서비스 사용을 연속하기 위해서는 기존에 가입하고 인증했던 이메일로 재인증을 해야 합니다. 아래의 경우에는 계정 생성을 승인하지 않을 수 있습니다.

1.  다른 사람의 명의나 이메일 등 개인정보를 이용하여 계정을 생성하려 한 경우
2.  동일인이 다수의 계정을 생성하려 한 경우
3.  계정 생성시 필요한 정보를 입력하지 않거나 허위 정보를 입력한 경우
4.  홈잇이 과거에 운영원칙 또는 법률 위반 등의 정당한 사유로 해당 계정을 삭제 또는 징계한 경우
5.  사기 정보 모음 사이트나 정부기관 사이트 등에서 거래 사기 이력이 있는 이메일로 확인된 경우

계정은 본인만 이용할 수 있고, 다른 사람에게 이용을 허락하거나 양도할 수 없습니다. 사용자는 계정과 관련된 정보, 즉 프로필 사진이나 닉네임 등을 수정할 수 있습니다. 이메일이 바뀐 경우에는 서비스 내 설정 메뉴나 고객센터 문의를 통해 새 이메일로 인증절차를 걸쳐 수정할 수 있습니다.

사용시 주의해야 할 점

홈잇은 사용자가 아래와 같이 잘못된 방법이나 행위로 서비스를 이용할 경우 사용에 대한 제재(이용정지, 강제탈퇴 등)를 가할 수 있습니다.

1.  잘못된 방법으로 서비스의 제공을 방해하거나 홈잇이 안내하는 방법 이외의 다른 방법을 사용하여 홈잇 서비스에 접근하는 행위
2.  다른 이용자의 정보를 무단으로 수집, 이용하거나 다른 사람들에게 제공하는 행위
3.  서비스를 영리나 홍보 목적으로 이용하는 행위
4.  음란 정보나 저작권 침해 정보 등 공서양속 및 법령에 위반되는 내용의 정보 등을 발송하거나 게시하는 행위
5.  홈잇의 동의 없이 홈잇의 서비스 또는 이에 포함된 소프트웨어의 일부를 복사, 수정, 배포, 판매, 양도, 대여, 담보제공하거나 타인에게 그 이용을 허락하는 행위
6.  소프트웨어를 역설계하거나 소스 코드의 추출을 시도하는 등 홈잇 서비스를 복제, 분해 또는 모방하거나 기타 변형하는 행위
7.  관련 법령, 홈잇의 모든 약관 또는 운영정책을 준수하지 않는 행위

개인정보 보호 관련

개인정보는 홈잇 서비스의 원활한 제공을 위하여 사용자가 동의한 목적과 범위 내에서만 이용됩니다. 개인정보 보호 관련 기타 상세한 사항은 개인정보처리방침을 참고하시기 바랍니다.

게시물의 저작권 보호

1.  홈잇 서비스 사용자가 서비스 내에 게시한 게시물의 저작권은 해당 게시물의 저작자에게 귀속됩니다.
2.  사용자가 서비스 내에 게시하는 게시물은 검색결과 내지 서비스 및 관련 프로모션, 광고 등에 노출될 수 있으며, 해당 노출을 위해 필요한 범위 내에서는 일부 수정, 복제, 편집되어 게시될 수 있습니다. 이 경우, 홈잇은 저작권법 규정을 준수하며, 사용자는 언제든지 고객센터 또는 운영자 문의 기능을 통해 해당 게시물에 대해 삭제, 검색결과 제외, 비공개 등의 조치를 요청할 수 있습니다.
3.  위 2항 이외의 방법으로 사용자의 게시물을 이용하고자 하는 경우에는 전화, 팩스, 전자우편 등을 통해 사전에 사용자의 동의를 얻어야 합니다.

게시물의 관리

1.  사용자의 게시물이 "정보통신망법" 및 "저작권법"등 관련법에 위반되는 내용을 포함하는 경우, 권리자는 관련법이 정한 절차에 따라 해당 게시물의 게시중단 및 삭제 등을 요청할 수 있으며, 홈잇은 관련법에 따라 조치를 취하여야 합니다.
2.  홈잇은 전항에 따른 권리자의 요청이 없는 경우라도 권리침해가 인정될 만한 사유가 있거나 기타 회사 정책 및 관련법에 위반되는 경우에는 관련법에 따라 해당 게시물에 대해 임시조치(삭제, 노출제한, 게시중단) 등을 취할 수 있습니다.
3.  홈잇은 사용자의 게시글 및 채팅 내용을 저장, 보관할 수 있고, 서비스 내 민원 및 분쟁 조정, 질서 유지 개선, 기타 법령 또는 본 약관 위반 여부를 확인 내지 처리하기 위하여 필요한 경우에 한해서만 해당 정보를 열람할 수 있습니다. 홈잇은 법령에서 정한 경우 외에는 이를 제3자에게 제공하지 아니하며, 서비스 내 민원 및 분쟁 조정을 위한 열람시 사용자에게 그 사유 및 범위를 고지할 수 있습니다.

사용권리

홈잇은 서비스 이용을 위하여 양도불가능하고 무상의 라이선스를 사용자분들에게 제공합니다. 다만, 홈잇 상표 및 로고를 사용할 권리를 사용자분들에게 부여하는 것은 아닙니다.

서비스 고지 및 홍보내용 표시

홈잇은 서비스 사용자분의 편의를 위해 서비스 이용과 관련된 각종 고지 및 기타 홈잇 서비스 홍보를 포함한 다양한 정보를 홈잇 서비스에 표시하거나 사용자의 휴대폰 문자, 알림 메시지(Push Notification) 등으로 발송할 수 있으며 서비스 사용자분은 이에 동의합니다. 이 경우 서비스 사용자분의 통신환경 또는 요금구조에 따라 서비스 사용자분이 데이터 요금 등을 부담할 수 있습니다. 한편 홈잇은 서비스 사용자분이 수집에 동의한 서비스 내 활동 정보를 기초로 홈잇에게 직접적인 수익이 발생하지 않거나 홈잇이 판매하는 상품과 직접적인 관련성이 없는 한도에서 다른 서비스 사용자분 등이 판매하는 상품 또는 서비스에 관한 정보를 위와 같은 방법으로 서비스 사용자분에게 보낼 수 있으며 서비스 사용자분은 이에 동의합니다. 물론 서비스 사용자분은 관련 법령상 필요한 내용을 제외하고 언제든지 이러한 정보에 대한 수신 거절을 할 수 있으며, 이 경우 홈잇은 즉시 위와 같은 정보를 보내는 것을 중단합니다.

위치기반서비스 관련

홈잇은 사용자의 실생활에 더욱 보탬이 되는 유용한 서비스를 제공하기 위하여 홈잇 서비스에 위치기반서비스를 포함시킬 수 있습니다. 홈잇의 위치기반서비스는 사용자의 단말기기의 위치정보를 수집하는 위치정보사업자로부터 위치정보를 전달받아 제공하는 무료서비스이며, 구체적으로는 사용자의 현재 위치를 기준으로 특정 지역커뮤니티에 가입자격을 부여하고 다른 이용자와 해당 지역과 관련된 게시물을 작성할 수 있도록 하는 서비스(지역커뮤니티서비스), 사용자의 현재 위치를 이용한 생활 정보나 광고성 정보를 제공하는 서비스(정보제공서비스)가 있습니다. 특히, 사용자가 14세 미만 이용자로서 개인위치정보를 활용한 위치기반 서비스를 이용하기 위해서는 홈잇은 사용자의 개인위치정보를 이용 또는 제공하게 되며, 이 경우 부모님 등 법정대리인의 동의가 먼저 있어야 합니다. 만약 법정대리인의 동의 없이 위치기반서비스가 이용된 것으로 판명된 때에는 홈잇은 즉시 사용자의 위치기반서비스 이용을 중단하는 등 적절한 제한을 할 수 있습니다.

사용자(14세 미만 이용자의 법정대리인 포함)는 홈잇 서비스와 관련된 개인위치정보의 이용, 제공 목적, 제공받는 자의 범위 및 위치기반서비스의 일부에 대하여 동의를 유보하거나, 이용∙제공에 대한 동의의 전부 또는 일부 철회할 수 있으며, 일시적인 중지를 요구할 수 있습니다. 홈잇은 위치정보의 보호 및 이용 등에 관한 법률의 규정에 따라 개인위치정보 및 위치정보 이용∙제공사실 확인자료를 6개월 이상 보관하며, 사용자가 동의의 전부 또는 일부를 철회한 때에는 홈잇은 철회한 부분에 해당하는 개인위치정보 및 위치정보 이용∙제공사실 확인자료를 지체 없이 파기하겠습니다.

사용자(14세 미만 이용자의 법정대리인 포함)는 홈잇에 대하여 사용자에 대한 위치정보 이용∙제공사실 확인자료나, 사용자의 개인위치정보가 법령에 의하여 제3자에게 제공되었을 때에는 그 이유 및 내용의 열람 또는 고지를 요구할 수 있고, 오류가 있는 때에는 정정을 요구할 수 있습니다. 만약, 홈잇이 사용자의 개인위치정보를 사용자가 지정하는 제3자에게 직접 제공하는 때에는 법령에 따라 개인위치정보를 수집한 스마트폰 등으로 사용자에게 개인위치정보를 제공받는 자, 제공 일시 및 제공 목적을 즉시 통보하겠습니다.

홈잇은 8세 이하의 아동 등(금치산자, 중증 정신장애인 포함)의 보호의무자가 개인위치정보의 이용 또는 제공에 서면으로 동의하는 경우에는 해당 본인의 동의가 있는 것으로 보며, 이 경우 보호의무자는 개인위치정보주체의 권리를 모두 행사할 수 있습니다.

홈잇은 사용자의 위치정보를 안전하게 보호하기 위하여 위치정보관리책임자(우예진, yejin09071@gmail.com)를 지정하고 있습니다.

만약 사용자와 홈잇 간의 위치정보와 관련한 분쟁에 대하여 협의가 어려운 때에는 사용자은 위치정보의 보호 및 이용 등에 관한 법률 제 28조 2항 및 개인정보보호법 제43조의 규정에 따라 개인정보 분쟁조정위원회에 조정을 신청할 수 있습니다.

서비스 중단

홈잇 서비스는 장비의 유지∙보수를 위한 정기 또는 임시 점검 또는 다른 상당한 이유로 홈잇 서비스의 제공이 일시 중단될 수 있으며, 이때에는 미리 서비스 제공화면에 공지하겠습니다. 만약, 홈잇으로서도 예측할 수 없는 이유로 홈잇 서비스가 중단된 때에는 홈잇이 상황을 파악하는 즉시 통지하겠습니다.

이용계약 해지(서비스 탈퇴)

사용자가 홈잇 서비스의 이용을 더 이상 원치 않는 때에는 언제든지 홈잇 서비스 내 제공되는 메뉴를 이용하여 홈잇 서비스 이용계약의 해지 신청을 할 수 있으며, 홈잇은 법령이 정하는 바에 따라 신속히 처리하겠습니다. 다만, 거래사기 등의 부정이용 방지를 위해 거래를 진행중이거나 거래 관련 분쟁이 발생한 사용자는 이용계약 해지 및 서비스 탈퇴가 특정 기간 동안 제한될 수 있습니다. 이용계약이 해지되면 법령 및 개인정보처리방침에 따라 사용자 정보를 보유하는 경우를 제외하고는 사용자 정보나 사용자가 작성한 게시물 등 모든 데이터는 삭제됩니다. 다만, 사용자가 작성한 게시물이 제3자에 의하여 스크랩 또는 다른 공유 기능으로 게시되거나, 사용자가 제3자의 게시물에 댓글, 채팅 등 게시물을 추가하는 등의 경우에는 다른 이용자의 정상적 서비스 이용을 위하여 필요한 범위 내에서 홈잇 서비스 내에 삭제되지 않고 남아 있게 됩니다.

책임제한

홈잇은 법령상 허용되는 한도 내에서 홈잇 서비스와 관련하여 본 약관에 명시되지 않은 어떠한 구체적인 사항에 대한 약정이나 보증을 하지 않습니다. 예를 들어, 홈잇은 홈잇 서비스에 속한 콘텐츠, 서비스의 특정 기능, 서비스의 이용가능성에 대하여 어떠한 약정이나 보증을 하는 것이 아니며, 홈잇 서비스를 있는 그대로 제공할 뿐입니다.

손해배상

홈잇의 과실로 인하여 사용자가 손해를 입게 될 경우 홈잇은 법령에 따라 사용자의 손해를 배상하겠습니다. 다만, 홈잇은 홈잇 서비스에 접속 또는 이용과정에서 발생하는 개인적인 손해, 제3자가 불법적으로 홈잇의 서버에 접속하거나 서버를 이용함으로써 발생하는 손해, 제3자가 홈잇 서버에 대한 전송 또는 홈잇 서버로부터의 전송을 방해함으로써 발생하는 손해, 제3자가 악성 프로그램을 전송 또는 유포함으로써 발생하는 손해, 전송된 데이터의 생략, 누락, 파괴 등으로 발생한 손해, 명예훼손 등 제3자가 홈잇 서비스를 이용하는 과정에서 사용자에게 발생시킨 손해에 대하여 책임을 부담하지 않습니다. 또한 홈잇은 법률상 허용되는 한도 내에서 간접 손해, 특별 손해, 결과적 손해, 징계적 손해, 및 징벌적 손해에 대한 책임을 부담하지 않습니다.

약관수정

홈잇은 법률이나 홈잇 서비스의 변경사항을 반영하기 위한 목적 등으로 본 약관이나 각 홈잇 서비스 고객센터의 홈잇 서비스 이용방법, 해당 안내 및 고지사항을 수정할 수 있습니다. 본 약관이 변경되는 경우 홈잇은 변경 사항을 개별 홈잇 서비스 초기화면에 게시하며, 변경된 약관은 게시한 날로부터 7일 후부터 효력이 발생합니다.
홈잇은 변경된 약관을 게시한 날로부터 효력이 발생되는 날까지 약관변경에 대한 사용자의 의견을 기다리겠습니다. 위 기간이 지나도록 사용자의 의견이 홈잇에 접수되지 않으면, 사용자가 변경된 약관에 따라 서비스를 이용하는 데에 동의하는 것으로 보겠습니다. 사용자가 변경된 약관에 동의하지 않는 경우 변경된 약관의 적용을 받는 해당 서비스의 제공이 더 이상 불가능하게 됩니다.

사용자 의견

홈잇은 사용자의 의견을 소중하게 생각합니다. 사용자는 언제든지 서비스 내 홈잇 운영자 문의란을 통해 의견을 개진할 수 있습니다. 홈잇은 푸시 알림, 채팅 방법, 휴대폰 번호 등으로 사용자에게 여러 가지 소식을 알려드리며, 사용자 전체에 대한 통지는 홈잇 서비스 초기화면 또는 공지사항 란에 게시함으로써 효력이 발생합니다.
본 약관은 홈잇와 사용자와의 관계에 적용되며, 제3자의 수익권을 발생시키지 않습니다.
사용자가 본 약관을 준수하지 않은 경우에, 홈잇이 즉시 조치를 취하지 않더라도 홈잇이 가지고 있는 권리를 포기하는 것이 아니며, 본 약관 중 일부 조항의 집행이 불가능하게 되더라도 다른 조항에는 영향을 미치지 않습니다.
본 약관 또는 홈잇 서비스와 관련하여서는 대한민국의 법률이 적용됩니다.
    •    공고일자: 2024년 2월 20일
    •    시행일자: 2024년 2월 22일
"""
        
        let attributedString = NSMutableAttributedString(string: text)
        
        label.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        
        let ranges: [NSRange] = [
            (text as NSString).range(of: "계정 관련"),
            (text as NSString).range(of: "사용시 주의해야 할 점"),
            (text as NSString).range(of: "개인정보 보호 관련"),
            (text as NSString).range(of: "게시물의 저작권 보호"),
            (text as NSString).range(of: "게시물의 관리"),
            (text as NSString).range(of: "사용권리"),
            (text as NSString).range(of: "서비스 고지 및 홍보내용 표시"),
            (text as NSString).range(of: "위치기반서비스 관련"),
            (text as NSString).range(of: "서비스 중단"),
            (text as NSString).range(of: "이용계약 해지(서비스 탈퇴)"),
            (text as NSString).range(of: "책임제한"),
            (text as NSString).range(of: "손해배상"),
            (text as NSString).range(of: "약관수정"),
            (text as NSString).range(of: "사용자 의견")
            
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
        label.text = "이용 약관 동의"
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
             
             self.delegate?.buttonChecked()
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


protocol buttonChecked : AnyObject{
    func buttonChecked()
}