import Foundation

let boardSize = 10

//Representation of the game board
let empty = "⬜️"
let hit = "🔥"
let miss = "💧"

//Initialize the game board
func initializeBoard()->[[String]]
{
    return Array(repeating: Array(repeating: empty, count: boardSize), count: boardSize)
}
//Print the game board
func printBoard(_ board: [[String]]) {
    print("   0 1 2 3 4 5 6 7 8 9")
    for i in 0..<board.count {
        let row = board[i].map { $0 }.joined(separator: " ")
        print("\(i) \(row)")
    }
}

//Randomly place ships on the board
func placeShip() - > (Int, Int)
{
    let x = Int.random(in: 0..<boardSize)
    let y = Int.random(in: 0..<boardSize)
    return (x,y)
}

//Get player's move on the board
func getPlayerMove() -> (Int, Int)
{
    print("Enter your move (row and column, space-separated): ", terminator: "" )
    if let input = readLine()
    {
        let components = input.split(separator: " ")
        if components.count == 2, 
            let row = Int(components[0]), 
            let col = Int(components[1]), 
            row >= 0, 
            row < boardSize, 
            col >= 0, 
            col < boardSize 
        {
            return (row, col)
        }
        print("Invalid input. Please enter a valid row and column.")
        return getPlayerMove() //Recurse until valid input is entered
    }
}

// Check for hitting a ship
func isHit(ship: (Int, Int), move: (Int, Int)) -> Bool
{
    return ship == move
}

//Execute the game
func playGame()
{
    var playerBoard = initializeBoard()
    var AIBoard = initializeBoard()

    //Place ships on the board
    let playerShip = placeShip()
    let AIShip = placeShip()
    
    var gameOver = false

    print("Welcome to Battleship game!")

    while !gameOver
    {
        // Player's turn
        print("\nYour board:")
        printBoard(playerBoard)

        let playerMove = getPlayerMove()

        if isHit(ship: computerShip, move: playerMove) {
            print("You hit the enemy ship!")
            playerBoard[playerMove.0][playerMove.1] = hit
            gameOver = true
            print("Congratulations! You win!")
        } else {
            print("You missed!")
            playerBoard[playerMove.0][playerMove.1] = miss
        }

        if gameOver { break }

        // AI's turn
        let AIMove = placeShip()  // The AI makes a random move

        print("\nComputer's turn:")
        if isHit(ship: playerShip, move: AIMove) {
            print("Computer hit your ship at \(AIMove.0), \(AIMove.1)!")
            AIBoard[AIMove.0][AIMove.1] = hit
            gameOver = true
            print("Game over! Computer wins!")
        } else {
            print("Computer missed at \(AIMove.0), \(AIMove.1)!")
            AIBoard[AIMove.0][AIMove.1] = miss
        }
    }

        print("\nFinal board state:")
        printBoard(playerBoard)
}
playGame()