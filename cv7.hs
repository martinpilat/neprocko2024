-- implementace faktorialu
fac :: Integer -> Integer
fac 0 = 1
fac n | n >= 0     = n* fac (n-1)
      | otherwise  = undefined

-- implementace funkce map - aplikuje zadanou funkci postupne na vsechny prvky 
-- seznamu a vrati seznam vysledku
myMap :: (t -> a) -> [t] -> [a]
myMap _ []     = []
myMap f (x:xs) = f x:myMap f xs

-- secteni dvou cisel (implementovane pro ukazku na cvicenich a trochu nize)
plus :: Integer -> Integer -> Integer
plus = (+)

-- plus5 pricita 5 k zadanemu cislu - je definovana jako plus s pevne danym
-- prvnim parametrem
plus5 :: Integer -> Integer
plus5 = plus 5

-- map s napevno danou funkci - aplikuje faktorial na vsechny prvky zadaneho
-- seznamu
mapFac :: [Integer] -> [Integer]
mapFac = map fac

-- filter - dostane podminku a seznam a vrati seznam, ktery obsahuje prvky 
-- ze zadaneho, ktere splnuji zadanou podminku
myFilter :: (a -> Bool) -> [a] -> [a]
myFilter p [] = []
myFilter p (x:xs) | p x       = x:myFilter p xs
                  | otherwise = myFilter p xs