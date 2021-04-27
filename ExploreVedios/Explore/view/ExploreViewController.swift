//
//  ViewController.swift
//  ExploreVedios
//
//  Created by iOS Developer on 26/04/21.
//

import UIKit
import AVKit

enum ExpoloreVedioType {
    case trending
    case mustwatch
    case newlyadded
    case popular
}

class ExploreViewController: UIViewController {
    
    @IBOutlet weak var trendingVediosCollectionView: UICollectionView!
    @IBOutlet weak var mustWatchVediosCollectionView: UICollectionView!
    @IBOutlet weak var newlyAddedVediosCollectionView: UICollectionView!
    @IBOutlet weak var popularVediosCollectionView: UICollectionView!
    @IBOutlet weak var activeIndicatorBackgroundView: UIView!
    @IBOutlet weak var activeIndicator: UIActivityIndicatorView!
    
    
    var getVediosDetailsData:GetVediosDetailsData?
    
    override func viewDidAppear(_ animated: Bool) {
        if getVediosDetailsData == nil{
            getJsonData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        trendingVediosCollectionView.register(ExploreVedioCollectionViewCell.self, forCellWithReuseIdentifier: ExploreVedioCollectionViewCell.identifier)
        mustWatchVediosCollectionView.register(ExploreVedioCollectionViewCell.self, forCellWithReuseIdentifier: ExploreVedioCollectionViewCell.identifier)
        newlyAddedVediosCollectionView.register(ExploreVedioCollectionViewCell.self, forCellWithReuseIdentifier: ExploreVedioCollectionViewCell.identifier)
        popularVediosCollectionView.register(ExploreVedioCollectionViewCell.self, forCellWithReuseIdentifier: ExploreVedioCollectionViewCell.identifier)
        
        
    }
    
    func getJsonData(){
        if let path = Bundle.main.path(forResource: "assignment", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let getVediosDetailsData = try? JSONDecoder().decode(GetVediosDetailsData.self, from: data)
                self.getVediosDetailsData = getVediosDetailsData
                DispatchQueue.global(qos: .background).async {
                    for (index,details) in getVediosDetailsData?.enumerated() ?? [].enumerated(){
                        for (innerIndex,vedio) in details.nodes?.enumerated() ?? [].enumerated() {
                            if let url = URL(string: vedio.video?.encodeURL ?? ""){
                                self.getVediosDetailsData?[index].nodes?[innerIndex].video?.thumbnail = self.createThumbnail(from: url)
                            }
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.trendingVediosCollectionView.reloadData()
                    self.mustWatchVediosCollectionView.reloadData()
                    self.newlyAddedVediosCollectionView.reloadData()
                    self.popularVediosCollectionView.reloadData()
                    self.activeIndicator.stopAnimating()
                    self.activeIndicatorBackgroundView.isHidden =  true
                }
              } catch  let error{
                print(error.localizedDescription)
              }
        }
    }

}

extension ExploreViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case trendingVediosCollectionView:
            return getVediosDetailsData?.first?.nodes?.count ?? 0
        case mustWatchVediosCollectionView:
            return getVediosDetailsData?[1].nodes?.count ?? 0
        case newlyAddedVediosCollectionView:
            return getVediosDetailsData?[2].nodes?.count ?? 0
        case popularVediosCollectionView:
            return getVediosDetailsData?.last?.nodes?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreVedioCollectionViewCell.identifier, for: indexPath) as! ExploreVedioCollectionViewCell
        cell.contentView.tag = indexPath.row
        cell.cellView.tag = indexPath.row
        switch collectionView {
        case trendingVediosCollectionView:
            if let thumbnail =  getVediosDetailsData?.first?.nodes?[indexPath.row].video?.thumbnail{
                cell.backgroundImageView.image =  thumbnail
            }else{
                if let url = URL(string: getVediosDetailsData?.first?.nodes?[indexPath.row].video?.encodeURL ?? ""){
                    cell.backgroundImageView.image = createThumbnail(from: url)
                    getVediosDetailsData?.first?.nodes?[indexPath.row].video?.thumbnail =  createThumbnail(from: url)
                }
            }
            let tapGestrue = UITapGestureRecognizer(target: self, action: #selector(didSelectTrendingVedio(_:)))
            cell.cellView.addGestureRecognizer(tapGestrue)
        case mustWatchVediosCollectionView:
            if let thumbnail =  getVediosDetailsData?[1].nodes?[indexPath.row].video?.thumbnail{
                cell.backgroundImageView.image =  thumbnail
            }else{
                if let url = URL(string: getVediosDetailsData?[1].nodes?[indexPath.row].video?.encodeURL ?? ""){
                    cell.backgroundImageView.image = createThumbnail(from: url)
                    getVediosDetailsData?[1].nodes?[indexPath.row].video?.thumbnail =  createThumbnail(from: url)
                }
            }
            let tapGestrue = UITapGestureRecognizer(target: self, action: #selector(didSelectMustWatchingVedio(_:)))
            cell.cellView.addGestureRecognizer(tapGestrue)
        case newlyAddedVediosCollectionView:
            if let thumbnail =  getVediosDetailsData?[2].nodes?[indexPath.row].video?.thumbnail{
                cell.backgroundImageView.image =  thumbnail
            }else{
                if let url = URL(string: getVediosDetailsData?[2].nodes?[indexPath.row].video?.encodeURL ?? ""){
                    cell.backgroundImageView.image = createThumbnail(from: url)
                    getVediosDetailsData?[2].nodes?[indexPath.row].video?.thumbnail =  createThumbnail(from: url)
                }
            }
            let tapGestrue = UITapGestureRecognizer(target: self, action: #selector(didSelectNewlyAddingVedio(_:)))
            cell.cellView.addGestureRecognizer(tapGestrue)
        case popularVediosCollectionView:
            if let thumbnail =  getVediosDetailsData?.last?.nodes?[indexPath.row].video?.thumbnail{
                cell.backgroundImageView.image =  thumbnail
            }else{
                if let url = URL(string: getVediosDetailsData?.last?.nodes?[indexPath.row].video?.encodeURL ?? ""){
                    cell.backgroundImageView.image = createThumbnail(from: url)
                    getVediosDetailsData?.last?.nodes?[indexPath.row].video?.thumbnail =  createThumbnail(from: url)
                }
            }
            let tapGestrue = UITapGestureRecognizer(target: self, action: #selector(didSelectPopularVedio(_:)))
            cell.cellView.addGestureRecognizer(tapGestrue)
        default:
            break
        }
        return cell
    }
    
    func createThumbnail(from url:URL)->UIImage{
        do {
        let asset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        let time = CMTimeMake(value: 1, timescale: 1)
        let imageRef = try imageGenerator.copyCGImage(at: time, actualTime: nil)
        return UIImage(cgImage: imageRef)
        }catch let error{
        print(error.localizedDescription)
            return UIImage(named: "gallary") ?? UIImage()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width/3) + 50, height: 300)
       }
    
    @objc func didSelectTrendingVedio(_ sender:UIGestureRecognizer){
        navigateToExploreDetails(type: .trending, selectionIndex: sender.view?.tag ?? 0)
    }
    
    @objc func didSelectMustWatchingVedio(_ sender:UIGestureRecognizer){
        navigateToExploreDetails(type: .mustwatch, selectionIndex: sender.view?.tag ?? 0)
    }
    
    @objc func didSelectNewlyAddingVedio(_ sender:UIGestureRecognizer){
        navigateToExploreDetails(type: .newlyadded, selectionIndex: sender.view?.tag ?? 0)
    }
    
    @objc func didSelectPopularVedio(_ sender:UIGestureRecognizer){
        navigateToExploreDetails(type: .popular, selectionIndex: sender.view?.tag ?? 0)
    }
     
    func navigateToExploreDetails(type:ExpoloreVedioType,selectionIndex:Int){
        let exploreDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ExploreDetailsViewController") as!  ExploreDetailsViewController
        exploreDetailsVC.selectedIndex = selectionIndex
        switch type {
        case .trending:
            exploreDetailsVC.vediosNodes = getVediosDetailsData?.first?.nodes
            exploreDetailsVC.selectionType = "Trending"
        case .mustwatch:
            exploreDetailsVC.vediosNodes = getVediosDetailsData?[1].nodes
            exploreDetailsVC.selectionType = "Must Watch"
        case .newlyadded:
            exploreDetailsVC.vediosNodes = getVediosDetailsData?[2].nodes
            exploreDetailsVC.selectionType = "Newly Added"
        case .popular:
            exploreDetailsVC.vediosNodes = getVediosDetailsData?.last?.nodes
            exploreDetailsVC.selectionType = "Popular"
        }
        self.navigationController?.pushViewController(exploreDetailsVC, animated: true)
    }
   
}

