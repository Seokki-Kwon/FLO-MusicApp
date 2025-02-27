//
//  MusicDto.swift
//  Flo_Clone
//
//  Created by 권석기 on 2/27/25.
//

struct MusicDto: Codable {
    let song_id: Int
    let title: String
    let artist: String
    let duration: Int
    let album_thumbnail: String
    let mp3_url: String
}

extension Array where Element == MusicDto {
    func toDomain() -> [Music] {
        self.map { Music(albumImageUrl: $0.album_thumbnail,
                         rank: 0,
                         songName: $0.title,
                         artistName: $0.artist)}
    }
}
