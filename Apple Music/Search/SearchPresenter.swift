//
//  SearchPresenter.swift
//  Apple Music
//
//  Created by Yehor Krupiei on 30.07.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchPresentationLogic {
  func presentData(response: Search.Model.Response.ResponseType)
}

class SearchPresenter: SearchPresentationLogic {
  weak var viewController: SearchDisplayLogic?
  
  func presentData(response: Search.Model.Response.ResponseType) {
  
      switch response {
          
      case .some:
          print("presenter .some")
      case .presentTracks:
          print("presenter .presentTracks")
          viewController?.displayData(viewModel: Search.Model.ViewModel.ViewModelData.displayTracks)
      }
  }
  
}
