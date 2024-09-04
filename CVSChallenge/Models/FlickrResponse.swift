//
//  FlickrResponse.swift
//  CVSChallenge
//
//  Created by Daniel Mori on 02/09/24.
//

import Foundation

struct FlickrResponse: Decodable {
    let posts: [Post]
    
    private enum CodingKeys: String, CodingKey {
        case posts = "items"
    }
}

// Mock for Preview
extension FlickrResponse {
    static var mock: [Post] = Array(repeating: Post(title: "Title for post", link: "https://www.flickr.com/photos/lisadphotos/53558159256/", media: Media(image: "https://live.staticflickr.com/65535/53558159256_815682ff5a_m.jpg"), published: "", author: "nobody@flickr.com ('LisaDiazPhotos')", tags: "porcupine lisadiazphotos sdzsafaripark sdzoo sdzsp sandiegozoo sandiegozoosafaripark sandiegozooglobal childrens zoo", description: "<p><a href='https://www.flickr.com/people/lisadphotos/'>LisaDiazPhotos</a> posted a photo:</p> <p><a href='https://www.flickr.com/photos/lisadphotos/53558159256/' title='Porcupine.'><img src='https://live.staticflickr.com/65535/53558159256_815682ff5a_m.jpg' width='179' height='240' alt='Porcupine.' /></a></p> <p>Photos cannot be used or taken without permission.</p>"), count: 10)
}
