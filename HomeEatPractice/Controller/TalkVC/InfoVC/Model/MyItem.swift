//
//  MyItem.swift
//  HomeEatPractice
//
//  Created by 김민솔 on 2024/01/11.
//

struct MyItem : Codable {
    let id: Int // 게시글 ID
    let title: String // 게시글 제목
    let createdAt: String // 게시글 작성일시
    let updatedAt: String // 게시글 수정일시
    let content: String // 게시글 내용
    let love: Int // 좋아요 개수
    let view: Int // 조회수
    let commentNumber: Int // 댓글 개수
    let setLove: Bool
    let save: String // 저장 여부
    let infoPictures: [InfoPicture] // 게시글 사진 URL 배열
    let infoHashTags: [String]
    let infoTalkComments: [InfoTalkComment]

    // 초기화
    init(id: Int, title: String, createdAt: String,updatedAt: String, content: String, love: Int, view: Int, commentNumber: Int, setLove: Bool,save: String, infoPictures:  [InfoPicture],infoHashTags: [String],infoTalkComments: [InfoTalkComment]) {
        self.id = id
        self.title = title
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.content = content
        self.love = love
        self.view = view
        self.commentNumber = commentNumber
        self.setLove = setLove
        self.save = save
        self.infoPictures = infoPictures
        self.infoHashTags = infoHashTags
        self.infoTalkComments = infoTalkComments
    }
}
