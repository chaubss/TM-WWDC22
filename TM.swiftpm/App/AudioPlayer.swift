//
//  File.swift
//  
//
//  Created by Aryan Chaubal on 4/20/22.
//

import AVFoundation

class AudioPlayer: NSObject, AVAudioPlayerDelegate {
    
    
    static let shared = AudioPlayer()
    
    private override init() {
        
    }
    
    var players: [URL: AVAudioPlayer] = [: ]
    var duplicatePlayers: [AVAudioPlayer] = []
    
    public func playSound(soundFileName: String) {
        
        guard let soundFileNameURL = Bundle.main.url(forResource: soundFileName, withExtension: "mp3") else { return }
        
        if let player = players[soundFileNameURL] { //player for sound has been found
            
            if !player.isPlaying { //player is not in use, so use that one
                player.prepareToPlay()
                player.volume = 0.5
                player.play()
            } else { // player is in use, create a new, duplicate, player and use that instead
                
                do {
                    let duplicatePlayer = try AVAudioPlayer(contentsOf: soundFileNameURL)
                    
                    duplicatePlayer.delegate = self
                    //assign delegate for duplicatePlayer so delegate can remove the duplicate once it's stopped playing
                    
                    duplicatePlayers.append(duplicatePlayer)
                    //add duplicate to array so it doesn't get removed from memory before finishing
                    
                    duplicatePlayer.prepareToPlay()
                    duplicatePlayer.volume = 0.5
                    duplicatePlayer.play()
                } catch let error {
                    print(error.localizedDescription)
                }
                
            }
        } else { //player has not been found, create a new player with the URL if possible
            do {
                let player = try AVAudioPlayer(contentsOf: soundFileNameURL)
                players[soundFileNameURL] = player
                player.prepareToPlay()
                player.volume = 0.5
                player.play()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
//
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if let index = duplicatePlayers.firstIndex(of: player) {
            duplicatePlayers.remove(at: index)
        }
    }
    
}
