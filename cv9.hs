-- foldl je levy fold - foldl (+) 0 [1,2,3] = ((0+1)+2)+3
myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl f acc [] = acc
myFoldl f acc (x:xs) = myFoldl f (f acc x) xs

-- foldr je pravy fold - foldr (+) 0 [1,2,3] = 1+(2+(3+0))
myFoldr :: (b -> a -> a) -> a -> [b] -> a
myFoldr f acc [] = acc
myFoldr f acc (x:xs) = f x (myFoldr f acc xs)

-- Barva je typ, ktery muze mit tri ruzne hodnoty
data Barva = Cervena | Zelena | Modra deriving Show

-- s vlastnimi typy muzeme pracovat stejne jako se standardnimi
barvaNaRGB :: Barva -> (Int, Int, Int)
barvaNaRGB Cervena = (255, 0, 0)
barvaNaRGB Zelena  = (0, 255, 0)
barvaNaRGB Modra   = (0, 0, 255)
--barvaNaRGB (RGB r g b) = (r, g, b)

-- BarvaRGB navic muze kodovat RGB trojici
data BarvaRGB = CervenaRGB | ZelenaRGB | ModraRGB 
                | RGB Int Int Int deriving Show
rgbNaBarvu :: (Int, Int, Int) -> BarvaRGB
rgbNaBarvu (255, 0, 0) = CervenaRGB
rgbNaBarvu (0, 255, 0) = ZelenaRGB
rgbNaBarvu (0, 0, 255) = ModraRGB
rgbNaBarvu (r, g, b) = RGB r g b

-- vlastni definice rekurzivniho typu - Seznam
-- ma dva konstruktory - Cons bere prvek a Seznam a vytvari Seznam
-- Nil je prazdny seznam
data Seznam a = Cons a (Seznam a) | Nil deriving Show

-- implementace mapu s (:) psanou prefixove
myMap :: (t -> a) -> [t] -> [a]
myMap _ []     = []
myMap f ((:) x xs) = (:) (f x) (myMap f xs)

-- implementace mapu pro nas Seznam, tentokrat je Cons pouzit infixove
mapS :: (t -> a) -> Seznam t -> Seznam a
mapS _ Nil         = Nil
mapS f (x `Cons` xs) = f x `Cons` mapS f xs

-- prevod standardniho seznamu na nas seznam - staci nahradit (:) za Cons a [] za Nil
udelejSeznam::[a] -> Seznam a
udelejSeznam = foldr Cons Nil

-- myFoldr f acc [] = acc
-- myFoldr f acc (x:xs) = f x (myFoldr f acc xs)

-- implementace foldr pro nase seznamy s maly trikem na zkraceni zapisu 
-- f je vlastne funkce foldrS fCons FNil
foldrS :: (t -> p -> p) -> p -> Seznam t -> p
foldrS fCons fNil = f 
    where 
        f Nil = fNil
        f (Cons x xs) = fCons x (f xs)

-- ukazka dalsi rekurzivni struktury - binarni strom
data Strom a = Uzel (Strom a) a (Strom a) | SNil 
                deriving Show

-- pridani prvku do naseho stromu (braneho jako BVS)
pridejBVS :: Ord a => a -> Strom a -> Strom a
pridejBVS x SNil = Uzel SNil x SNil
pridejBVS x (Uzel lp h pp) | x < h     = Uzel (pridejBVS x lp) h pp
                           | otherwise = Uzel lp h (pridejBVS x pp)