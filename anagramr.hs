import Data.List
import System.Environment

wordsFile = "/usr/share/dict/words"

permOf :: String -> String -> Bool
permOf "" "" = True
permOf (x:xs) t = elem x t && permOf xs (delete x t)
permOf _ _ = False

main = do
    words <- readFile wordsFile
    (t:_) <- getArgs
    let anagrams = delete t [w | w <- lines words, permOf w t]
    mapM_ putStrLn anagrams
