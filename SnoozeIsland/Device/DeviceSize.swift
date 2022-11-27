//
//  DeviceSize.swift
//  SnoozeIsland
//
//  Created by 윤자현 on 2021/12/28.
//

import Foundation
import UIKit

// 뷰 전체 폭 길이
let screenWidth = UIScreen.main.bounds.size.width
    
// 뷰 전체 높이 길이
let screenHeight = UIScreen.main.bounds.size.height


//MARK: - 기기 사이즈에 맞춰 오토레이아웃 코드로 잡는 함수
  func setAutolayout() {
  
      if screenHeight == 896 {
          print("iPhone 11, 11proMax, iPhone XR")
      }
      else if screenHeight == 926 {
          print("iPhone 12proMax")
      }
      else if screenHeight == 844 {
          print("iPhone 12, 12pro")
      }
      else if screenHeight == 736 {
          print("iPhone 8plus")
      }
      else if screenHeight == 667 {
          print("iPhone 8")
      }
      else {
          print("iPhone 12 mini, iPhone XS")
      }
  }
