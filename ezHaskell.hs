{- 변수 작성 방법 -}
r = 5
pi * r^2 -- 하스켈 라이브러리에 pi가 존재해서 넓이를 계산해줌
y = x * 2 -- x가 정해지지 않았기에 오류가 난다.
x = 3
y = x * 2 --x가 정해졌으므로 오류가 나지 않는다.
r = r + 1 -- 5 = 5 + 1로 이해하기에 작성할 수 없다. (ctrl + c로 빠져나온다.)


{- 함수 만드는 방법 -}
area r = pi * r ^ 2 -- 변수 r을 받아서 pi x r^2(원넓이를 구해준다.)

area 5 -- 이런 형식으로 사용가능하다.
area 16


{- 표현식의 해석 -}
5 * 3 + 2       -- 15 + 2 = 17 (곱셈을 덧셈보다 먼저)
5 * (3 + 2)     -- 5 * 5 = 25 (괄호 덕분에)
area 5 * 3      -- (area 5) * 3
area (5 * 3)    -- area 15


{- area 5를 입력하면 일어나는 일 -}
area 5 -- 좌변에 입력된 값(area r)을 우변에 해당 값에 대입한다. = pi * r^2
pi * 5^2 -- pi를 숫자로 바꿔준다.
3.141592653589793 * 5^2 -- ^연산을 수행한다.
3.141592653589793 * 25 -- *연산을 수행한다.
78.53981633974483 -- 결과(즉, 단일값이 나올 때까지 연산을 수행한다.)


{- 다중 매개변수 -}
-- 인자를 공백(space)으로 구분하므로, 공백에 민감하다.
areaRect l w = l * w -- l, w를 받아 직사각형의 넓이를 표현해준다.
areaTriangle b h = (b * h) / 2 -- b, h를 받아삼각형의 넓이를 표현해준다.


{- 합성 함수 -}
-- 앞서 만든 함수들을 이용하여 새로운 함수를 정의할 수 있다.
areaSquare s = areaRect s s
-- 정사각형은 단지 두 변의 길이기 같은 직사각형이다.


{- 지역 정의(local definition)-}
-- 헤론의 공식은 삼각형의 변 a, b, c로 넓이를 구하는 공식이다.
heron a b c = sqrt (s * (s - a) * (s - b) * (s - c)) 
    where 
    s = (a + b + c) / 2 -- cmd에서 실행할 때는 한 줄로 실행해 주어야 한다.

-- where을 통해 지역정의를 하므로써 필요한 변수를 충족시켜준다.
areaTriangleTrig  a b c = c * height / 2
    where
    cosa   = (b ^ 2 + c ^ 2 - a ^ 2) / (2 * b * c)
    sina   = sqrt (1 - cosa ^ 2)
    height = b * sina
areaTriangleHeron a b c = result
    where
    result = sqrt (s * (s - a) * (s - b) * (s - c))
    s      = (a + b + c) / 2

{- 비교 -}
2 + 3 == 5 -- True
7 + 3 == 5 -- False
f x = x + 3 -- 함수를 정의해서 비교하면
f 2 == 5 -- True f 2는 2 + 3으로 평가된다.



{- 타입 입문 -}
True == True -- True와 False는 블리언값으로 Haskell안에서도 실존한다.
4 + 9 == 13 -- True 이 식은
(==) (4 + 9) 13 -- True와 같이 사용할 수 있다.


{- 블리언 연산 -}
(3 < 8) && (False == False) -- True
(&&) (6 <= 5) (1 == 1) -- False
not (5 * 2 == 10) -- False not을 사용하면 블리언 값의 반전(negation)을 수행한다.
x /= y = not (x == y) -- /= 연산자는 haskell에 이미 존재하지만, 이렇게 직접 구현 할 수도 있다.


{- 가드(guard) -}
-- 가드를 이용하면 불리언 값에 기반해 축약된 구문을 작성할 수 있다.
-- |x|를 구현해보자
absolute x
    | x < 0     = -x
    | otherwise = x
-- x >= 0도 잘 작동하지만 otherwise를 사용해도 잘 동작한다.
-- 2차 방정식$ ax^2 + bx + c$의 (실수인) 해의 개수를 구하는 공식이다.
numOfSolutions a b c
    | disc > 0  = 2
    | disc == 0 = 1
    | otherwise = 0
        where
        disc = b^2 - 4*a*c
-- 이렇게 작성하면 disc의 표년식을 여러번 작성하지 않아도 된다.


{- 타입 기초-}
:type True -- True :: Bool
:t (3 < 5) -- (3 < 5) :: Bool
-- :t는 :type의 약자로 해당 값에 type을 알려준다.
:t 'H' -- 'H' :: Char
:t "Hello World" -- "Hello World" :: [Char]
-- 하스켈은 모든 문자열을 문자들의 리스트로 취급한다.


{- chr와 ord 함수 -}
-- chr 함수는 num -> char
-- ord 함수는 char -> ord
:m Data.Char -- Char 모듈 호출
chr 97
ord 'c'


{- 인자가 둘 이상인 함수 -}
xor p q = (p || q) && not (p && q)
-- xor은 배타적 or 함수로, 두 인자 중 하나만 True인 경우 True로 평가하고, 그 외의 경우는 False로 평가한다.
xor True False


