# board.jil
function square(file::Int64, rank::Int64)
    return UInt32(1 << (rank*5 + file))
end

mutable struct Board
    black_pawns::UInt32 # maybe better off a bitarray? or even an array of bools?
    white_pawns::UInt32 
    side_to_move::Bool
end

Board() = Board(0,0,0)


function set!(b::Board, colour, file, rank)
    if colour==-1
        b.black_pawns |= square(file, rank)
    else
        b.white_pawns |= square(file, rank)
    end
    nothing
end

function str_to_square(s::String)
    file = s[1] - 'a'
    rank = s[2] - '1'
    return square(file, rank)
end

function new_game()
    b = Board()
    for file in 0:4
        set!(b, 1, file, 0)
        set!(b, -1, file, 4)
    end
    b.side_to_move=0
    return b
end

function print_board(b::Board)
    for rank in 4:-1:0
        for file in 0:4
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

function is_won(b::Board)
    # not sure if its faster to OR the whole thing and check for change, or to first extract the relevant bits and then check for change
    if b.black_pawns & 31 != 31
        return -1
    elseif b.white_pawns & 32505856 != 32505856
        return 1
    else
        return 0
    end
end

function fill_board()
    b = Board()
    for rank in 4:-1:0
        for file in 0:4
            set!(b, 1, file, rank)
            set!(b, -1, file, rank)
        end
    end
    b.side_to_move=0
    return b
end

b = new_game()
print_board(b)


b.white_pawns ⊻= (b.white_pawns | (b.white_pawns << 1))
print(bitstring(b.white_pawns ⊻ (b.white_pawns | (b.white_pawns << 2))))
