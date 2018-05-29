//
//  orbitingPlot.swift
//  VuforiaSampleSwift
//
//  Created by Misha on 4/12/17.
//  Copyright © 2017 Yoshihiro Kato. All rights reserved.
//

import Foundation

class orbitingPlot : PlotObject {
    
    let spaceNode = space()
    init (){
        super.init(view : VuforiaEAGLView)
        
    }
}
