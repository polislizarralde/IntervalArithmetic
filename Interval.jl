# Interval Library
import Base.==
using Base.Test

type Interval
    left::Float64
    right::Float64
end

type EmptyInterval
end

function ==(a::Interval, b::Interval)
    return a.left == b.left && a.right == b.right
end

function ==(a::EmptyInterval, b::EmptyInterval)
    return true
end

function ==(a::Interval, b::EmptyInterval)
    return false
end

function ==(a::EmptyInterval, b::Interval)
    return false
end

function createInterval(a, b)
    left = convert(Float64,a)
    right = convert(Float64,b)
    if left <= right
        return Interval(left,right)
    else
        error("left > right this not define an interval")
    end
end

function intersection(X::Interval,Y::Interval)
    if X.right <= Y.left || Y.right <= X.left
        return EmptyInterval()
    else
        a = max(X.left, Y.left)
        b = min(X.right, Y.right)
        return Interval(a, b)
    end
end

function intersection(X::EmptyInterval, Y::Interval)
    return EmptyInterval()
end

function intersection(X::Interval, Y::EmptyInterval)
    return EmptyInterval()
end

function intersection(X::EmptyInterval, Y::EmptyInterval)
  return EmptyInterval()
end

#Definition the interval hull
function intervalHull(X::Interval, Y::Interval)
    a = min(X.left, Y.left)
    b = max(X.right, Y.right)
    return Interval(a,b)
end

function intervalHull(X::EmptyInterval, Y::Interval)
    return Interval(Y.left, Y.right)
end

function intervalHull(X::Interval, Y::EmptyInterval)
    return Interval(X.left, X.right)
end

function intervalHull(X::EmptyInterval, Y::EmptyInterval)
  return EmptyInterval()
end

function ∪(X::Interval, Y::Interval)
  return Interval(X.left,Y.right)
end

# Testing

@test createInterval(-1, 10) == Interval(-1., 10.)
