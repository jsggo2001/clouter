package com.mmm.clout.memberservice.bookmark.domain;

import com.mmm.clout.memberservice.common.entity.BaseEntity;
import com.mmm.clout.memberservice.member.domain.Member;
import lombok.*;
import org.hibernate.annotations.DynamicInsert;

import javax.persistence.*;

@Getter
@ToString
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@DynamicInsert
@Entity
public class Bookmark extends BaseEntity {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "bookmark_id")
    private Long id;

    @OneToOne
    @JoinColumn(name = "member_id")
    private Member member;

    private Long targetId;

    @Enumerated(EnumType.STRING)
    private BookmarkType bookmarkType;


    public Bookmark(Member member, Long targetId, BookmarkType bookmarkType) {
        this.member = member;
        this.targetId = targetId;
        this.bookmarkType = bookmarkType;
    }
}
