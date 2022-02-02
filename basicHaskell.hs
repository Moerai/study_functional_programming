{- 재귀함수-}
-- 하스켈은 for, while이 없어 재귀함수를 통해 반복문을 수행한다.
factorial 0 = 1
factorial n = n * factorial (n-1) -- n!을 계산한다.
let { factorial 0 = 1 ; factorial n = n * factorial (n - 1) }
--한줄로 적으면 이렇게 된다.

-- C로 작성한 루프문
-- int factorial(int n) {
--   int res = 1;
--   for ( ; n > 1; n--)
--     res *= n;
--   return res;
-- }

-- 하스켈로 따라해본 루프문
factorial n = go n 1
    where
    go n res
        | n > 1     = go (n - 1) (res * n)
        | otherwise = res
-- go는 실제로 계승 계산을 수행하는 보조 함수다.
-- go는 여분의 인자 res를 취하는데 res는 최종 결과를 쌓아올리기 위한 누적 매개변수로 쓰였다.
-- 하스켈은 재귀를 최적화 시켰고 게으르기 때문에 퍼포먼스 문제를 어느정도 회피 할 수 있었다.


{- 다른 재귀 함수들 -}
-- 곱셈은 덧셈의 연속이다.
mult n m = (mult n (m - 1)) + n


{- 리스트 기반의 재귀 -}
length :: [a] -> Int
length []     = 0
length (x:xs) = 1 + length xs
-- 리스트의 길이를 알려주는 재귀함수

-- 하지만 직접 재귀를 작성할 일은 적다.
-- 표준라이브러리 함수를 자주 쓰기 때문이다.
factorial n = product [1..n]
-- 계승을 표준라이브러리 함수로 구현한 예제


{- 리스트 재구축하기 -}
doubleList :: [Integer] -> [Integer]
doubleList [] = []
doubleList (n:ns) = (2 * n) : doubleList ns
-- 리스트를 받아서 원소 값을 두배로 만들어서 돌려준다.
doubleList [1,2,3,4] -- [2,4,6,8]


multiplyList :: Integer -> [Integer] -> [Integer]
multiplyList _ [] = []
multiplyList m (n:ns) = (m*n) : multiplyList m ns
-- 리스트를 받아서 원소 값에 m을 곱해서 반환한다.
multiplyList 17 [1,2,3,4] -- [17,34,51,68]

{- map 함수로 일반화하기 -}
multiplyList m = map ((*) m)
-- 별 노력없이 구현 가능
heads = map head


{- 리스트 원소 축약 -}
[1,2,3..10] -- [1,2,3,4,5,6,7,8,9,10]
[1..] -- 무한 리스트
-- 하스켈은 게으른 언어기 때문에 무한 리스트가 존재할 수 있다.


{- 접기(fold) -}
