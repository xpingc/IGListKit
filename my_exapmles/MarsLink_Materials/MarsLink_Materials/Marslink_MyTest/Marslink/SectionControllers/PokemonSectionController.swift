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

import IGListKit
import UIKit

class PokemonSectionController: ListSectionController {
  var pokemonList: PokemonList!
  let solFormatter = SolFormatter()
  
  override init() {
    super.init()
    self.minimumLineSpacing = 10
    self.minimumInteritemSpacing = 10
    inset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
  }
}

extension PokemonSectionController {
  override func numberOfItems() -> Int {
    //return pokemonList.pokemons.count
    return pokemonList.pokemons.count + 1
  }
  
  override func sizeForItem(at index: Int) -> CGSize {
    guard let context = collectionContext,
          let _ = pokemonList
    else {
      return .zero
    }

    let width = context.containerSize.width as CGFloat

    if (index < pokemonList.pokemons.count) {
      let itemForEachRow: CGFloat = 3
      let itemSize = (width - (itemForEachRow - 1) * minimumInteritemSpacing) / itemForEachRow
      return CGSize(width: itemSize, height: itemSize)
    } else {
      return CGSize(width: width, height: 100)
    }
  }
  
  override func cellForItem(at index: Int) -> UICollectionViewCell {
    let cell = collectionContext!.dequeueReusableCell(of: PokemonCell.self, for: self, at: index)
    if let cell = cell as? PokemonCell {
      if index < pokemonList.pokemons.count {
        cell.label.text = pokemonList.pokemons[index].name
        cell.imageView.image = pokemonList.pokemons[index].image
      } else {
        cell.label.text = "View More"
        cell.imageView.isHidden = true
      }
    }

    return cell
  }
  
  override func didUpdate(to object: Any) {
    pokemonList = object as? PokemonList
  }
}
