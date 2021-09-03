struct Base32Generator: PasswordGenerator {
    let characterSet: Set<Character>
    
    init(characterSet: Set<Character> = .init("0123456789abcdefghjkmnpqrstuwxyz")) {
        precondition(characterSet.count == 32)
        self.characterSet = characterSet
    }
    
    func generate(securityLevel: Float64) -> String {
        let characterCount = Int((securityLevel / 5).rounded(.up))
        return String((0..<characterCount).map { _ in characterSet.randomElement()! })
    }
}
