//
//  Extension.swift
//  prinka
//
//  Created by LIPING on 5/10/21.
//

import Foundation
import SDWebImage
extension UIImageView{
    func loadImage(_ urlString: String?, onSuccess: ((UIImage) -> Void)? = nil){
        self.image = UIImage()
        guard let string = urlString else{
            return
        }
        guard let url = URL(string: string) else{
            return
        }
        
        self.sd_setImage(with: url){ (image, error, type, url) in
            if onSuccess != nil, error == nil{
                onSuccess!(image!)
            }
        }
    
    }
}
