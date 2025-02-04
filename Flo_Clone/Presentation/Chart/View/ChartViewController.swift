//
//  ChartViewController.swift
//  Flo_Clone
//
//  Created by 권석기 on 2/3/25.
//

import UIKit
import SnapKit
import Then

class ChartViewController: UIViewController {
    let text: String
    private let testLabel = UILabel().then {
        $0.textColor = .white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(testLabel)
        testLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        testLabel.text = text
    }
    
    init(text: String) {
        self.text = text
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
