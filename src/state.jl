mutable struct State
    s::UInt32
end

forward!(s::State) = (s.s += 1; )
back!(s::State) = (s.s -= 1;)
