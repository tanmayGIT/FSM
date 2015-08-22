function SparceDTW()

LowerBound = 0;
UpperBound = Res;
for LowerBound = 0:0.1:(1-(Res/2))
    IdxS = find(LowerBound <= sDash <= UpperBound);
    IdxQ = find(LowerBound <= qDash <= UpperBound);
    LowerBound = LowerBound + (Res/2);
    UpperBound = LowerBound + Res;
end
