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
This is a generalised version of the original quick-and-dirty program
I wrote specifically to put the colons into a MAC address every two
characters.

You can now intersperse any string
of characters, and number of characters apart, not just colons every 2.

To deal with the MAC address, here's a sample interaction:
>    $ echo AABBCCDDEEFF | intersperseEvery 2 :
>    AA:BB:CC:DD:EE:FF
-}


import System.IO (hPutStrLn, stderr)
import System.Environment (getProgName, getArgs)
import System.Exit (exitFailure, exitSuccess)
import Data.List (intercalate, concat)
import Data.List.Split (chunksOf)

{-
intercalateEvery does the deed.  Everything else in this program
is for argument parsing, I/O and user error handling.
-}
intercalateEvery :: Int -> [a] -> [a] -> [a]
intercalateEvery n sep = (intercalate sep) . (chunksOf n)


main = do
    args <- argParseIO
    case args of
        Left error -> failWithUsage error
        Right (num, sep) ->
                interactLines $ map $ intercalateEvery num sep


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

usagePat = "num separator"

failWithUsage :: String -> IO ()
failWithUsage errorStr = do
            name <- getProgName
            hPutStrLn stderr $ name ++ ": " ++ errorStr
            hPutStrLn stderr $ "Usage: " ++ name ++ " " ++ usagePat
            exitFailure

