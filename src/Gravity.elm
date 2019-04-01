module Gravity exposing (Object, Vector, process)


g =
    6.67408e-11


type alias Vector =
    { x : Float, y : Float }


type alias Object =
    { color : String
    , pos : Vector
    , velocity : Vector
    , acceleration : Vector
    , mass : Float
    }


vector_addition : Vector -> Vector -> Vector
vector_addition first second =
    Vector (first.x + second.x) (first.y + second.y)


clear_acceleration : Object -> Object
clear_acceleration object =
    { object | acceleration = Vector 0 0 }


get_pos : Object -> ( Float, Float )
get_pos object =
    ( object.pos.x, object.pos.y )


get_mass : Object -> Float
get_mass object =
    object.mass


get_vector_distance : Object -> Object -> ( Float, Float )
get_vector_distance first second =
    let
        ( x1, y1 ) =
            first |> get_pos

        ( x2, y2 ) =
            second |> get_pos
    in
    ( x2 - x1, y2 - y1 )


get_scalar_quadro_distance : ( Float, Float ) -> Float
get_scalar_quadro_distance ( dx, dy ) =
    let
        result =
            dx ^ 2 + dy ^ 2
    in
    if result < 10 then
        10

    else
        result


calc_scalar_acceleration : Object -> Object -> Float
calc_scalar_acceleration first second =
    (g * get_mass second) / get_scalar_quadro_distance (get_vector_distance first second)


calc_vector_acceleration : Object -> Object -> ( Float, Float )
calc_vector_acceleration first second =
    let
        a =
            calc_scalar_acceleration first second

        r =
            sqrt (get_scalar_quadro_distance (get_vector_distance first second))

        ( dx, dy ) =
            get_vector_distance first second
    in
    ( a * dx / r, a * dy / r )


process_part : List Object -> Int -> Object -> Object
process_part data index object =
    data
        |> List.indexedMap (\i -> \obj -> ( i, obj ))
        |> List.foldl
            (\( i, current ) ->
                \acc ->
                    if i == index then
                        acc

                    else
                        let
                            ( ax, ay ) =
                                calc_vector_acceleration object current
                        in
                        { acc | acceleration = vector_addition acc.acceleration (Vector ax ay) }
            )
            object


calc_set_velocity : Float -> Object -> Object
calc_set_velocity dt object =
    { object
        | velocity =
            Vector (object.velocity.x + object.acceleration.x * dt)
                (object.velocity.y + object.acceleration.y * dt)
    }


calc_position : Float -> Object -> Object
calc_position dt object =
    { object
        | pos =
            Vector (object.pos.x + object.velocity.x * dt)
                (object.pos.y + object.velocity.y * dt)
    }


process : Float -> List Object -> List Object
process dt data =
    data
        |> List.map clear_acceleration
        |> List.indexedMap (process_part data)
        |> List.map (calc_set_velocity dt)
        |> List.map (calc_position dt)
