//
//  SentMemesTableViewController.swift
//  MemeMe_2.0
//
//  Created by marta on 04/04/2020.
//  Copyright © 2020 udacity.com. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    
    @IBOutlet var sentMemesTableView: UITableView!

    var memes: [Meme]!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memes = appDelegate.memes
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let meme = memes[indexPath.row]

        tableCell.tableTopText?.text = meme.topTextField
        tableCell.tableBottomText?.text = meme.bottomTextField
        tableCell.tableImageCell.image = meme.memedImage

        tableCell.imageSetup()

        return tableCell
    }
}
