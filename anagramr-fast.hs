{-# LANGUAGE OverloadedStrings #-}


import System.Environment
import qualified Data.List as L
import qualified Data.ByteString.Lazy.Char8 as B  


delete _ "" = ""
delete c bs = let x  = B.head bs
                  xs = B.tail bs
              in  if c == x then xs else B.cons x (delete c xs)
       

permOf "" "" = True
permOf w t = let x  = B.head w
                 xs = B.tail w
             in  B.length w == B.length t && B.elem x t && permOf xs (delete x t)


main = do
    words <- B.readFile "/usr/share/dict/words"
    (t : _) <- getArgs
    let t_ = B.pack t
        anagrams = L.delete t_ [w | w <- B.lines words, permOf w t_]
    mapM_ B.putStrLn anagrams

