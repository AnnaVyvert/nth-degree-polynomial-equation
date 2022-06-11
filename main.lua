limits={-100,100}
eps=0.000001;
polynom={1,1.7,1,1,-10}

function solveHord(arr, borders, difa)
  for i=1,#borders,2 do
    a=borders[i]
    b=borders[i+1]
    print("searching on interval ["..a..";"..b..']')
    fa = fx(arr, a)
    fb = fx(arr, b)
    fdifa=fx(difa, a)
    repeat
      a = a-fa/fdifa
      b = a-fa*(b-a)/(fb-fa)
      fa = fx(arr, a)
      fb = fx(arr, b)
      fdifa=fx(difa, a)
    until a-b<eps
    print("x"..((i+1)/2)..' = '..a)
  end
end

function difference(arr)
  difa={}
  for i=1,#arr-1 do
    difa[i]=arr[i]*(#arr-i)
  end
  return difa
end

function outputArray(a)
  for i=1,#a-1 do
    io.write(a[i].."x^"..(#a-i)..'+')
  end
  io.write(a[#a].."=0".."\n")
  -- print("arr: "..table.concat(a,"x+"))
end

function checkCrossing(borders)
  if next(borders)==nil then
    print("equation has no solution.")
    print("exiting...")
    os.exit()
  end
end

function fx(arr, x)
  sum=0
  for i=1,#arr do
    -- print(math.pow(x,(#arr-i)).."=x^"..(#arr-i))
    sum=sum+arr[i]*math.pow(x,(#arr-i))
  end
  -- print(sum)
  return sum
end

function findBorders(a)
  dt=0.1
  borders = {}
  borderIndex=1
  for i=limits[1],limits[2],dt do
    if fx(a, i) > 0 and fx(a, i-dt) < 0 or fx(a, i) < 0 and fx(a, i-dt) > 0 then
      -- io.write(i-dt..'|'..i..'\n')
      borders[borderIndex]=i-dt
      borders[borderIndex+1]=i
      borderIndex=borderIndex+2
    end
  end
  -- print("solutions borders: "..table.concat(borders,","))
  return borders
end

io.write("original equation:     ")
outputArray(polynom)
checkCrossing(polynom)
borders = findBorders(polynom)
checkCrossing(borders)
difa = difference(polynom)
io.write("differential equation: ")
outputArray(difa)
solveHord(polynom, borders, difa)
