module Main where

import RandomExample
import RandomExample2

newtype Moi s a =
  Moi { runMoi :: s -> (a, s) }

instance Functor (Moi s) where
  fmap f (Moi g) = Moi $ \s -> 
    let (x, s') = g s
     in (f x, s')

instance Applicative (Moi s) where
  pure a = Moi $ \s -> (a, s) 
  (Moi f) <*> (Moi g) =  Moi $ \s ->
    let (h, s')  = f s
        (x, s'') = g s'
     in (h x, s'')

instance Monad (Moi s) where
  return = pure
  Moi f >>= g = Moi $ \s ->
    let (a, s0) = f s
        (Moi h) = g a
     in h s0

main :: IO ()
main = do
  putStrLn "hello world"
