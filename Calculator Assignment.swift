import SwiftUI

enum ButtonType: String {
    case first, second, third, forth, fifth, sixth, seventh, eighth, nineth, zero
    case dot, equal, plus, minus, multiply, divide
    case percent, opposite, clear
    
    var buttonDisplayName: String {
        switch self {
        case .first :
            return "1"
        case .second :
            return "2"
        case .third :
            return "3"
        case .forth :
            return "4"
        case .fifth :
            return "5"
        case .sixth:
            return "6"
        case .seventh:
            return "7"
        case .eighth:
            return "8"
        case .nineth:
            return "9"
        case .zero:
            return "0"
        case .dot:
            return "."
        case .equal:
            return "="
        case .plus:
            return "+"
        case .minus:
            return "-"
        case .multiply:
            return "×"
        case .divide:
            return "÷"
        case .percent:
            return "%"
        case .opposite:
            return "+/-"
        case .clear:
            return "C"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .first, .second, .third, .forth, .fifth, .sixth, .seventh, .eighth, .nineth, .zero, .dot:
            return Color("NumberButton")
            
        case .plus, .minus, .multiply, .divide, .equal:
            return Color.orange
            
        case .percent, .opposite, .clear:
            return Color.gray
        }
    }
    
    var foregroundColor : Color {
        switch self {
        case .first, .second, .third, .forth, .fifth, .sixth, .seventh, .eighth, .nineth, .zero, .dot, .plus, .minus, .multiply, .divide, .equal:
            return Color.white
            
        case .percent, .opposite, .clear:
            return Color.black
        }
    }
}
struct ContentView: View {
    
    @State private var totalNumber: String = "0"
    @State var tempNumber: Int = 0
    @State var operatorType: ButtonType = .clear
    @State var isNotEditing: Bool = true
    
    private let buttonData: [[ButtonType]] = [
        [.clear, .opposite, .percent, .divide],
        [.seventh, .eighth, .nineth, .multiply],
        [.forth, .fifth, .sixth, .minus],
        [.first, .second, .third, .plus],
        [.zero, .dot, .equal]
    ]
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            
            VStack {
                Spacer()
                HStack{
                    Spacer()
                    Text(totalNumber)
                        .padding()
                        .font(.system(size: 63))
                        .foregroundColor(.white)
                }
                
                ForEach(buttonData, id: \.self) {
                    line in HStack{
                        ForEach(line, id: \.self) {
                            row in Button{
                                if isNotEditing {
                                    
                                    if row == .clear{
                                        totalNumber = "0"
                                        isNotEditing = true
                                    } else if row == .plus ||
                                                row == .minus ||
                                                row == .multiply ||
                                                row == .divide {
                                        totalNumber = "Error"
                                    }
                                    else {
                                        totalNumber = row.buttonDisplayName
                                        isNotEditing = false
                                    }
                                }
                                else {
                                    if row == .clear{
                                        totalNumber = "0"
                                        isNotEditing = true
                                    }
                                    else if row == .plus {
                                        tempNumber = Int(totalNumber) ?? 0
                                        // 숫자를 저장
                                        operatorType = .plus
                                        // 더하기를 한다
                                        isNotEditing = true
                                    }
                                    else if row == .minus {
                                        tempNumber = Int(totalNumber) ?? 0
                                        // 숫자를 저장
                                        operatorType = .minus
                                        // 빼기를 한다
                                        isNotEditing = true
                                        }
                                    else if row == .multiply{
                                        tempNumber = Int(totalNumber) ?? 0
                                        // 숫자를 저장
                                        operatorType = .multiply
                                        // 곱하기를 한다
                                        isNotEditing = true
                                        }
                                    else if row == .divide{
                                        tempNumber = Int(totalNumber) ?? 0
                                        // 숫자를 저장
                                        operatorType = .divide
                                        // 나누기를 한다
                                        isNotEditing = true
                                        }
                                    else if row == .equal{
                                        if operatorType == .plus {
                                            totalNumber = String((Int(totalNumber) ?? 0) + tempNumber)}
                                        else if operatorType == .minus {
                                            totalNumber = String(tempNumber - (Int(totalNumber) ?? 0))
                                        }
                                        else if operatorType == .multiply {
                                            totalNumber = String((Int(totalNumber) ?? 0) * tempNumber)
                                        }
                                        else if operatorType == .divide {
                                            totalNumber = String(tempNumber / (Int(totalNumber) ?? 0))
                                        }
                                    }
                                    
                                    else {
                                        totalNumber += row.buttonDisplayName
                                    }
                                }
                            } label: {
                                Text(row.buttonDisplayName)
                                    .bold()
                                    .frame(width: calculateButtonWidth(button: row) , height: calculateButtonHeight(button: row))
                                    .background(row.backgroundColor)
                                    .cornerRadius(40)
                                    .foregroundColor(row.foregroundColor)
                                    .font(.system(size: 33))
                                
                            }
                            
                        }
                    }
                }
                
                
            }
        }
    }
    
    private func calculateButtonWidth(button buttonType: ButtonType ) -> CGFloat{
        switch buttonType {
        case .zero:
            return ((UIScreen.main.bounds.width - 5*10) / 4) * 2
        default:
            return (UIScreen.main.bounds.width - 5*10) / 4
        }
    }
    
    private func calculateButtonHeight(button: ButtonType ) -> CGFloat{
            return (UIScreen.main.bounds.width - 5*10) / 4
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