{- 리스트 -}
let numbers = [1,2,3,4]
let truths = [True, False, False]
let strings = ["here", "are", "some", "strings"]
let mixed = [True, "bonjour"] -- 타입이 섞이면 타입오류
0:numbers -- [0,1,2,3,4] 리스트에 컨싱(ocns)한다.
5:4:3:2:1:0:numbers -- [5,4,3,2,1,0,1,2,3,4] 여러개를 컨싱(cons)해도 numbers라는 리스트에 원소가 바뀌는 것은 아니다.


{- 문자열은 리스트일 뿐이다. -}
"hey" == ['h','e','y'] -- True


{- 리스트 안의 리스트 -}
let listOfLists = [[1,2],[3,4],[5,6]]
listOfLists -- [[1,2],[3,4],[5,6]]


{- 튜플 -}
-- 튜플은 고정된 개수의 원소를 가진다. 컨싱(cons) 불가능
-- 튜플의 원소들은 같은 타입일 필요가 없다.
tupleX = (4, 5, "Six", True, 'b')
tupleX -- (4, 5, "Six", True, 'b')


{- 튜플 중첩 -}
-- 튜플과 리스트는 중첩이 가능하다.
((2,3), True)
((2,3), [2,3])
[(1,2), (3,4), (5,6)]
-- 튜플의 타입은 그 크기뿐 아니라, 리스트와 마찬가지로 그 튜플이 포함하고 있는 객체들의 타입도 고려해서 정의된다.
-- [("a",1),(2,"b"),(9,"c")] 같은 리스트를 가질 수 없다.(튜플 안에 있는 value의 type이 일치하지 않음)


{- 값 획득하기 -}
-- fst와 snd 함수 : fst(첫번째 값) snd(두번째 값)
fst (2, 5) -- 2
fst (True, "boo") -- True
snd (5, "Hello") -- Hello
-- 비슷하게 작동하는 head와 tail함수가 있지만, 이 둘은 빈리스트를 인자로 받는 순간 프로그램이 고장나서 위험하다.


{- 다형성 타입 -}
head [True, False] -- True
head ["hey", "my"] -- hey
-- head는 다형 타입이므로 Int, String, Bool에대한 값을 반환해 줄 수 있다.

:t head -- head :: [a] -> a 하스켈은 a에 어떤 타입이든 사용한다.


{- if / then / else -}
-- 하스켈은 for, while은 없지만, if / then / else 형태의 흔한 조건 표현식을 지원한다.
mySignum x =
    if x < 0 
        then -1
        else if x > 0
            then 1
            else 0

-- 하스켈의 특징은 if then else를 끝까지 다 써주어야 한다는 점이다.
mySignum 5 -- 1
mySignum 0 -- 0
mySignum (5-10) -- -1
mySignum (-1) -- -1 ()괄호에 무조건 넣어주어야한다.

-- 가드를 이용해도 똑같은 함수를 만들 수 있다.
mySignum1 x
    | x < 0     = -1
    | x > 0     = 1
    | otherwise = 0


{- 패턴 매칭 도입 -}
-- 승자는 10점 2등은 6점 3등은 4점 4등은 3점 5등은 2점 6등은 2점 나머지는 0점인 게임을 만들 때,
pts :: Int -> Int
pts 1 = 10
pts 2 = 6
pts 3 = 4
pts 4 = 3
pts 5 = 2
pts 6 = 1
pts _ = 0
-- 이렇게 쓸 수 있다.
pts :: Int -> Int
pts 1 = 10
pts 2 = 6
pts x
    | x <= 6    = 7 - x
    | otherwise = 0
-- 패텬 매칭은 gard나 if문과 혼합해서 사용도 가능하다.


{-let 바인딩-}
-- let 바인딩은 지역선언을 위한 where 절의 대체문이다.
roots a b c =
    let sdisc = sqrt (b*b - 4*a*c)
        twice_a = 2*a
    in  ((-b + sdisc) / twice_a,
         (-b - sdisc) / twice_a)
-- let키워드로 지역선언을 한 후 in함 수를 사용하면 원래 구문으로 돌아온다는 신호이다.


{- 함수 합성 -}
f x = x + 3s
square x = x^2
-- 이 두 함수의 합성순서에 따라 결과값이 다르다.
square (f 1) -- 16 함수 안에 함수를 쓸경우 반드시 ()괄호로 묶어주어야한다.
square (f 2) -- 25
f (square 1) -- 4
f (square 2) -- 7

{- Prelude와 라이브러리 -}
import Data.List
testPermutations = permutations "Prelude" -- prelude는 유용한 함수들을 많이 제공한다.
:m +Data.List -- 모듈을 불러온다.
:t permutations -- permutations :: [a] -> [[a]]
-- words 함수. 문자열을 공백으로 구분된 낱말들로 믿을 만하게 쪼개서 문자열들의 리스트를 반환한다.
-- reverse 함수. 리스트를 뒤집는다(우연히도 위의 reverseList가 하는 일이다).
-- unwords 함수. words의 반대되는 일을 한다.
revWords input = (unwords . reverse . words) input
revWords = "Hello This is Haskell" -- Haskell is This Hello

{- 간단한 입출력 IO 타입 -}
-- putStrLn은 표준 Prelude 함수이다.
putStrLn "Hello, World!" -- Hello, World

-- do를 이용해서 
main = do
  putStrLn "Please enter your name: "
  name <- getLine
  putStrLn ("Hello, " ++ name ++ ", how are you?")
