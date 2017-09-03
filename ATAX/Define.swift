//
//  Text.swift
//  ATAX
//
//  Created by QTS Coder on 8/29/17.
//  Copyright © 2017 David. All rights reserved.
//




let URL_WS = "https://api.mytaxesdonelive.com/"

let defaults = UserDefaults.standard
let appDell = UIApplication.shared.delegate as! AppDelegate


let notificationKey_MyTaxFromMenu = "gotoMyTaxFromMenu"
let notifi_documentkey = "notifi_documentkey"
let notifi_messagekey = "notifi_messagekey"
let notifi_closemenukey = "notifi_closemenukey"

let Intro1 = "Welcome to ATAX Cloud\nLet’s Get Your Taxes Done"
let Intro2 = "Snap Photos of Your\nTax Documents"
let Intro3 = "We’ll Complete Your\nTaxes & Have a Live Call"

let IntroDes1 = "There is no need to do your own taxes. One of our tax professional or CPA will file your taxes & help you get the maximum refund you deserve."
let IntroDes2 = "Select from your photos & easily upload to your account."
let IntroDes3 = "We'll get your taxes done live and on-demand."

let fbLink = URL(string: "https://facebook.com/mytaxesdonelive")
let ttLink = URL(string: "https://twitter.com/mytaxesdonelive")
let youtubeLink = URL(string: "https://www.youtube.com/mytaxesdonelive")
let refundLink = URL(string: "https://sa.www4.irs.gov/irfof/lang/en/irfofgetstatus.jsp")

let ataxLink = URL(string: "http://atax.com/abn")
let taxnewLink = URL(string: "http://atax.com/blog")
let irsWebLink = URL(string: "https://www.irs.gov/")

let taxYear = ["2008","2009","2010","2011","2012","2013","2014","2015","2016","2017"]
let taxTypelist = ["Personal","Sales","Amendment","ParterShip065","Estate1041","Other"]
let documentType = ["1098","1098T","1099G","Donations","Passport","W2G"]
let invoiceList:[String] = ["Invoice #7845 - $149.99"]




