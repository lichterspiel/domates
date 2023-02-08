//
//  PopoverView.swift
//  domates
//
//  Created by Mehmet Sinan Eris on 08.02.23.
//

import SwiftUI
import Combine

struct PopoverView: View {
    @State var buttonText = "Start"
    @State private var studyDuration: String = "25"
    @State private var breakDuration: String = "5"
    @State private var rounds: String = "4"
    @ObservedObject var timer: DomatesTimer = DomatesTimer.getTimer()
    
    
    var body: some View {
        VStack(alignment: .leading){
            Button(action: {
                if timer.elapsedSeconds == 0{
                    timer.startTimer()
                }
                else{
                    timer.stopTimer()
                }
            }, label: {
                if timer.elapsedSeconds == 0{
                    Text("Start")
                    .frame(maxWidth: .infinity)
                }
                else {
                    Text("Stop")
                    .frame(maxWidth: .infinity)
                }
            })
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            
            HStack(spacing: 30){
                Text("Timer Duration")
                TextField("Minutes", text: $studyDuration)
                    .onChange(of: studyDuration, perform: {
                        newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.studyDuration = filtered
                        }
                        if timer.isRunning {
                            timer.stopTimer()
                            timer.setStudyIntervall(intervall: Int(filtered) ?? 0)
                        }
                        else {
                            timer.setStudyIntervall(intervall: Int(filtered) ?? 0)
                        }
                        
                    })
                    .frame(width: 40)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            HStack(spacing: 30){
                Text("Pause Duration")
                TextField("Minutes", text: $breakDuration)
                    .frame(width: 40)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: breakDuration, perform: {
                        newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.breakDuration = filtered
                        }
                        if timer.isRunning {
                            timer.stopTimer()
                            timer.setBreakIntervall(intervall: Int(filtered) ?? 0)
                        }
                        else {
                            timer.setBreakIntervall(intervall: Int(filtered) ?? 0)
                        }
                    })
            }
            HStack(){
                Text("Study Rounds")
                TextField("Rounds", text: $rounds)
                    .frame(width: 40)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: rounds, perform: {
                        newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.rounds = filtered
                        }
                        if timer.isRunning {
                            timer.stopTimer()
                            timer.setRounds(rounds: Int(filtered) ?? 0)
                        }
                        else {
                            timer.setRounds(rounds: Int(filtered) ?? 0)
                        }
                        
                    })
            }
            .frame(maxWidth: .infinity, alignment: .center)
            Divider()
            Button("Quit"){
                NSApplication.shared.terminate(nil)
            }.keyboardShortcut("Q")
                .buttonStyle(.plain)
        }
         .padding()
         .frame(width: 200)
    }
   }

struct PopoverView_Previews: PreviewProvider {
    static var previews: some View {
        PopoverView()
    }
}
