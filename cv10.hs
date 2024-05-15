data Strom a = Uzel (Strom a) a (Strom a) | Nil 
                deriving Show

-- pridani prvku do naseho stromu (braneho jako BVS)
pridejBVS :: Ord a => a -> Strom a -> Strom a
pridejBVS x Nil = Uzel Nil x Nil
pridejBVS x (Uzel lp h pp) | x < h     = Uzel (pridejBVS x lp) h pp
                           | otherwise = Uzel lp h (pridejBVS x pp)

foldTree fUzel fNil Nil = fNil
foldTree fUzel fNil (Uzel lp h pp) = 
    fUzel (foldTree fUzel fNil lp) h (foldTree fUzel fNil pp)

foldTree2 fUzel fNil = f
    where 
        f Nil = fNil
        f (Uzel lp h pp) = fUzel (f lp) h (f pp)
