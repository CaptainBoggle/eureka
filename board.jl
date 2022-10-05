# board.jil
function square(square_name::String)
    @assert length(square_name) == 2
    file = parse(Int8, square_name[1]-48)
    row = parse(Int8, square_name[2])
    square(file, row)
end
struct Board
    black_pawns::UInt64
    white_pawns::UInt64
    side_to_move::Bool
end

Board() = Board(0,0,0)


function set!(b::Board, colour, file, rank)
    if colour==1
        b.black_pawns |= square(file, rank)
    else
        b.white_pawns |= square(file, rank)
    end
    nothing
end


function new_game()
    b = Board()
    for file in 1:5
        set!(b, 0, file, 1)
        set!(b, 1, file, 5)
    end
    b.side_to_move=0
end

function show(b::Board)
    for rank in 5:-1:1
        for file in 1:5
            if b.black_pawns & square(file, rank) != 0
                print("B")
            elseif b.white_pawns & square(file, rank) != 0
                print("W")
            else
                print(".")
            end
        end
        println()
    end
end

new_game()
show(b)