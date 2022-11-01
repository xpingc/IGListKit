/// Copyright (c) 2022 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import IGListKit

class PokemonViewController: UIViewController, ListAdapterDataSource {
  func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
    return loader.entries
  }
  
  func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
    return PokemonSectionController()
  }
  
  func emptyView(for listAdapter: ListAdapter) -> UIView? {
    return nil
  }
  
  let loader = JournalEntryLoader()
  let collectionView: UICollectionView = {
//    let layout = PokemonFlowLayout(        cellsPerRow: 3,
//                                           minimumInteritemSpacing: 10,
//                                           minimumLineSpacing: 10,
//                                           sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    // let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
    let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    view.backgroundColor = .systemBlue
    // view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  lazy var adapter: ListAdapter = {
    return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
  }()
  override func viewDidLoad() {
      super.viewDidLoad()

      // Do any additional setup after loading the view.
    loader.loadLatest();
    view.addSubview(collectionView)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
    adapter.collectionView = collectionView
    adapter.dataSource = self
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
