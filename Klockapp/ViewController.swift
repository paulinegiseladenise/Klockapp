//
//  ViewController.swift
//  Klockapp
//
//  Created by Pauline Broängen on 2022-08-29.
//

import UIKit

class ViewController: UIViewController {

    
    //nedanför är våra två timers labels
    @IBOutlet weak var lblTime1: UILabel!
    @IBOutlet weak var lblTime2: UILabel!
    
    
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnReset: UIButton!
    
    
    //default är true så därför börjar man med true. variabeln för att börja spela och så ska det stå switch när spelet är igång
    var firstPlay: Bool = true
    //en variabel för när spelet är igång

    //nedanför är nedräkningstidervariablerna. istället för double kan man använda sig av Double.... det är bara olika sätt.. variablerna är egentligen bara sekunder.... dom omvandlas till minuter och sekunder i timeformatter..
    var count1: TimeInterval = 300.0
    var count2: TimeInterval = 300.0

    var player1Enabled: Bool = false
    var player2Enabled: Bool = false
    
    //lastPlayed kan vara nil (null) eftersom att ingen har spelat när appen precis har startats. därför skrivs det ett frågetecken efter String?
    var lastPlayed: String?
    
    //variabel av timer
    var timer: Timer?
    
    var timeFormatter: DateComponentsFormatter = DateComponentsFormatter()
    
    
    
    
    //viewDidLoad är vad som händer när appen körs första gången och appen startar.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
   
        timeFormatter.allowedUnits = [.minute, .second]
    
        //nedanför är koden för att visa upp nedräkningen, alltså count1s värden eller count2s värden. i variablerna count1 och count2 kan man ha Int också. skriver man timeFormatter.string så får man flera val och kan välja.
       
        let timeLeft = timeFormatter.string(from: count1)
        lblTime1.text = timeLeft
        
        let timeLeft2 = timeFormatter.string(from: count2)
        lblTime2.text = timeLeft2
    }
    
    
    
    //playknappen, när man trycker på knappen så måste en player börja och definiera det.
    @IBAction func onPressPlay(_ sender: Any) {
        
        //.normal betyder normal stated knapputseende. hur den ser ut när man trycker på den dvs.
        if firstPlay == true {
            btnPlay.setTitle("Switch", for: .normal)
            firstPlay = false
        
            print("First play!")
            
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: tick1(timer:))
       player1Enabled = true
       lastPlayed = "Player1"
       return
    }
        
        
    //varför fick man först timer?.invalidate() timer är en optional och det kommer endast att köras om timer inte är nil
        if let firstPlayed = lastPlayed {
            
            if firstPlayed == "Player1" {
            timer?.invalidate()
            player1Enabled = false
            
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: tick2(timer:))
                lastPlayed = "Player 2"
                player2Enabled = true
            } else if firstPlayed == "Player 2" {
                timer?.invalidate()
                player2Enabled = false
                
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: tick1(timer:))
                lastPlayed = "Player 1"
                player1Enabled = true
            }
        }
    }
        
    
    func reset() {
        timer?.invalidate()
        lastPlayed = nil
        player1Enabled = false
        player2Enabled = false
        
        firstPlay = true
        
        count1 = 300.0
        count2 = 300.0
        
        let timeLeft1 = timeFormatter.string(from: count1)
        let timeLeft2 = timeFormatter.string(from: count2)
        
        lblTime1.text = timeLeft1
        lblTime2.text = timeLeft2
        btnPlay.setTitle("Play", for: .normal)
    }
    
   
    
    @IBAction func Reset(_ sender: Any) {
    
    
    reset()
        
    }
    
    
    
    func tick1(timer: Timer) {
    count1 -= 1
        
        let timeLeft = timeFormatter.string(from: count1)
        lblTime1.text = timeLeft
    }


    func tick2(timer: Timer) {
        count2 -= 1
        
        let timeLeft = timeFormatter.string(from: count2)
        lblTime2.text = timeLeft
        
    }
}
