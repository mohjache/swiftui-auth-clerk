//
//  AppContainer.swift
//  swiftu-auth-clerk
//
//  Created by Anaru Herbert on 7/3/2025.
//

import LambdaspireAbstractions
import LambdaspireDependencyResolution

func getAppContainer() -> Container {
    let containerBuilder: ContainerBuilder = .init()
    
    return containerBuilder.build()
}