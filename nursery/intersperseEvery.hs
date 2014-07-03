{-
Intersperse a separator string every num characters of each line.

Copyright (C) 2014 Nicholas Martin Booker <NMBooker@gmail.com>

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
-}

{-
Why Haskell?

Because when I decided I needed to intersperse colons every two characters
in a MAC address of form AABBCCDDEEFF to get AA:BB:CC:DD:EE:FF a Haskell
implementation is what sprang to mind first.

This is a generalised version of the original quick-and-dirty program.
You can now intersperse any string
of characters, and number of characters apart.

To deal with the MAC address, here's a sample interaction:
>    $ echo AABBCCDDEEFF | intersperseEvery 2 :
>    AA:BB:CC:DD:EE:FF
-}


import System.IO (hPutStrLn, stderr)
import System.Environment (getProgName, getArgs)
import System.Exit (exitFailure, exitSuccess)
import Control.Monad (join)
import Data.List (intersperse)
import Data.List.Split (chunksOf)

main = do
    args <- argParseIO
    case args of
        Left error -> failWithUsage error
        Right (num, sep) ->
                interactLines $ map $ intersperseEvery num sep

intersperseEvery :: Int -> [a] -> [a] -> [a]
intersperseEvery n sep = join . (intersperse sep) . (chunksOf n)

{-
Useful abstraction over standard library 'interact' function.
-}
interactLines :: ([String] -> [String]) -> IO ()
interactLines f = interact $ unlines . f . lines


{-
Functions for handling command line arguments and telling the user
when they're invalid.
-}

argParseIO :: IO ( Either String (Int, String) )
argParseIO = getArgs >>= (return . argParse)

argParse :: [String] -> (Either String (Int, String))
argParse [numStr, separator]
    | [(num,_)] <- reads numStr =
        if num >= 1
            then Right (num, separator)
            else Left "ERROR: num must be 1 or higher"
argParse _ = Left "ERROR: Incorrect number or type of arguments"


failWithUsage :: String -> IO ()
failWithUsage errorStr = do
            name <- getProgName
            hPutStrLn stderr $ name ++ ": " ++ errorStr
            hPutStrLn stderr $ usage name
            exitFailure

usage :: String -> String
usage progName = "Usage: " ++ progName ++ " num separator"
