//
//  InteractionModel.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 11/11/2022.
//

import UIKit
/*
 Mais pourquoi faire appel a ce genre de class me direz-vous ?
 je vais vous posé moi une question ...
 quelle est la diference entre une class et une structure ?
 bah heu ... heu...
 bon je t'explique un peu ... la structure par appel ou invocation est une copie de l'objet,
 hors la classe n'est juste qu'un pointeur..... donc adresse memoire
 et la tu va me dire mais pourquoi tu me parle de ca ????
 bah la structure elle se fout ou en memoire ? contrairement a la class (#pointeur) ?
 la structure est en memoire vive BB, le pointeur aussi me diras tu...
 sauf que jai acces directement au donnée sans faire de traitement, tandis que la classe je vais demandé a mon pauvre petit iphone de retouver lespace memoire pour avoir les données que je veux
 mais attention si tu modifie la structure tu modifie pas l'objet il faut donc la reattribuer
 */
enum Listing
{
  enum API
  {
    struct Request
    {
        
    }
    struct Response
    {
        let datas: [ClassifiedAd]
    }
    struct ViewModel
    {
        let datasSorted: [ClassifiedAd]
    }
  }
}

enum CategoryList
{
  enum API
  {
    struct Request
    {
        
    }
    struct Response
    {
        let category: [Category]
    }
    struct ViewModel
    {
        let category: [Category]
    }
  }
}


enum Cell
{
  enum Interface
  {
    struct Request
    {
        let cell: ListingTableViewCell
        let info: ClassifiedAd
        
    }
    struct Response
    {
        let image: UIImage
        let categoryName: String
        let title: String
        let price: Float
        let urgent: Bool
        let cell: ListingTableViewCell
    }
    struct ViewModel
    {
        let category: [Category]
    }
  }
}


enum Sort
{
  enum Element
  {
    struct Request
    {
        let id: Int
        let listing: [ClassifiedAd]
        let categories: [Category]
    }
    struct Response
    {
        let categoryName: String
        let listingByCategory: [ClassifiedAd]
    }
    struct ViewModel
    {
        let categoryName: String
        let listingByCategory: [ClassifiedAd]
    }
  }
}

enum Filter
{
  enum Element
  {
    struct Request
    {
        let searchText: String
        let listing: [ClassifiedAd]
    }
    struct Response
    {
        let listingFilterdBytext: [ClassifiedAd]
    }
    struct ViewModel
    {
        let listingFilterdBytext: [ClassifiedAd]
    }
  }
}

enum Click
{
  enum Element
  {
    struct Request
    {
        let classifiedAd: ClassifiedAd
    }
    struct Response
    {
    }
    struct ViewModel
    {
    }
  }
}
