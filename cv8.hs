-- myZip xs ys = zs, zs je seznam dvojic (x_i, y_i) pro x_i, y_i z x, y
myZip :: [a] -> [b] -> [(a, b)]
myZip (x:xs) (y:ys) = (x, y):myZip xs ys
myZip _ _ = []

-- myZipWith -- umoznuje navic specifikovat funkci, ktera se pouzije na dvojice
-- misto vytvoreni dvojice
myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith f (x:xs) (y:ys) = f x y:myZipWith f xs ys
myZipWith _ _ _ = []

-- to same pomoci map, zip; ukazka uncurry
myZW :: (a -> b -> c) -> [a] -> [b] -> [c]
myZW f xs ys = map (uncurry f) (zip xs ys)

-- partition p xs = (t, f), v t jsou prvky z xs,
-- pro ktere plati p, v f jsou ostatni prvky z xs
-- ukazka lokalni definice a pattern matchingu uvnitr funkce pomoci where klauzule
partition :: (a -> Bool) -> [a] -> ([a], [a])
partition p [] = ([], [])
partition p (x:xs) | p x = (x:ts, fs)
                   | otherwise = (ts, x:fs)
            where
                (ts, fs) = partition p xs

-- jako partition, ale pomoci let klauzule misto where
p2 :: (a -> Bool) -> [a] -> ([a], [a])
p2 p [] = ([], [])
p2 p (x:xs) = let (ts, fs) = p2 p xs in 
    if p x then (x:ts, fs) else (ts, x:fs)

-- quicksort - ukazka (++) (spojeni seznamu) a list comprehensions
qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x:xs) = qsort mensi ++ x:qsort vetsi
    where 
        mensi = [y | y <- xs, y <= x]
        vetsi = [y | y <- xs, y > x]