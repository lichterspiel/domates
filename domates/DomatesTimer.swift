//
//  Timer.swift
//  domates
//
//  Created by Mehmet Sinan Eris on 08.02.23.
//

import SwiftUI

class DomatesTimer: ObservableObject {
    private static var domatesTimer: DomatesTimer?
    
    private var studyIntervall: Int
    private var breakIntervall: Int
    private var studyRounds: Int
    private var timer: Timer?
    
    
    @Published private(set) var isPaused: Bool = false
    @Published public var elapsedSeconds: Int = 0
    @Published public var elapsedRounds: Int = 0
    @Published public var isRunning: Bool = false
    
    init(studyIntervall: Int, breakIntervall: Int, studyRounds: Int) {
        self.studyIntervall = studyIntervall
        self.breakIntervall = breakIntervall
        self.studyRounds = studyRounds
    }
    
    
    public func startTimer(){
        if self.elapsedRounds != self.studyRounds * 2{
            if self.elapsedRounds % 2 == 0{
                self.doTime(isStudy: true)
            }
            else {
                self.doTime(isStudy: false)
            }
            
            isRunning = true
        }
        else {
            self.stopTimer()
            self.elapsedRounds = 0
        }
    }
    
    private func doTime(isStudy: Bool){
        let seconds = isStudy ? studyIntervall * 60  : breakIntervall * 60
            
        let timeString = String(
           format: "%.2i:%.2i",
           (seconds - self.elapsedSeconds) / 60,
           (seconds - self.elapsedSeconds) % 60
        )
        AppDelegate.shared.statusBar?.setTitle(timeString)
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ timer in
            if self.isPaused{
                return
            }
            
            self.elapsedSeconds += 1
            
            let timeString = String(
               format: "%.2i:%.2i",
               (seconds - self.elapsedSeconds) / 60,
               (seconds - self.elapsedSeconds) % 60
            )
            AppDelegate.shared.statusBar?.setTitle(timeString)
            
            if self.elapsedSeconds == seconds{
                
                self.elapsedRounds += 1
            
                self.stopTimer()
                self.startTimer()
            }
        }
    }
    
    public func stopTimer(){
        self.timer?.invalidate()
        self.timer = nil
        self.elapsedSeconds = 0
        self.isRunning = false
        
        AppDelegate.shared.statusBar?.setTitle("")
    }
    
    public func togglePause(){
        self.isPaused = !self.isPaused
    }
    
    public func setStudyIntervall(intervall: Int){
        self.studyIntervall = intervall
    }
    
    public func setBreakIntervall(intervall: Int){
        self.breakIntervall = intervall
    }
    
    public func setRounds(rounds: Int){
        self.studyRounds = rounds
    }
    
    public static func getTimer() -> DomatesTimer{
        if Self.domatesTimer == nil {
            Self.domatesTimer = DomatesTimer(studyIntervall: 25, breakIntervall: 5, studyRounds: 4)
        }
        
        return Self.domatesTimer!
    }
    
    
}
