describe(emptyList, "Empty list",
    setup(
        e := list
    )

    emptyList("should one argument reduce to nil",
        e reduce(+) verify(== nil)
    )
    emptyList("should one argument reverseReduce to nil",
        e reverseReduce(+) verify(== nil)
    )
    emptyList("should three argument reduce to nil",
        e reduce(x, y, x + y) verify(== nil)
    )
    emptyList("should three argument reverseReduce to nil",
        e reverseReduce(x, y, x + y) verify(== nil)
    )
)


describe(oneItemList, "Single element list",
    setup(
        value := 42
        s := list(value)
    )

    oneItemList("should support one argument reduce",
        s reduce(-) verify(== value)
    )

    oneItemList("should support three argument reduce",
        s reduce(x, y, x - y) verify(== value)
    )

    oneItemList("should support one argument reverseReduce",
        s reverseReduce(-) verify(== value)
    )

    oneItemList("should support three argument reverseReduce",
        s reverseReduce(x, y, x - y) verify(== value)
    )
)


describe(fourItemList, "Four element list",
    setup(
        a := list(6, 2, 1, 9)
    )

    fourItemList("should support one argument reduce",
        a reduce(-) verify(== -6)
    )

    fourItemList("should support three argument reduce",
        a reduce(x, y, x - y) verify(== -6)
    )

    fourItemList("should support one argument reverseReduce",
        a reverseReduce(-) verify(== -4)
    )

    fourItemList("should support three argument reverseReduce",
        a reverseReduce(x, y, x - y) verify(== -4)
    )
)
