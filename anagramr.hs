import Data.List
import System.Environment


permOf ""     "" = True
permOf (x:xs) t  = elem x t && permOf xs (delete x t)
permOf _      _  = False


main = do
    words <- readFile "/usr/share/dict/words"
    (t:_) <- getArgs
    let anagrams = delete t [w | w <- lines words, permOf w t]
    mapM_ putStrLn anagrams