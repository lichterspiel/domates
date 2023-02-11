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
    @AppStorage("studyDuration") private var studyDuration: String = "25"
    @AppStorage("breakDuration") private var breakDuration: String = "5"
    @AppStorage("rounds") private var rounds: String = "4"
    
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
            
            Text("Time in Minutes")
                .frame(maxWidth: .infinity)
            
            HStack(){
                Text("Timer Duration")
                Spacer()
                TextField("", text: $studyDuration)
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
            HStack(){
                Text("Pause Duration")
                Spacer()
                TextField("", text: $breakDuration)
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
                Spacer()
                TextField("", text: $rounds)
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
            }
            .buttonStyle(.plain)
            .keyboardShortcut("q")
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
