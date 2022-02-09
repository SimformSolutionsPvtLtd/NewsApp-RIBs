//
//  AppComponent.swift
//  NewsApp
//
//  Created by Shilpesh Shah on 04/02/22.
//

import RIBs

class AppComponent: Component<EmptyDependency>, RootDependency {
  init() {
    super.init(dependency: EmptyComponent())
  }
}
